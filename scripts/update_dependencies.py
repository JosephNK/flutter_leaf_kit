#!/usr/bin/env python3
"""
Flutter Packages - Dependencies Update Script

Usage:
    update-deps                        # 모든 패키지 (기본)
    update-deps --all                  # 모든 패키지 (명시적)
    update-deps --package leaf_common  # 단일 패키지
    update-deps --report               # 리포트만 출력 (업데이트 안함)
    update-deps --include-major        # Major 업데이트 포함
"""

import os
import re
import argparse
import urllib.request
import json
from pathlib import Path
from typing import Optional

import ruamel.yaml


def get_project_root() -> Path:
    """프로젝트 루트 디렉토리 반환"""
    return Path(__file__).parent.parent


def get_latest_version(package_name: str) -> Optional[str]:
    """pub.dev API에서 패키지의 최신 버전을 조회"""
    url = f"https://pub.dev/api/packages/{package_name}"
    try:
        with urllib.request.urlopen(url, timeout=10) as response:
            data = json.loads(response.read().decode())
            return data.get("latest", {}).get("version")
    except Exception:
        return None


def parse_version(version_str: str) -> str:
    """버전 문자열에서 실제 버전 추출 (^, >=, etc. 제거)"""
    match = re.match(r"[\^>=<~]*(.+)", version_str.strip())
    return match.group(1) if match else version_str


def compare_versions(current: str, latest: str) -> tuple[bool, bool]:
    """
    버전 비교하여 (업데이트 필요 여부, Major 업데이트 여부) 반환
    """
    current_clean = parse_version(current)

    def parse_semver(v: str) -> tuple:
        # +1 같은 빌드 메타데이터 제거 후 비교
        v = re.sub(r"\+.*$", "", v)
        parts = v.split(".")
        result = []
        for p in parts:
            # 숫자 부분만 추출
            num_match = re.match(r"(\d+)", p)
            result.append(int(num_match.group(1)) if num_match else 0)
        while len(result) < 3:
            result.append(0)
        return tuple(result[:3])

    try:
        curr_parts = parse_semver(current_clean)
        latest_parts = parse_semver(latest)

        needs_update = latest_parts > curr_parts
        is_major = latest_parts[0] > curr_parts[0]

        return needs_update, is_major
    except Exception:
        return False, False


def get_packages(
    project_root: Path, package_filter: Optional[str] = None
) -> list[Path]:
    """워크스페이스 pubspec.yaml의 workspace 항목을 기반으로 pubspec.yaml 파일 목록 반환"""
    results: list[Path] = []

    # 루트 pubspec.yaml에서 workspace 항목 읽기
    root_pubspec = project_root / "pubspec.yaml"
    if root_pubspec.exists():
        yaml_loader = ruamel.yaml.YAML()
        with open(root_pubspec, "r") as f:
            root_data = yaml_loader.load(f)

        workspace_entries = root_data.get("workspace", []) or []
        for entry in workspace_entries:
            entry_path = project_root / entry / "pubspec.yaml"
            if entry_path.exists():
                results.append(entry_path)

    if package_filter:
        # 패키지명으로 필터링
        filtered = []
        for result in results:
            path_str = str(result)
            if f"/{package_filter}/" in path_str or path_str.endswith(
                f"/{package_filter}/pubspec.yaml"
            ):
                filtered.append(result)
        return filtered

    return results


def analyze_dependencies(pubspec_path: Path, yaml) -> dict:
    """pubspec.yaml 파일의 dependencies 분석"""
    with open(pubspec_path, "r") as f:
        data = yaml.load(f)

    results = {
        "path": pubspec_path,
        "name": data.get("name", "unknown"),
        "dependencies": [],
        "dev_dependencies": [],
    }

    for section in ["dependencies", "dev_dependencies"]:
        deps = data.get(section, {}) or {}

        for pkg_name, version in deps.items():
            # SDK 의존성 및 내부 패키지 제외
            if pkg_name in ["flutter", "flutter_test", "flutter_web_plugins"]:
                continue
            if pkg_name.startswith("flutter_leaf"):
                continue

            # dict 형태의 의존성 (git, path 등) 제외
            if isinstance(version, dict):
                continue

            # 버전 문자열인 경우만 처리
            if isinstance(version, str):
                latest = get_latest_version(pkg_name)
                if latest:
                    needs_update, is_major = compare_versions(version, latest)
                    results[section].append(
                        {
                            "name": pkg_name,
                            "current": version,
                            "latest": latest,
                            "needs_update": needs_update,
                            "is_major": is_major,
                        }
                    )

    return results


def print_report(analysis_results: list[dict], include_major: bool = False) -> int:
    """분석 결과를 테이블 형태로 출력하고 업데이트 가능 개수 반환"""
    total_updates = 0

    for result in analysis_results:
        print()
        print("=" * 60)
        print(f"📦 {result['name']}")
        print("=" * 60)

        all_deps = result["dependencies"] + result["dev_dependencies"]

        if not all_deps:
            print("  📭 (외부 의존성 없음)")
            continue

        # 테이블 헤더
        print(f"  {'Package':<25} {'Current':<12} {'Latest':<12} {'Status':<10}")
        print(f"  {'-'*25} {'-'*12} {'-'*12} {'-'*10}")

        package_updates = 0
        for dep in all_deps:
            status = ""
            if dep["needs_update"]:
                if dep["is_major"]:
                    status = "🔴 Major"
                    if include_major:
                        package_updates += 1
                else:
                    status = "🟡 Update"
                    package_updates += 1
            else:
                status = "🟢 Latest"

            print(
                f"  {dep['name']:<25} {dep['current']:<12} {dep['latest']:<12} {status:<10}"
            )

        if package_updates > 0:
            print(f"\n  ⬆️  업데이트 가능: {package_updates}개")

        total_updates += package_updates

    print()
    print("=" * 60)
    print(f"📊 총 업데이트 가능 패키지: {total_updates}개")
    print("=" * 60)

    return total_updates


def update_pubspec(
    pubspec_path: Path, analysis: dict, yaml, include_major: bool = False
):
    """pubspec.yaml 파일의 dependencies 업데이트"""
    with open(pubspec_path, "r") as f:
        data = yaml.load(f)

    updated_count = 0

    for section in ["dependencies", "dev_dependencies"]:
        deps_to_update = analysis.get(section, [])

        for dep in deps_to_update:
            if not dep["needs_update"]:
                continue

            if dep["is_major"] and not include_major:
                continue

            pkg_name = dep["name"]
            new_version = f"^{dep['latest']}"

            if section in data and pkg_name in data[section]:
                data[section][pkg_name] = new_version
                updated_count += 1
                print(f"  ✨ {pkg_name}: {dep['current']} -> {new_version}")

    if updated_count > 0:
        with open(pubspec_path, "wb") as f:
            yaml.dump(data, f)

    return updated_count


def main():
    yaml = ruamel.yaml.YAML()
    yaml.preserve_quotes = True

    project_root = get_project_root()
    os.chdir(project_root)

    parser = argparse.ArgumentParser(
        description="Flutter Packages - Dependencies Update Script"
    )
    parser.add_argument(
        "--all", action="store_true", help="모든 패키지 업데이트 (기본값)"
    )
    parser.add_argument(
        "--package", type=str, help="특정 패키지만 업데이트 (예: package_common)"
    )
    parser.add_argument(
        "--report", action="store_true", help="리포트만 출력 (업데이트 안함)"
    )
    parser.add_argument(
        "--include-major", action="store_true", help="Major 버전 업데이트 포함"
    )

    args = parser.parse_args()

    # 패키지 목록 가져오기
    package_filter = args.package if args.package else None
    pubspec_files = get_packages(project_root, package_filter)

    if not pubspec_files:
        print("❌ pubspec.yaml 파일을 찾을 수 없습니다.")
        return

    print()
    print("🔍 Flutter Packages - Dependencies Update")
    print()
    print(f"📋 {len(pubspec_files)}개의 패키지를 분석합니다...")

    # 분석 수행
    analysis_results = []
    for pubspec_path in pubspec_files:
        print(f"  🔎 분석 중: {pubspec_path}")
        analysis = analyze_dependencies(pubspec_path, yaml)
        analysis_results.append(analysis)

    # 리포트 출력
    total_updates = print_report(analysis_results, args.include_major)

    if args.report:
        return

    if total_updates == 0:
        print("\n✅ 모든 패키지가 최신 버전입니다.")
        return

    # 업데이트 확인
    print()
    response = input("⚡ 업데이트를 진행하시겠습니까? [y/N]: ").strip().lower()

    if response != "y":
        print("\n⏭️  업데이트가 취소되었습니다.")
        return

    # 업데이트 수행
    print("\n🔄 업데이트 중...")
    total_updated = 0

    for analysis in analysis_results:
        print(f"\n📦 [{analysis['name']}]")
        updated = update_pubspec(analysis["path"], analysis, yaml, args.include_major)
        total_updated += updated

    print()
    print("=" * 60)
    print(f"🎉 총 {total_updated}개의 의존성이 업데이트되었습니다.")
    print("=" * 60)


if __name__ == "__main__":
    main()
