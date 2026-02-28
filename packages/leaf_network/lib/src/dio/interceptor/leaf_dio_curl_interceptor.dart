import 'dart:convert';

import 'package:dio/dio.dart';
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
    // add a breakpoint here so all errors can break
    try {
      LeafLogging.d(_cURLRepresentation(requestOptions));
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
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      // FormData can't be JSON-serialized, so keep only their fields attributes
      if (options.data is FormData) {
        final FormData data = options.data;
        final fields = data.fields;
        final files = data.files;

        options.data = Map.fromEntries(fields);

        for (var file in files) {
          components.add('-f "${file.key}=@${file.value.filename}"');
        }
      }

      final data = json.encode(options.data).replaceAll('"', '\\"');
      components.add('-d "$data"');
    }

    components.add('"${options.uri.toString()}"');

    return components.join(' \\\n\t');
  }
}
