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

  void setup(BuildContext context) async {
    /// MediaQuery
    _widowPadding = MediaQueryData.fromWindow(window).padding;
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
      _deviceName = model;
      _deviceOSVersion = 'Android $release (SDK $sdkInt), $manufacturer';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      final systemName = iosInfo.systemName;
      final systemVersion = iosInfo.systemVersion;
      final name = iosInfo.name;
      final model = iosInfo.model;
      _deviceName = '${name ?? 'Unknown'} ${model ?? ''}';
      _deviceOSVersion = '${systemName ?? 'Unknown'} ${systemVersion ?? '0.0'}';
    }
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
