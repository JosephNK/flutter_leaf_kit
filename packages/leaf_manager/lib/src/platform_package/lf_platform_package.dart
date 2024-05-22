import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'lf_build_type.dart';

export 'lf_build_type.dart';

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
