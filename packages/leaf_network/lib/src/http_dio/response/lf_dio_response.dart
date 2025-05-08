import 'package:dio/dio.dart';

import '../../http_helper/http_exception.dart';

class LFDioResponse<T> extends Response<T> {
  LFDioResponse({
    super.data,
    required super.requestOptions,
    super.statusCode,
    super.statusMessage,
    super.isRedirect,
    super.redirects,
    Map<String, dynamic> super.extra = const {},
    super.headers,
  });

  Object? error;
  LFHttpExceptionObject? exception;

  bool get isSuccessful {
    final statusCode = this.statusCode ?? 0;
    return (statusCode >= 200 && statusCode < 400) &&
        error == null &&
        exception == null;
  }

  HTTPException? get httpException {
    final exception = this.exception;
    return exception?.exception;
  }
}
