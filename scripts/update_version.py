#!/usr/bin/env python3
"""
Flutter Leaf Kit - Version Update Script

Usage:
    update-version                      # 대화형으로 버전 입력
    update-version 2.5.0                # 버전 직접 지정
    update-version 2.5.0 --auto-commit  # 자동 커밋
"""

import os
import argparse
import ruamel.yaml
from pathlib import Path
from git import Repo
from git.exc import GitCommandError


def get_project_root() -> Path:
    """프로젝트 루트 디렉토리 반환"""
    # 스크립트 위치 기준으로 상위 디렉토리
    return Path(__file__).parent.parent


def main():
    parser = argparse.ArgumentParser(description="Flutter Leaf Kit - Version Update Script")
    parser.add_argument("version", nargs="?", help="버전 (예: 2.5.0)")
    parser.add_argument("--auto-commit", action="store_true", default=False, help="자동 커밋 (기본값: false)")
    args = parser.parse_args()

    yaml = ruamel.yaml.YAML()
    yaml.preserve_quotes = True

    project_root = get_project_root()
    os.chdir(project_root)

    # 버전 입력 받기
    print("📦 Flutter Leaf Kit - Version Update")
    print()
    if args.version:
        update_version = args.version
        print(f"🔢 Version: {update_version}")
    else:
        update_version = input("🔢 Please enter the updated version. (ex., 1.0.0): ")

    results = list(Path("./packages").rglob("pubspec.yaml"))

    # Get Sub Package Names
    package_names = list()
    for result in results:
        file_path = str(result)
        package_name = "flutter_{}".format(
            file_path.replace("packages/", "").replace("/pubspec.yaml", "")
        )
        if "flutter_leaf_" in package_name:
            package_names.append(package_name)

    # Update Yaml
    for result in results:
        file_path = str(result)

        with open(file_path, "r") as stream:
            data = yaml.load(stream)

            data["version"] = update_version

            for sub_package_name in package_names:
                try:
                    data["dependencies"][sub_package_name]["git"][
                        "ref"
                    ] = f"v{update_version}"
                except:
                    continue

        with open(file_path, "wb") as stream:
            yaml.dump(data, stream)

    print("\n📝 Yaml files have been modified.")

    # 현재 브랜치가 develop인지 확인
    repo = Repo(project_root)
    current_branch = repo.active_branch.name
    if current_branch != "develop":
        print(f"\n❌ Current branch is '{current_branch}'. This script must be run on the 'develop' branch.")
        return

    # Git commit 여부 확인
    print()
    print("=" * 50)
    print("🔄 Git Commit")
    print(f"   Message: chore: Update version v{update_version}")
    print("=" * 50)

    if args.auto_commit:
        commit_confirm = "y"
        print("Auto commit enabled.")
    else:
        commit_confirm = input("Do you want to commit? (y/n): ").strip().lower()

    if commit_confirm == "y":
        commit_message = f"chore: Update version v{update_version}"
        tag_name = f"v{update_version}"

        try:
            # Stage all changes
            repo.git.add("-A")

            # Commit
            repo.index.commit(commit_message)
            print(f"\n✅ Committed: {commit_message}")

            # Git push
            print("\n📤 Pushing to remote...")
            origin = repo.remote("origin")
            origin.push()
            print("✅ Push successful.")

            # Create tag
            print(f"\n🏷️  Creating tag: {tag_name}")
            repo.create_tag(tag_name)
            print(f"✅ Tag created: {tag_name}")

            # Push tag to remote
            print(f"\n📤 Pushing tag to remote...")
            origin.push(tag_name)
            print(f"✅ Tag pushed: {tag_name}")

            print("\n" + "=" * 50)
            print("🎉 Version update completed!")
            print("=" * 50)

            # develop -> main 머지 및 푸시
            print("\n🔀 Merging develop into main...")
            repo.git.checkout("main")
            repo.git.merge("develop")
            print("✅ Merge successful.")

            print("\n📤 Pushing main to remote...")
            origin.push()
            print("✅ Main push successful.")

            print("\n🔄 Switching back to develop branch...")
            repo.git.checkout("develop")
            print("✅ Back on develop branch.")

        except GitCommandError as e:
            print(f"\n❌ Git error: {e}")
    else:
        print("\n⏭️  Commit skipped.")


if __name__ == "__main__":
    main()
