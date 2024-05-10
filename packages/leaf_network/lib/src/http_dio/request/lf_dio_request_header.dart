import 'dart:io';

import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:flutter_leaf_manager/leaf_manager.dart';

const Map<String, String> kContentTypeJsonHeader = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

const Map<String, String> kContentTypeMultipartHeader = {
  HttpHeaders.contentTypeHeader: 'multipart/form-data',
};

class LFDioRequestHeader {
  static Future<Map<String, dynamic>> getHeaders({
    String? authorization,
  }) async {
    final os = Platform.isIOS ? DeviceOS.ios : DeviceOS.android;
    final appVersion = (await PlatformPackage.fromInfo()).packageVersion;

    Map<String, String> headers = {
      'X-LF-DEVICE-OS': os.value,
      'X-LF-APP-VERSION': appVersion,
    };
    if (isNotEmpty(authorization)) {
      // headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
      headers[HttpHeaders.authorizationHeader] = authorization!;
    }

    return headers;
  }
}
