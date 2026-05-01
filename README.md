# Flutter Leaf Kit

#### This package is created to be used as a common module in the project.

Currently, being created for a beta project.

Currently `pub.dev` is not supported.

## How to Install

Below is how to use the full package.
```
  flutter_leaf_kit:
    git:
      url: https://github.com/JosephNK/flutter_leaf_kit.git
      ref: main or 'v2.0.0' or 'b23ce51'
      path: packages/leaf/
```

Below is a partial guide to using the package.
```
  flutter_leaf_core:
    git:
      url: https://github.com/JosephNK/flutter_leaf_kit.git
      ref: main or 'v2.0.0' or 'b23ce51'
      path: ./packages/leaf_core

  flutter_leaf_component:
    git:
      url: https://github.com/JosephNK/flutter_leaf_kit.git
      ref: main or 'v2.0.0' or 'b23ce51'
      path: ./packages/leaf_component

  ...
```

## Commands

```bash
# Install dependencies (Melos)
melos bootstrap

# Node 의존성 설치 및 husky git hooks 설정
melos run setup

# Build all
melos run build

# Update version
yarn update-version                      # Interactive
yarn update-version 2.5.0-dev            # Specify version

# Check dependency updates (pub.dev API)
yarn update-deps --report                # Report only
yarn update-deps                         # Report and update
yarn update-deps --package leaf_core     # Specific package
yarn update-deps --include-major         # Include major updates

# Check dependency status (dart pub outdated)
yarn pub-outdated                        # All packages
yarn pub-outdated --package leaf_core    # Specific package

# Merge develop → main and push
yarn merge-to-main                       # Execute
yarn merge-to-main --dry-run             # Dry run (no push)

# Run example app
cd example && flutter run
```
