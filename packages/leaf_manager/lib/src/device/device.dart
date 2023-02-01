import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:leaf_common/leaf_common.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class LFDeviceManager {
  static final LFDeviceManager _instance = LFDeviceManager._internal();

  static LFDeviceManager get shared => _instance;

  LFDeviceManager._internal();

  // ignore: prefer_const_constructors
  EdgeInsets _widowPadding = EdgeInsets.all(0.0);
  EdgeInsets get widowPadding {
    return _widowPadding;
  }

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
    _widowPadding = MediaQueryData.fromWindow(window).padding;
    _textScaleFactor = MediaQuery.of(context).textScaleFactor;
    _devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    _deviceSize = MediaQuery.of(context).size;
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
      deviceName = androidInfo.model;
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
      isPhysicalDevice = androidInfo.isPhysicalDevice;
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
