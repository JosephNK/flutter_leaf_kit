#!/usr/bin/env node
/**
 * Flutter Leaf Kit - Pub Outdated Script
 *
 * 각 패키지에서 dart pub outdated 명령어를 실행하여 의존성 상태를 확인합니다.
 *
 * Usage:
 *   yarn pub-outdated                       # 모든 패키지
 *   yarn pub-outdated --package leaf_core   # 특정 패키지만
 */

import { readdir, stat } from 'node:fs/promises';
import { join, dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { parseArgs } from 'node:util';
import { spawn } from 'node:child_process';
import process from 'node:process';

const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..');

async function fileExists(path) {
  try {
    await stat(path);
    return true;
  } catch {
    return false;
  }
}

async function getPackages(packageFilter) {
  const packagesDir = join(projectRoot, 'packages');
  const entries = await readdir(packagesDir, { withFileTypes: true });
  const packages = [];

  for (const entry of entries) {
    if (!entry.isDirectory()) continue;
    const packageDir = join(packagesDir, entry.name);
    const pubspecPath = join(packageDir, 'pubspec.yaml');
    if (!(await fileExists(pubspecPath))) continue;

    if (packageFilter && !entry.name.includes(packageFilter)) continue;
    packages.push({ name: entry.name, dir: packageDir });
  }

  return packages.sort((a, b) => a.name.localeCompare(b.name));
}

async function runPubOutdated(pkg) {
  console.log('');
  console.log('='.repeat(60));
  console.log(` ${pkg.name}`);
  console.log('='.repeat(60));
  console.log('');

  await new Promise((resolveFn) => {
    const child = spawn('dart', ['pub', 'outdated'], {
      cwd: pkg.dir,
      stdio: 'inherit',
    });
    child.on('error', (err) => {
      if (err.code === 'ENOENT') {
        console.log("  Error: 'dart' command not found. Please ensure Dart SDK is installed.");
      } else {
        console.log(`  Error: ${err.message}`);
      }
      resolveFn();
    });
    child.on('exit', () => resolveFn());
  });
}

async function main() {
  const { values } = parseArgs({
    options: {
      package: { type: 'string' },
    },
  });

  const packages = await getPackages(values.package);

  if (packages.length === 0) {
    console.log('패키지를 찾을 수 없습니다.');
    return;
  }

  console.log(`\n${packages.length}개의 패키지를 확인합니다...`);

  for (const pkg of packages) {
    await runPubOutdated(pkg);
  }

  console.log('');
  console.log('='.repeat(60));
  console.log(' 완료');
  console.log('='.repeat(60));
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
