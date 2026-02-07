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
  flutter_leaf_common:
    git:
      url: https://github.com/JosephNK/flutter_leaf_kit.git
      ref: main or 'v2.0.0' or 'b23ce51'
      path: ./packages/leaf_common
  
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

# Build all
melos run build

# Update version
poetry run update-version           # Interactive
poetry run update-version 2.5.0-dev     # Specify version

# Check dependency updates (pub.dev API)
poetry run update-deps --report              # Report only
poetry run update-deps                       # Report and update
poetry run update-deps --package leaf_common # Specific package
poetry run update-deps --include-major       # Include major updates

# Check dependency status (dart pub outdated)
poetry run pub-outdated                      # All packages
poetry run pub-outdated --package leaf_common # Specific package

# Merge develop → main and push
poetry run merge-to-main             # Execute
poetry run merge-to-main --dry-run   # Dry run (no push)

# Run example app
cd example && flutter run
```