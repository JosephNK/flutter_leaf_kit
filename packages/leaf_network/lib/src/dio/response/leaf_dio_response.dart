import 'dart:convert';

import 'package:dio/dio.dart';

import '../../exception/leaf_http_exception.dart';

class LeafDioResponse<T> extends Response<T> {
  LeafDioResponse({
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
  LeafHttpExceptionObject? exception;

  bool get isSuccessful {
    final statusCode = this.statusCode ?? 0;
    return (statusCode >= 200 && statusCode < 400) &&
        error == null &&
        exception == null;
  }

  LeafHttpException? get httpException {
    final exception = this.exception;
    return exception?.exception;
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('LeafDioResponse<$T> {');

    // 상태 정보
    buffer.writeln('  statusCode: $statusCode,');
    buffer.writeln('  statusMessage: $statusMessage,');
    buffer.writeln('  isSuccessful: $isSuccessful,');

    // 에러 정보 (있을 때만)
    if (error != null) {
      buffer.writeln('  error: $error,');
    }
    if (exception != null) {
      buffer.writeln('  exception: $exception,');
    }

    // 데이터 정보
    if (data == null) {
      buffer.writeln('  data: null,');
    } else {
      buffer.write('  data: ');
      try {
        if (data is Map) {
          // Map은 JSON으로 인코딩 (읽기 쉽게)
          buffer.writeln(json.encode(data));
        } else if (data is List) {
          // List도 JSON으로 인코딩
          buffer.writeln(json.encode(data));
        } else if (data is String) {
          // String은 길이 제한 (너무 길면 잘라냄)
          final str = data as String;
          if (str.length > 200) {
            buffer.writeln(
              '"${str.substring(0, 200)}..." (${str.length} chars),',
            );
          } else {
            buffer.writeln('"$str",');
          }
        } else {
          // 그 외 객체는 toString() 호출
          buffer.writeln('$data,');
        }
      } catch (e) {
        // JSON 인코딩 실패 시 fallback
        buffer.writeln('${data.runtimeType} (encoding failed),');
      }
    }

    // 추가 정보 (디버깅용)
    buffer.writeln('  dataType: ${data.runtimeType},');
    buffer.writeln('  uri: ${requestOptions.uri},');
    buffer.writeln('  method: ${requestOptions.method},');

    buffer.write('}');
    return buffer.toString();
  }
}
