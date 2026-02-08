import 'dart:io';

import 'package:flutter/foundation.dart';

const Map<String, String> kContentTypeJsonHeader = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

const Map<String, String> kContentTypeMultipartHeader = {
  HttpHeaders.contentTypeHeader: 'multipart/form-data',
};

typedef LeafDioDeviceOSHeader = Map<String, String> Function(String os);
typedef LeafDioVersionHeader = Map<String, String> Function(String version);
typedef LeafDioAuthorizationHeader =
    Map<String, String> Function(String authorization);

class LeafDioRequestHeader {
  static Map<String, dynamic> getHeaders({
    required String appVersion,
    String? authorization,
    String? userAgent,
    LeafDioDeviceOSHeader? deviceOSHeader,
    LeafDioVersionHeader? versionHeader,
    LeafDioAuthorizationHeader? authorizationHeader,
  }) {
    final os = defaultTargetPlatform.name.toUpperCase();

    Map<String, String> headers = {
      'X-LF-DEVICE-OS': os,
      'X-LF-APP-VERSION': appVersion,
    };
    if (authorization != null && authorization.isNotEmpty) {
      if (authorizationHeader != null) {
        headers.remove(HttpHeaders.authorizationHeader);
        headers.addAll(authorizationHeader(authorization));
      } else {
        headers[HttpHeaders.authorizationHeader] = authorization;
      }
    }
    if (deviceOSHeader != null) {
      headers.remove('X-LF-DEVICE-OS');
      headers.addAll(deviceOSHeader(os));
    }
    if (versionHeader != null) {
      headers.remove('X-LF-APP-VERSION');
      headers.addAll(versionHeader(appVersion));
    }
    if (userAgent != null) {
      headers.addAll({HttpHeaders.userAgentHeader: userAgent});
    }

    return headers;
  }
}
