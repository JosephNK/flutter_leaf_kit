import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_leaf_common/leaf_common.dart';

class LeafDioCurlInterceptor extends InterceptorsWrapper {
  LeafDioCurlInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _renderCurlRepresentation(err.requestOptions);

    return handler.next(err); //continue
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _renderCurlRepresentation(response.requestOptions);
    return handler.next(response); //continue
  }

  void _renderCurlRepresentation(RequestOptions requestOptions) {
    if (!kDebugMode) return;
    try {
      developer.log(
        _cURLRepresentation(requestOptions),
        name: 'LeafDioCurlInterceptor',
      );
    } catch (err) {
      LeafLogging.e(
        'unable to create a CURL representation of the requestOptions',
      );
    }
  }

  String _cURLRepresentation(RequestOptions options) {
    List<String> components = ['curl -i'];
    if (options.method.toUpperCase() != 'GET') {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        final escaped = '$v'.replaceAll('"', '\\"');
        components.add('-H "$k: $escaped"');
      }
    });

    if (options.data != null) {
      if (options.data is FormData) {
        final FormData formData = options.data;

        for (var field in formData.fields) {
          components.add('-F "${field.key}=${field.value}"');
        }
        for (var file in formData.files) {
          components.add('-F "${file.key}=@${file.value.filename}"');
        }
      } else {
        final data = json.encode(options.data).replaceAll('"', '\\"');
        components.add('-d "$data"');
      }
    }

    components.add('"${options.uri.toString()}"');

    return components.join(' \\\n\t');
  }
}
