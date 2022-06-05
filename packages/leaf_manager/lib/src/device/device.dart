import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import '../env/env.dart';

class DeviceManager {
  static final DeviceManager _instance = DeviceManager._internal();

  static DeviceManager get shared => _instance;

  DeviceManager._internal();

  double _devicePixelRatio = 0.0;
  double get devicePixelRatio {
    return _devicePixelRatio;
  }

  double _textScaleFactor = 1.0;
  double get textScaleFactor {
    return _textScaleFactor;
  }

  Size _deviceSize = Size.zero;
  Size get deviceSize {
    return _deviceSize;
  }

  void setup(BuildContext context) {
    _textScaleFactor = MediaQuery.of(context).textScaleFactor;
    _devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    _deviceSize = MediaQuery.of(context).size;
    // Logging.d('[DEVICE TSF]: $textScaleFactor');
    // Logging.d('[DEVICE DPI]: $devicePixelRatio');
    // Logging.d('[DEVICE SIZE]: $_deviceSize');
  }

  Future<String> appVersion() async {
    final info = await Environment.packageInfo();
    final version = info.version;
    final buildNumber = info.buildNumber;
    final appVersion = '$version ($buildNumber)';
    return appVersion;
  }

  Future<String> deviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    var deviceName = '';
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model ?? '';
    }
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine ?? '';
    }
    return deviceName;
  }

  Future<bool> isPhysicalDevice() async {
    var isPhysicalDevice = false;
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      isPhysicalDevice = iosInfo.isPhysicalDevice;
    } else {
      final androidInfo = await deviceInfo.androidInfo;
      isPhysicalDevice = androidInfo.isPhysicalDevice ?? false;
    }
    return isPhysicalDevice;
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

  // ref., https://github.com/Baseflow/flutter_cached_network_image/issues/429
  Future<void> checkMemory() async {
    final imageCache = PaintingBinding.instance.imageCache;
    if (imageCache.liveImageCount >= 100) {
      imageCache.clear();
      imageCache.clearLiveImages();
    }
  }
}
