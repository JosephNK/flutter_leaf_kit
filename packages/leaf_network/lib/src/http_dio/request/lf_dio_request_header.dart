import 'dart:io';

import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:flutter_leaf_manager/leaf_manager.dart';

const Map<String, String> kContentTypeJsonHeader = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

const Map<String, String> kContentTypeMultipartHeader = {
  HttpHeaders.contentTypeHeader: 'multipart/form-data',
};

typedef LFDioDeviceOSHeader = Map<String, String> Function(String os);
typedef LFDioVersionHeader = Map<String, String> Function(String version);
typedef LFDioAuthorizationHeader = Map<String, String> Function(
    String authorization);

class LFDioRequestHeader {
  static Future<Map<String, dynamic>> getHeaders({
    String? authorization,
    String? userAgent,
    LFDioDeviceOSHeader? deviceOSHeader,
    LFDioVersionHeader? versionHeader,
    LFDioAuthorizationHeader? authorizationHeader,
  }) async {
    final os = Platform.isIOS ? DeviceOS.ios : DeviceOS.android;
    final appVersion = (await PlatformPackage.fromInfo()).packageVersion;

    Map<String, String> headers = {
      'X-LF-DEVICE-OS': os.value,
      'X-LF-APP-VERSION': appVersion,
    };
    if (isNotEmpty(authorization) && authorization != null) {
      if (authorizationHeader != null) {
        headers.remove(HttpHeaders.authorizationHeader);
        headers.addAll(authorizationHeader(authorization));
      } else {
        // headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
        headers[HttpHeaders.authorizationHeader] = authorization;
      }
    }
    if (deviceOSHeader != null) {
      headers.remove('X-LF-DEVICE-OS');
      headers.addAll(deviceOSHeader(os.value));
    }
    if (versionHeader != null) {
      headers.remove('X-LF-APP-VERSION');
      headers.addAll(versionHeader(appVersion));
    }
    if (userAgent != null) {
      headers.addAll({
        HttpHeaders.userAgentHeader: userAgent,
      });
    }

    return headers;
  }
}
