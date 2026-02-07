#!/usr/bin/env python3
"""
Flutter Leaf Kit - Merge to Main Script

develop 브랜치에서 main으로 머지하고 push한 뒤 다시 develop으로 돌아옵니다.

Usage:
    merge-to-main           # develop → main 머지 후 push
    merge-to-main --dry-run # 실제 push 없이 시뮬레이션
"""

import argparse
import sys
from pathlib import Path

from git import Repo
from git.exc import GitCommandError


def get_project_root() -> Path:
    """프로젝트 루트 디렉토리 반환"""
    return Path(__file__).parent.parent


def check_working_tree_clean(repo: Repo) -> bool:
    """워킹 트리가 깨끗한지 확인"""
    return not repo.is_dirty(untracked_files=True)


def main():
    parser = argparse.ArgumentParser(
        description="Flutter Leaf Kit - Merge to Main Script"
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        default=False,
        help="실제 push 없이 시뮬레이션",
    )
    args = parser.parse_args()

    project_root = get_project_root()
    repo = Repo(project_root)

    # 1. 현재 브랜치 확인
    current_branch = repo.active_branch.name
    if current_branch != "develop":
        print(f"[Error] 현재 브랜치가 '{current_branch}'입니다. develop 브랜치에서 실행해주세요.")
        sys.exit(1)

    print(f"[OK] 현재 브랜치: {current_branch}")

    # 2. 워킹 트리 확인
    if not check_working_tree_clean(repo):
        print("[Error] 커밋되지 않은 변경사항이 있습니다. 먼저 커밋하거나 stash 해주세요.")
        sys.exit(1)

    print("[OK] 워킹 트리 깨끗함")

    # 3. develop 최신화
    try:
        print("[..] develop 브랜치 pull 중...")
        repo.git.pull("origin", "develop")
        print("[OK] develop 브랜치 최신화 완료")
    except GitCommandError as e:
        print(f"[Error] develop pull 실패: {e}")
        sys.exit(1)

    # 4. main 브랜치로 전환
    try:
        print("[..] main 브랜치로 전환 중...")
        repo.git.checkout("main")
        print("[OK] main 브랜치로 전환 완료")
    except GitCommandError as e:
        print(f"[Error] main 브랜치 전환 실패: {e}")
        sys.exit(1)

    # 5. main 최신화
    try:
        print("[..] main 브랜치 pull 중...")
        repo.git.pull("origin", "main")
        print("[OK] main 브랜치 최신화 완료")
    except GitCommandError as e:
        print(f"[Error] main pull 실패: {e}")
        repo.git.checkout("develop")
        sys.exit(1)

    # 6. develop → main 머지
    try:
        print("[..] develop → main 머지 중...")
        repo.git.merge("develop")
        print("[OK] 머지 완료")
    except GitCommandError as e:
        print(f"[Error] 머지 실패: {e}")
        print("[Info] 충돌을 해결한 후 수동으로 진행해주세요.")
        sys.exit(1)

    # 7. main push
    if args.dry_run:
        print("[Dry-run] push 생략 (--dry-run)")
    else:
        try:
            print("[..] main 브랜치 push 중...")
            repo.git.push("origin", "main")
            print("[OK] main 브랜치 push 완료")
        except GitCommandError as e:
            print(f"[Error] push 실패: {e}")
            print("[Info] 현재 main 브랜치에 머지된 상태입니다. 수동으로 push 해주세요.")
            sys.exit(1)

    # 8. develop 브랜치로 복귀
    try:
        print("[..] develop 브랜치로 복귀 중...")
        repo.git.checkout("develop")
        print("[OK] develop 브랜치로 복귀 완료")
    except GitCommandError as e:
        print(f"[Error] develop 브랜치 복귀 실패: {e}")
        sys.exit(1)

    print("")
    if args.dry_run:
        print("[Done] dry-run 완료 (push 생략됨)")
    else:
        print("[Done] develop → main 머지 및 push 완료!")


if __name__ == "__main__":
    main()
