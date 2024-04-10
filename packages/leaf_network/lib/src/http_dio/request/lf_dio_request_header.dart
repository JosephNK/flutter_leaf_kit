import 'dart:io';

import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:flutter_leaf_manager/leaf_manager.dart';

const Map<String, String> kJsonHeader = {
  'content-type': 'application/json',
};

const Map<String, String> kMultipartHeader = {
  'content-Type': 'multipart/form-data',
};

class LFDioRequestHeader {
  static Future<Map<String, String>> getHeaders({String? accessToken}) async {
    final os = Platform.isIOS ? DeviceOS.ios : DeviceOS.android;
    final appVersion = (await PlatformPackage.fromInfo()).packageVersion;

    Map<String, String> headers = {
      'X-LF-DEVICE-OS': os.value,
      'X-LF-APP-VERSION': appVersion,
    };
    if (isNotEmpty(accessToken)) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return headers;
  }
}
