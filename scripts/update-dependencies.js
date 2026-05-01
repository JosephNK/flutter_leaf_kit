#!/usr/bin/env node
/**
 * Flutter Packages - Dependencies Update Script
 *
 * Usage:
 *   yarn update-deps                          # 모든 패키지 (기본)
 *   yarn update-deps --all                    # 모든 패키지 (명시적)
 *   yarn update-deps --package leaf_core      # 단일 패키지
 *   yarn update-deps --report                 # 리포트만 출력 (업데이트 안함)
 *   yarn update-deps --include-major          # Major 업데이트 포함
 */

import { readFile, writeFile, stat } from 'node:fs/promises';
import { join, dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { parseArgs } from 'node:util';
import { createInterface } from 'node:readline/promises';
import { stdin as input, stdout as output } from 'node:process';
import process from 'node:process';
import { parseDocument, isMap, isScalar } from 'yaml';

const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..');

const SDK_PACKAGES = new Set(['flutter', 'flutter_test', 'flutter_web_plugins']);

async function fileExists(path) {
  try {
    await stat(path);
    return true;
  } catch {
    return false;
  }
}

async function getLatestVersion(packageName) {
  const url = `https://pub.dev/api/packages/${packageName}`;
  try {
    const res = await fetch(url, { signal: AbortSignal.timeout(10000) });
    if (!res.ok) return null;
    const data = await res.json();
    return data?.latest?.version ?? null;
  } catch {
    return null;
  }
}

function parseVersion(versionStr) {
  const match = versionStr.trim().match(/^[\^>=<~]*(.+)$/);
  return match ? match[1] : versionStr;
}

function parseSemver(v) {
  const cleaned = v.replace(/\+.*$/, '');
  const parts = cleaned.split('.');
  const result = [];
  for (const p of parts) {
    const m = p.match(/^(\d+)/);
    result.push(m ? Number.parseInt(m[1], 10) : 0);
  }
  while (result.length < 3) result.push(0);
  return result.slice(0, 3);
}

function compareTuples(a, b) {
  for (let i = 0; i < a.length; i++) {
    if (a[i] > b[i]) return 1;
    if (a[i] < b[i]) return -1;
  }
  return 0;
}

function compareVersions(current, latest) {
  try {
    const currParts = parseSemver(parseVersion(current));
    const latestParts = parseSemver(latest);
    return {
      needsUpdate: compareTuples(latestParts, currParts) > 0,
      isMajor: latestParts[0] > currParts[0],
    };
  } catch {
    return { needsUpdate: false, isMajor: false };
  }
}

async function getPackages(packageFilter) {
  const rootPubspec = join(projectRoot, 'pubspec.yaml');
  if (!(await fileExists(rootPubspec))) return [];

  const content = await readFile(rootPubspec, 'utf-8');
  const doc = parseDocument(content);
  const workspaceNode = doc.get('workspace');
  if (!workspaceNode || !workspaceNode.items) return [];

  const results = [];
  for (const item of workspaceNode.items) {
    const entry = isScalar(item) ? item.value : item;
    if (typeof entry !== 'string') continue;
    const pubspecPath = join(projectRoot, entry, 'pubspec.yaml');
    if (await fileExists(pubspecPath)) results.push(pubspecPath);
  }

  if (packageFilter) {
    return results.filter(
      (p) => p.includes(`/${packageFilter}/`) || p.endsWith(`/${packageFilter}/pubspec.yaml`),
    );
  }
  return results;
}

async function analyzeDependencies(pubspecPath) {
  const content = await readFile(pubspecPath, 'utf-8');
  const doc = parseDocument(content);

  const result = {
    path: pubspecPath,
    name: doc.get('name') ?? 'unknown',
    dependencies: [],
    dev_dependencies: [],
  };

  for (const section of ['dependencies', 'dev_dependencies']) {
    const depsNode = doc.get(section);
    if (!isMap(depsNode)) continue;

    for (const pair of depsNode.items) {
      const pkgName = isScalar(pair.key) ? pair.key.value : pair.key;
      if (typeof pkgName !== 'string') continue;
      if (SDK_PACKAGES.has(pkgName)) continue;
      if (pkgName.startsWith('flutter_leaf')) continue;

      // Skip dict-style deps (git, path, etc.)
      const valueNode = pair.value;
      if (!isScalar(valueNode)) continue;

      const version = valueNode.value;
      if (typeof version !== 'string') continue;

      const latest = await getLatestVersion(pkgName);
      if (!latest) continue;

      const { needsUpdate, isMajor } = compareVersions(version, latest);
      result[section].push({
        name: pkgName,
        current: version,
        latest,
        needsUpdate,
        isMajor,
      });
    }
  }

  return result;
}

function printReport(analysisResults, includeMajor) {
  let totalUpdates = 0;

  for (const result of analysisResults) {
    console.log('');
    console.log('='.repeat(60));
    console.log(`📦 ${result.name}`);
    console.log('='.repeat(60));

    const allDeps = [...result.dependencies, ...result.dev_dependencies];

    if (allDeps.length === 0) {
      console.log('  📭 (외부 의존성 없음)');
      continue;
    }

    console.log(`  ${'Package'.padEnd(25)} ${'Current'.padEnd(12)} ${'Latest'.padEnd(12)} ${'Status'.padEnd(10)}`);
    console.log(`  ${'-'.repeat(25)} ${'-'.repeat(12)} ${'-'.repeat(12)} ${'-'.repeat(10)}`);

    let packageUpdates = 0;
    for (const dep of allDeps) {
      let status;
      if (dep.needsUpdate) {
        if (dep.isMajor) {
          status = '🔴 Major';
          if (includeMajor) packageUpdates += 1;
        } else {
          status = '🟡 Update';
          packageUpdates += 1;
        }
      } else {
        status = '🟢 Latest';
      }

      console.log(
        `  ${dep.name.padEnd(25)} ${dep.current.padEnd(12)} ${dep.latest.padEnd(12)} ${status.padEnd(10)}`,
      );
    }

    if (packageUpdates > 0) {
      console.log(`\n  ⬆️  업데이트 가능: ${packageUpdates}개`);
    }

    totalUpdates += packageUpdates;
  }

  console.log('');
  console.log('='.repeat(60));
  console.log(`📊 총 업데이트 가능 패키지: ${totalUpdates}개`);
  console.log('='.repeat(60));

  return totalUpdates;
}

async function updatePubspec(pubspecPath, analysis, includeMajor) {
  const content = await readFile(pubspecPath, 'utf-8');
  const doc = parseDocument(content);

  let updatedCount = 0;

  for (const section of ['dependencies', 'dev_dependencies']) {
    for (const dep of analysis[section]) {
      if (!dep.needsUpdate) continue;
      if (dep.isMajor && !includeMajor) continue;

      const newVersion = `^${dep.latest}`;
      const node = doc.getIn([section, dep.name], true);
      if (node && typeof node === 'object' && 'value' in node) {
        node.value = newVersion;
        updatedCount += 1;
        console.log(`  ✨ ${dep.name}: ${dep.current} -> ${newVersion}`);
      }
    }
  }

  if (updatedCount > 0) {
    await writeFile(pubspecPath, doc.toString());
  }

  return updatedCount;
}

async function ask(question) {
  const rl = createInterface({ input, output });
  try {
    return await rl.question(question);
  } finally {
    rl.close();
  }
}

async function main() {
  const { values } = parseArgs({
    options: {
      all: { type: 'boolean', default: false },
      package: { type: 'string' },
      report: { type: 'boolean', default: false },
      'include-major': { type: 'boolean', default: false },
    },
  });

  const pubspecFiles = await getPackages(values.package);

  if (pubspecFiles.length === 0) {
    console.log('❌ pubspec.yaml 파일을 찾을 수 없습니다.');
    return;
  }

  console.log('');
  console.log('🔍 Flutter Packages - Dependencies Update');
  console.log('');
  console.log(`📋 ${pubspecFiles.length}개의 패키지를 분석합니다...`);

  const analysisResults = [];
  for (const pubspecPath of pubspecFiles) {
    console.log(`  🔎 분석 중: ${pubspecPath.replace(projectRoot + '/', '')}`);
    analysisResults.push(await analyzeDependencies(pubspecPath));
  }

  const totalUpdates = printReport(analysisResults, values['include-major']);

  if (values.report) return;

  if (totalUpdates === 0) {
    console.log('\n✅ 모든 패키지가 최신 버전입니다.');
    return;
  }

  console.log('');
  const response = (await ask('⚡ 업데이트를 진행하시겠습니까? [y/N]: ')).trim().toLowerCase();

  if (response !== 'y') {
    console.log('\n⏭️  업데이트가 취소되었습니다.');
    return;
  }

  console.log('\n🔄 업데이트 중...');
  let totalUpdated = 0;

  for (const analysis of analysisResults) {
    console.log(`\n📦 [${analysis.name}]`);
    totalUpdated += await updatePubspec(analysis.path, analysis, values['include-major']);
  }

  console.log('');
  console.log('='.repeat(60));
  console.log(`🎉 총 ${totalUpdated}개의 의존성이 업데이트되었습니다.`);
  console.log('='.repeat(60));
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
