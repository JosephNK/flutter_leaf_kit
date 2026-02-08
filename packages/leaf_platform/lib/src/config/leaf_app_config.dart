import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'leaf_build_type.dart';

export 'leaf_build_type.dart';

class LeafAppConfig {
  final LeafBuildType buildType;
  final String packageName;
  final String packageVersion;
  final String packageBuildNumber;
  final String platform;

  static LeafAppConfig? _instance;
  static LeafAppConfig get instance => _instance!;

  const LeafAppConfig._internal(
    this.buildType, {
    required this.packageName,
    required this.packageVersion,
    required this.packageBuildNumber,
    required this.platform,
  });

  bool get isProduction => (buildType == LeafBuildType.production);
  bool get isDevelopment => (buildType == LeafBuildType.development);
  bool get isStaging => (buildType == LeafBuildType.staging);
  bool get isTest => (buildType == LeafBuildType.test);

  String getDisplayAppVersion({
    bool showBuildNumber = false,
    bool showDeployment = true,
  }) {
    final deployment = showDeployment ? buildType.name : '';
    final version = showBuildNumber
        ? '$packageVersion($packageBuildNumber)'
        : packageVersion;
    if (isNotEmpty(deployment)) {
      return '$deployment $version';
    }
    return version;
  }

  String userAgent(String appName) {
    final deployment = buildType.name;
    return '$appName-$platform-$deployment-$packageVersion.$packageBuildNumber';
  }

  factory LeafAppConfig({
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

    var buildType = LeafBuildType.production;
    if (packageName.contains('dev')) {
      buildType = LeafBuildType.development;
    } else if (packageName.contains('staging')) {
      buildType = LeafBuildType.staging;
    } else if (packageName.contains('test')) {
      buildType = LeafBuildType.test;
    }

    _instance ??= LeafAppConfig._internal(
      buildType,
      packageName: packageName,
      packageVersion: packageVersion,
      packageBuildNumber: packageBuildNumber,
      platform: platform,
    );

    return _instance!;
  }

  static Future<LeafAppConfig> fromInfo() async {
    if (kIsWeb) {
      return LeafAppConfig(
        packageName: 'web',
        packageVersion: '',
        packageBuildNumber: '',
      );
    }
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    final packageVersion = packageInfo.version;
    final packageBuildNumber = packageInfo.buildNumber;
    return LeafAppConfig(
      packageName: packageName,
      packageVersion: packageVersion,
      packageBuildNumber: packageBuildNumber,
    );
  }
}
