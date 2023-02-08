part of lf_common;

enum BuildType {
  production,
  development,
  staging,
  test,
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

class Environment {
  final String packageName;
  final String version;
  final String buildNumber;
  final String platform;
  final BuildType buildType;

  static Environment? _instance;
  static Environment get instance => _instance!;

  const Environment._internal(
    this.buildType, {
    required this.packageName,
    required this.version,
    required this.buildNumber,
    required this.platform,
  });

  factory Environment({
    required String packageName,
    required String version,
    required String buildNumber,
  }) {
    String platform;
    if (kIsWeb) {
      platform = 'web';
    } else {
      platform = Platform.isIOS ? 'ios' : 'aos';
    }

    var buildType = BuildType.production;
    if (packageName.contains('dev')) {
      buildType = BuildType.development;
    } else if (packageName.contains('stating')) {
      buildType = BuildType.staging;
    } else if (packageName.contains('test')) {
      buildType = BuildType.test;
    }

    _instance ??= Environment._internal(
      buildType,
      packageName: packageName,
      version: version,
      buildNumber: buildNumber,
      platform: platform,
    );

    return _instance!;
  }

  static Future<Environment> packageInfo() async {
    if (kIsWeb) {
      return Environment(packageName: 'web', version: '', buildNumber: '');
    }
    final info = await PackageInfo.fromPlatform();
    final packageName = info.packageName;
    final version = info.version;
    final buildNumber = info.buildNumber;
    return Environment(
      packageName: packageName,
      version: version,
      buildNumber: buildNumber,
    );
  }

  bool get isProduction => (buildType == BuildType.production);
  bool get isDevelopment => (buildType == BuildType.development);
  bool get isStaging => (buildType == BuildType.staging);
  bool get isTest => (buildType == BuildType.test);

  String get displayVersion {
    final deployment = kDebugMode ? buildType.name : '';
    return '$deployment v.$version($buildNumber)';
  }

  String userAgent(String appName) {
    final deployment = buildType.name;
    return '$appName-$platform-$deployment-$version.$buildNumber';
  }
}
