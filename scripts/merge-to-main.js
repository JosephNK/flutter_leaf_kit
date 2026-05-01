#!/usr/bin/env node
/**
 * Flutter Leaf Kit - Merge to Main Script
 *
 * develop 브랜치에서 main으로 머지하고 push한 뒤 다시 develop으로 돌아옵니다.
 *
 * Usage:
 *   yarn merge-to-main             # develop → main 머지 후 push
 *   yarn merge-to-main --dry-run   # 실제 push 없이 시뮬레이션
 */

import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { parseArgs, promisify } from 'node:util';
import { execFile as execFileCb } from 'node:child_process';
import process from 'node:process';

const runFile = promisify(execFileCb);
const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..');

async function git(...args) {
  const { stdout } = await runFile('git', args, { cwd: projectRoot });
  return stdout.trim();
}

async function isWorkingTreeClean() {
  try {
    const { stdout } = await runFile('git', ['status', '--porcelain'], { cwd: projectRoot });
    return stdout.trim() === '';
  } catch {
    return false;
  }
}

async function fail(message, code = 1) {
  console.log(message);
  process.exit(code);
}

async function main() {
  const { values } = parseArgs({
    options: {
      'dry-run': { type: 'boolean', default: false },
    },
  });

  const dryRun = values['dry-run'];

  // 1. 현재 브랜치 확인
  let currentBranch;
  try {
    currentBranch = await git('rev-parse', '--abbrev-ref', 'HEAD');
  } catch (e) {
    await fail(`[Error] git 정보를 읽을 수 없습니다: ${e.message}`);
  }

  if (currentBranch !== 'develop') {
    await fail(`[Error] 현재 브랜치가 '${currentBranch}'입니다. develop 브랜치에서 실행해주세요.`);
  }

  console.log(`[OK] 현재 브랜치: ${currentBranch}`);

  // 2. 워킹 트리 확인
  if (!(await isWorkingTreeClean())) {
    await fail('[Error] 커밋되지 않은 변경사항이 있습니다. 먼저 커밋하거나 stash 해주세요.');
  }

  console.log('[OK] 워킹 트리 깨끗함');

  // 3. develop 최신화
  try {
    console.log('[..] develop 브랜치 pull 중...');
    await git('pull', 'origin', 'develop');
    console.log('[OK] develop 브랜치 최신화 완료');
  } catch (e) {
    await fail(`[Error] develop pull 실패: ${e.stderr?.toString() || e.message}`);
  }

  // 4. develop에 push할 커밋이 있으면 먼저 push
  const commitsAheadStr = await git('rev-list', '--count', 'origin/develop..develop');
  const commitsAhead = Number.parseInt(commitsAheadStr, 10) || 0;

  if (commitsAhead > 0) {
    if (dryRun) {
      console.log(`[Dry-run] develop 브랜치에 push되지 않은 ${commitsAhead}개의 커밋 발견 (push 생략)`);
    } else {
      try {
        console.log(`[..] develop 브랜치에 push되지 않은 ${commitsAhead}개의 커밋 발견, push 중...`);
        await git('push', 'origin', 'develop');
        console.log('[OK] develop 브랜치 push 완료');
      } catch (e) {
        await fail(`[Error] develop push 실패: ${e.stderr?.toString() || e.message}`);
      }
    }
  } else {
    console.log('[OK] develop 브랜치에 push할 커밋 없음');
  }

  // 5. main 브랜치로 전환
  try {
    console.log('[..] main 브랜치로 전환 중...');
    await git('checkout', 'main');
    console.log('[OK] main 브랜치로 전환 완료');
  } catch (e) {
    await fail(`[Error] main 브랜치 전환 실패: ${e.stderr?.toString() || e.message}`);
  }

  // 6. main 최신화
  try {
    console.log('[..] main 브랜치 pull 중...');
    await git('pull', 'origin', 'main');
    console.log('[OK] main 브랜치 최신화 완료');
  } catch (e) {
    console.log(`[Error] main pull 실패: ${e.stderr?.toString() || e.message}`);
    try {
      await git('checkout', 'develop');
    } catch {}
    process.exit(1);
  }

  // 7. develop → main 머지
  try {
    console.log('[..] develop → main 머지 중...');
    await git('merge', 'develop');
    console.log('[OK] 머지 완료');
  } catch (e) {
    console.log(`[Error] 머지 실패: ${e.stderr?.toString() || e.message}`);
    console.log('[Info] 충돌을 해결한 후 수동으로 진행해주세요.');
    process.exit(1);
  }

  // 8. main push
  if (dryRun) {
    console.log('[Dry-run] push 생략 (--dry-run)');
  } else {
    try {
      console.log('[..] main 브랜치 push 중...');
      await git('push', 'origin', 'main');
      console.log('[OK] main 브랜치 push 완료');
    } catch (e) {
      console.log(`[Error] push 실패: ${e.stderr?.toString() || e.message}`);
      console.log('[Info] 현재 main 브랜치에 머지된 상태입니다. 수동으로 push 해주세요.');
      process.exit(1);
    }
  }

  // 9. develop 브랜치로 복귀
  try {
    console.log('[..] develop 브랜치로 복귀 중...');
    await git('checkout', 'develop');
    console.log('[OK] develop 브랜치로 복귀 완료');
  } catch (e) {
    await fail(`[Error] develop 브랜치 복귀 실패: ${e.stderr?.toString() || e.message}`);
  }

  console.log('');
  if (dryRun) {
    console.log('[Done] dry-run 완료 (push 생략됨)');
  } else {
    console.log('[Done] develop → main 머지 및 push 완료!');
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
