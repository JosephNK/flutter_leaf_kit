part of '../lf_common.dart';

enum DeviceOS {
  unknown,
  android,
  ios,
}

extension DeviceOSExt on DeviceOS {
  String get value {
    switch (this) {
      case DeviceOS.unknown:
        return 'UNKNOWN';
      case DeviceOS.android:
        return 'ANDROID';
      case DeviceOS.ios:
        return 'IOS';
    }
  }
}
