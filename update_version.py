import os
import ruamel.yaml
from pathlib import Path

yaml = ruamel.yaml.YAML()
yaml.preserve_quotes = True

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
