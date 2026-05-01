#!/usr/bin/env node
/**
 * Flutter Leaf Kit - Version Update Script
 *
 * Usage:
 *   yarn update-version                       # 대화형으로 버전 입력
 *   yarn update-version 2.5.0                 # 버전 직접 지정
 *   yarn update-version 2.5.0 --auto-commit   # 자동 커밋
 */

import { readFile, writeFile, readdir, stat } from 'node:fs/promises';
import { join, dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { parseArgs, promisify } from 'node:util';
import { createInterface } from 'node:readline/promises';
import { stdin as input, stdout as output } from 'node:process';
import { execFile as execFileCb } from 'node:child_process';
import process from 'node:process';
import { parseDocument } from 'yaml';

const runFile = promisify(execFileCb);
const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..');

async function git(...args) {
  const { stdout } = await runFile('git', args, { cwd: projectRoot });
  return stdout.trim();
}

async function fileExists(path) {
  try {
    await stat(path);
    return true;
  } catch {
    return false;
  }
}

async function findPackagePubspecs() {
  const packagesDir = join(projectRoot, 'packages');
  const entries = await readdir(packagesDir, { withFileTypes: true });
  const results = [];
  for (const entry of entries) {
    if (!entry.isDirectory()) continue;
    const pubspecPath = join(packagesDir, entry.name, 'pubspec.yaml');
    if (await fileExists(pubspecPath)) results.push(pubspecPath);
  }
  return results.sort();
}

function setScalar(doc, path, value) {
  const node = doc.getIn(path, true);
  if (node && typeof node === 'object' && 'value' in node) {
    node.value = value;
    return true;
  }
  return false;
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
  const { values, positionals } = parseArgs({
    options: {
      'auto-commit': { type: 'boolean', default: false },
    },
    allowPositionals: true,
  });

  const pubspecFiles = await findPackagePubspecs();

  console.log('📦 Flutter Leaf Kit - Version Update');
  console.log('');

  let updateVersion = positionals[0];
  if (updateVersion) {
    console.log(`🔢 Version: ${updateVersion}`);
  } else {
    updateVersion = (await ask('🔢 Please enter the updated version. (ex., 1.0.0): ')).trim();
  }

  if (!updateVersion) {
    console.log('\n❌ Version is required.');
    process.exit(1);
  }

  const subPackageNames = pubspecFiles
    .map((p) => 'flutter_' + p.replace(projectRoot + '/', '').replace('packages/', '').replace('/pubspec.yaml', ''))
    .filter((name) => name.includes('flutter_leaf_'));

  for (const filePath of pubspecFiles) {
    const content = await readFile(filePath, 'utf-8');
    const doc = parseDocument(content);

    setScalar(doc, ['version'], updateVersion);

    for (const subPkg of subPackageNames) {
      setScalar(doc, ['dependencies', subPkg, 'git', 'ref'], `v${updateVersion}`);
    }

    await writeFile(filePath, doc.toString());
  }

  console.log('\n📝 Yaml files have been modified.');

  const currentBranch = await git('rev-parse', '--abbrev-ref', 'HEAD');
  if (currentBranch !== 'develop') {
    console.log(`\n❌ Current branch is '${currentBranch}'. This script must be run on the 'develop' branch.`);
    return;
  }

  console.log('');
  console.log('='.repeat(50));
  console.log('🔄 Git Commit');
  console.log(`   Message: chore: Update version v${updateVersion}`);
  console.log('='.repeat(50));

  let commitConfirm;
  if (values['auto-commit']) {
    commitConfirm = 'y';
    console.log('Auto commit enabled.');
  } else {
    commitConfirm = (await ask('Do you want to commit? (y/n): ')).trim().toLowerCase();
  }

  if (commitConfirm !== 'y') {
    console.log('\n⏭️  Commit skipped.');
    return;
  }

  const commitMessage = `chore: Update version v${updateVersion}`;
  const tagName = `v${updateVersion}`;

  try {
    await git('add', '-A');
    await git('commit', '-m', commitMessage);
    console.log(`\n✅ Committed: ${commitMessage}`);

    console.log('\n📤 Pushing to remote...');
    await git('push', 'origin', 'develop');
    console.log('✅ Push successful.');

    console.log(`\n🏷️  Creating tag: ${tagName}`);
    await git('tag', tagName);
    console.log(`✅ Tag created: ${tagName}`);

    console.log('\n📤 Pushing tag to remote...');
    await git('push', 'origin', tagName);
    console.log(`✅ Tag pushed: ${tagName}`);

    console.log('');
    console.log('='.repeat(50));
    console.log('🎉 Version update completed!');
    console.log('='.repeat(50));

    console.log('\n🔀 Merging develop into main...');
    await git('checkout', 'main');
    await git('merge', 'develop');
    console.log('✅ Merge successful.');

    console.log('\n📤 Pushing main to remote...');
    await git('push', 'origin', 'main');
    console.log('✅ Main push successful.');

    console.log('\n🔄 Switching back to develop branch...');
    await git('checkout', 'develop');
    console.log('✅ Back on develop branch.');
  } catch (e) {
    console.log(`\n❌ Git error: ${e.stderr?.toString() || e.message}`);
    process.exit(1);
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
