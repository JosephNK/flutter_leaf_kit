import 'dart:io';

import 'package:flutter_leaf_common/leaf_common.dart';

const Map<String, String> kContentTypeJsonHeader = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

const Map<String, String> kContentTypeMultipartHeader = {
  HttpHeaders.contentTypeHeader: 'multipart/form-data',
};

typedef LeafDioLeafDeviceOSHeader = Map<String, String> Function(String os);
typedef LeafDioVersionHeader = Map<String, String> Function(String version);
typedef LeafDioAuthorizationHeader = Map<String, String> Function(
    String authorization);

class LeafDioRequestHeader {
  static Map<String, dynamic> getHeaders({
    required String appVersion,
    String? authorization,
    String? userAgent,
    LeafDioLeafDeviceOSHeader? deviceOSHeader,
    LeafDioVersionHeader? versionHeader,
    LeafDioAuthorizationHeader? authorizationHeader,
  }) {
    final os = Platform.isIOS ? LeafDeviceOS.ios : LeafDeviceOS.android;

    Map<String, String> headers = {
      'X-LF-DEVICE-OS': os.value,
      'X-LF-APP-VERSION': appVersion,
    };
    if (isNotEmpty(authorization) && authorization != null) {
      if (authorizationHeader != null) {
        headers.remove(HttpHeaders.authorizationHeader);
        headers.addAll(authorizationHeader(authorization));
      } else {
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
