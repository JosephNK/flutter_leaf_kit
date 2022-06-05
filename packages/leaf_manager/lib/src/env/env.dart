import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum BuildType { production, development, staging, test }

extension BuildTypeExtension on BuildType {
  String get name {
    switch (this) {
      case BuildType.production:
        return 'production';
      case BuildType.development:
        return 'development';
      case BuildType.staging:
        return 'staging';
      case BuildType.test:
        return 'test';
      default:
        return '';
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
    } else if (packageName.contains('staging')) {
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

  static Environment get instance => _instance!;

  bool get isProduction => buildType == BuildType.production;
  bool get isDevelopment => buildType == BuildType.development;
  bool get isStaging => buildType == BuildType.staging;
  bool get isTest => buildType == BuildType.test;

  static Future<Environment> packageInfo() async {
    final info = await PackageInfo.fromPlatform();

    final packageName = info.packageName;
    final version = info.version;
    final buildNumber = info.buildNumber;

    // Logging.d('packageName: $packageName');
    // Logging.d('version: $version');
    // Logging.d('buildNumber: $buildNumber');

    return Environment(
        packageName: packageName, version: version, buildNumber: buildNumber);
  }
}
