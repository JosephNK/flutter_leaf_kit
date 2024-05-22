enum BuildType {
  production, // Live
  development, // Dev
  staging, // Sta
  test, // QA
}

extension BuildTypeExt on BuildType {
  String get longName {
    switch (this) {
      case BuildType.production:
        return 'production';
      case BuildType.development:
        return 'development';
      case BuildType.staging:
        return 'staging';
      case BuildType.test:
        return 'test';
    }
  }

  String get shortName {
    switch (this) {
      case BuildType.production:
        return 'prod';
      case BuildType.development:
        return 'dev';
      case BuildType.staging:
        return 'stg';
      case BuildType.test:
        return 'test';
    }
  }
}
