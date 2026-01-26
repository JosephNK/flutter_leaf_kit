#!/usr/bin/env python3
"""
Flutter Leaf Kit - Version Update Script

Usage:
    update-version           # 대화형으로 버전 입력
    update-version 2.5.0     # 버전 직접 지정
"""

import os
import sys
import ruamel.yaml
from pathlib import Path


def get_project_root() -> Path:
    """프로젝트 루트 디렉토리 반환"""
    # 스크립트 위치 기준으로 상위 디렉토리
    return Path(__file__).parent.parent


def main():
    yaml = ruamel.yaml.YAML()
    yaml.preserve_quotes = True

    project_root = get_project_root()
    os.chdir(project_root)

    # 버전 입력 받기
    if len(sys.argv) > 1:
        update_version = sys.argv[1]
    else:
        update_version = input('Please enter the updated version. (ex., 1.0.0): ')

    results = list(Path('./packages').rglob('pubspec.yaml'))

    # Get Sub Package Names
    package_names = list()
    for result in results:
        file_path = str(result)
        package_name = 'flutter_{}'.format(file_path.replace('packages/', '').replace('/pubspec.yaml', ''))
        if 'flutter_leaf_' in package_name:
            package_names.append(package_name)

    # Update Yaml
    for result in results:
        file_path = str(result)

        with open(file_path, 'r') as stream:
            data = yaml.load(stream)

            data['version'] = update_version

            for sub_package_name in package_names:
                try:
                    data['dependencies'][sub_package_name]['git']['ref'] = f'v{update_version}'
                except:
                    continue

        with open(file_path, 'wb') as stream:
            yaml.dump(data, stream)

    print('The Yaml file has been modified.')

    # Run melos bootstrap
    os.system('melos bootstrap')


if __name__ == "__main__":
    main()
