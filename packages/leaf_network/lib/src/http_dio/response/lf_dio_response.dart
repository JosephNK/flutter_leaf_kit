import 'package:dio/dio.dart';

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
}
