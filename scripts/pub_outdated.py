#!/usr/bin/env python3
"""
Flutter Leaf Kit - Pub Outdated Script

각 패키지에서 dart pub outdated 명령어를 실행하여 의존성 상태를 확인합니다.

Usage:
    pub-outdated                       # 모든 패키지
    pub-outdated --package leaf_core # 특정 패키지만
"""

import os
import subprocess
import argparse
from pathlib import Path


def get_project_root() -> Path:
    """프로젝트 루트 디렉토리 반환"""
    return Path(__file__).parent.parent


def get_packages(project_root: Path, package_filter: str = None) -> list[Path]:
    """packages/ 디렉토리에서 패키지 목록 반환"""
    packages_dir = project_root / "packages"

    # pubspec.yaml이 있는 디렉토리만 패키지로 인식
    packages = []
    for pubspec in packages_dir.glob("*/pubspec.yaml"):
        package_dir = pubspec.parent
        package_name = package_dir.name

        if package_filter:
            if package_filter in package_name:
                packages.append(package_dir)
        else:
            packages.append(package_dir)

    return sorted(packages)


def run_pub_outdated(package_dir: Path) -> None:
    """패키지 디렉토리에서 dart pub outdated 실행"""
    print()
    print("=" * 60)
    print(f" {package_dir.name}")
    print("=" * 60)
    print()

    try:
        subprocess.run(
            ["dart", "pub", "outdated"],
            cwd=package_dir,
            text=True,
        )
    except FileNotFoundError:
        print("  Error: 'dart' command not found. Please ensure Dart SDK is installed.")
    except Exception as e:
        print(f"  Error: {e}")


def main():
    parser = argparse.ArgumentParser(
        description="Flutter Leaf Kit - Pub Outdated Script"
    )
    parser.add_argument(
        "--package",
        type=str,
        help="특정 패키지만 확인 (예: leaf_core)"
    )

    args = parser.parse_args()

    project_root = get_project_root()
    os.chdir(project_root)

    packages = get_packages(project_root, args.package)

    if not packages:
        print("패키지를 찾을 수 없습니다.")
        return

    print(f"\n{len(packages)}개의 패키지를 확인합니다...")

    for package_dir in packages:
        run_pub_outdated(package_dir)

    print()
    print("=" * 60)
    print(" 완료")
    print("=" * 60)


if __name__ == "__main__":
    main()
