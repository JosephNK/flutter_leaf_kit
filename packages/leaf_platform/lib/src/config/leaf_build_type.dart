enum LeafBuildType {
  production, // Live
  development, // Dev
  staging, // Sta
  test, // QA
}

extension LeafBuildTypeExt on LeafBuildType {
  String get longName {
    switch (this) {
      case LeafBuildType.production:
        return 'production';
      case LeafBuildType.development:
        return 'development';
      case LeafBuildType.staging:
        return 'staging';
      case LeafBuildType.test:
        return 'test';
    }
  }

  String get shortName {
    switch (this) {
      case LeafBuildType.production:
        return 'prod';
      case LeafBuildType.development:
        return 'dev';
      case LeafBuildType.staging:
        return 'stg';
      case LeafBuildType.test:
        return 'test';
    }
  }
}
