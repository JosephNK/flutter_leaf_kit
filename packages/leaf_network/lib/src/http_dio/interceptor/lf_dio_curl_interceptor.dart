import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class LFDioCurlInterceptor extends InterceptorsWrapper {
  LFDioCurlInterceptor();

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
      log(_cURLRepresentation(requestOptions));
    } catch (err) {
      log('unable to create a CURL representation of the requestOptions');
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
