import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_leaf_core/leaf_core.dart';

class LeafErrorObject extends Object {
  final Object? value;

  LeafErrorObject({this.value});

  @override
  String toString() {
    return value.toString();
  }
}

class LeafDioResponse<T, E> extends Response<T> {
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

  LeafErrorObject? _error;

  set error(LeafErrorObject? object) => _error = object;

  LeafHttpExceptionObject? _exception;

  set exception(LeafHttpExceptionObject? object) => _exception = object;

  bool get isSuccessful {
    final statusCode = this.statusCode ?? 0;
    return (statusCode >= 200 && statusCode < 400) &&
        _error == null &&
        _exception == null;
  }

  E? get error {
    final error = _error;
    if (error != null) {
      return error.value as E?;
    }
    return null;
  }

  bool get isHttpUnauthorisedException {
    final httpException = this.httpException;
    if (httpException is LeafUnauthorisedException) {
      return true;
    }
    return false;
  }

  LeafHttpException? get httpException {
    final exception = _exception;
    return exception?.httpException;
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
    if (_error != null) {
      buffer.writeln('  error: $_error,');
    }
    if (_exception != null) {
      buffer.writeln('  exception: $_exception,');
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
