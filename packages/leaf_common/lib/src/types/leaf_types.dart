enum LeafDeviceOS { unknown, android, ios }

extension LeafDeviceOSExt on LeafDeviceOS {
  String get value {
    switch (this) {
      case LeafDeviceOS.unknown:
        return 'UNKNOWN';
      case LeafDeviceOS.android:
        return 'ANDROID';
      case LeafDeviceOS.ios:
        return 'IOS';
    }
  }
}
