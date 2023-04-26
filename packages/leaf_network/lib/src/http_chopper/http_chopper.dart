library http_chopper;

import 'dart:async';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:chopper/chopper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart' as http;
import 'package:leaf_common/leaf_common.dart';

part 'src/converter/built_value_converter.dart';
part 'src/converter/http_exception_error_converter.dart';
part 'src/exception/http_exception.dart';
part 'src/interceptors/connect_interceptor.dart';
part 'src/interceptors/log_response_interceptor.dart';
part 'src/interceptors/throw_exception_interceptor.dart';
part 'src/override/http_override.dart';

class HTTPChopper {
  static final HTTPChopper _instance = HTTPChopper._internal();

  static HTTPChopper get shared => _instance;

  HTTPChopper._internal() {
    Logging.d('HTTPChopper Init');
    if (kDebugMode) {
      chopperLogger.onRecord.listen((rec) {
        final message = '# ChopperLogger (${rec.level.name})\n${rec.message}';
        switch (rec.level.name) {
          case 'INFO':
            Logging.i(message);
            break;
          case 'WARNING':
            Logging.w(message);
            break;
          default:
            Logging.d(message);
            break;
        }
      });
    }
  }

  void init({
    required Uri baseUrl,
    required Iterable<ChopperService> services,
    required Converter? converter,
    Iterable interceptors = const [],
    ErrorConverter? errorConverter,
    Authenticator? authenticator,
  }) {
    chopperClient = ChopperClient(
      client: http.IOClient(
        HttpClient()..connectionTimeout = const Duration(seconds: 30),
      ),
      baseUrl: baseUrl,
      converter: converter,
      errorConverter: errorConverter,
      interceptors: [
        ...interceptors,
        ConnectInterceptor(),
        CurlInterceptor(),
        LogResponseInterceptor(),
        ThrowExceptionInterceptor(),
      ],
      services: services,
      authenticator: authenticator,
    );
  }

  late ChopperClient chopperClient;
}
