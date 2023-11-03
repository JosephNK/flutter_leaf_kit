import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class LFDeviceManager {
  static final LFDeviceManager _instance = LFDeviceManager._internal();

  static LFDeviceManager get shared => _instance;

  LFDeviceManager._internal();

  EdgeInsets _widowPadding = const EdgeInsets.all(0.0);
  EdgeInsets get widowPadding => _widowPadding;

  double _devicePixelRatio = 0.0;
  double get devicePixelRatio => _devicePixelRatio;

  double _textScaleFactor = 1.0;
  double get textScaleFactor => _textScaleFactor;

  Size _deviceSize = Size.zero;
  Size get deviceSize => _deviceSize;

  String _deviceName = '';
  String get deviceName => _deviceName;

  String _deviceOSVersion = '';
  String get deviceOSVersion => _deviceOSVersion;

  String _deviceUniqueID = '';
  String get deviceUniqueID => _deviceUniqueID;

  Future<void> setup(BuildContext context) async {
    /// MediaQuery
    _widowPadding = MediaQueryData.fromView(View.of(context)).padding;
    _textScaleFactor = MediaQuery.of(context).textScaleFactor;
    _devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    _deviceSize = MediaQuery.of(context).size;

    /// Device Info
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      final release = androidInfo.version.release;
      final sdkInt = androidInfo.version.sdkInt;
      final manufacturer = androidInfo.manufacturer;
      final model = androidInfo.model;
      final String uniqueID = await const AndroidId().getId() ?? '';
      _deviceName = model;
      _deviceOSVersion = 'Android $release (SDK $sdkInt), $manufacturer';
      _deviceUniqueID = uniqueID;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      final systemName = iosInfo.systemName;
      final systemVersion = iosInfo.systemVersion;
      final model = iosInfo.model;
      final String uniqueID = iosInfo.identifierForVendor ?? '';
      _deviceName = model;
      _deviceOSVersion = '$systemName $systemVersion';
      _deviceUniqueID = uniqueID;
    }
  }

  Future<int> getAndroidSdkInt() async {
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      return info.version.sdkInt;
    }
    return 0;
  }

  Future<bool> openAppSettings() async {
    return await ph.openAppSettings();
  }

  Future<void> cacheClear() async {
    final imageCache = PaintingBinding.instance.imageCache;
    imageCache
      ..clear()
      ..clearLiveImages();
    //..maximumSize = 0
    //..maximumSizeBytes = 0;
  }

  // https://github.com/Baseflow/flutter_cached_network_image/issues/429
  Future<void> checkMemory() async {
    final imageCache = PaintingBinding.instance.imageCache;
    if (imageCache.liveImageCount >= 100) {
      imageCache.clear();
      imageCache.clearLiveImages();
    }
  }

  // https://github.com/Baseflow/flutter-permission-handler/issues/955#issuecomment-1339099909
  // No need to ask this permission on Android 13 (API 33)
  Future<bool> checkPlatformSdk() async {
    if (Platform.isIOS) return true;
    if (Platform.isAndroid) {
      final sdkInt = await getAndroidSdkInt();
      if (sdkInt >= 33) return true;
    }
    return false;
  }
}
