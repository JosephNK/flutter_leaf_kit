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

class PlatformPackage {
  final BuildType buildType;
  final String packageName;
  final String packageVersion;
  final String packageBuildNumber;
  final String platform;

  static PlatformPackage? _instance;
  static PlatformPackage get instance => _instance!;

  const PlatformPackage._internal(
    this.buildType, {
    required this.packageName,
    required this.packageVersion,
    required this.packageBuildNumber,
    required this.platform,
  });

  bool get isProduction => (buildType == BuildType.production);
  bool get isDevelopment => (buildType == BuildType.development);
  bool get isStaging => (buildType == BuildType.staging);
  bool get isTest => (buildType == BuildType.test);

  String get displayAppVersion {
    final deployment = kDebugMode ? buildType.name : '';
    return '$deployment v.$packageVersion($packageBuildNumber)';
  }

  String userAgent(String appName) {
    final deployment = buildType.name;
    return '$appName-$platform-$deployment-$packageVersion.$packageBuildNumber';
  }

  factory PlatformPackage({
    required String packageName,
    required String packageVersion,
    required String packageBuildNumber,
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

    _instance ??= PlatformPackage._internal(
      buildType,
      packageName: packageName,
      packageVersion: packageVersion,
      packageBuildNumber: packageBuildNumber,
      platform: platform,
    );

    return _instance!;
  }

  static Future<PlatformPackage> fromInfo() async {
    if (kIsWeb) {
      return PlatformPackage(
        packageName: 'web',
        packageVersion: '',
        packageBuildNumber: '',
      );
    }
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    final packageVersion = packageInfo.version;
    final packageBuildNumber = packageInfo.buildNumber;
    return PlatformPackage(
      packageName: packageName,
      packageVersion: packageVersion,
      packageBuildNumber: packageBuildNumber,
    );
  }
}
