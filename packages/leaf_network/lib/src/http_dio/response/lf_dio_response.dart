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

  bool get isSuccessful {
    final statusCode = this.statusCode ?? 0;
    return statusCode >= 200 && statusCode < 300;
  }

  LFHttpExceptionObject? get exceptionObject {
    final error = this.error;
    if (error is LFHttpExceptionObject) {
      return error;
    }
    return null;
  }

  HTTPException? get httpException {
    final error = this.error;
    if (error is LFHttpExceptionObject) {
      return error.exception;
    }
    return null;
  }
}
