import 'dart:async';
import 'dart:convert';

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter_leaf_common/leaf_common.dart';

import '../../http_helper/http_exception.dart';
import '../response/lf_dio_response.dart';
import 'base/lf_dio_base_converter.dart';

class LFDioExceptionConverter implements DioConverter {
  final Serializers serializers;

  static Serializers? jsonSerializers;

  LFDioExceptionConverter({
    required this.serializers,
  }) {
    LFDioExceptionConverter.jsonSerializers = (serializers.toBuilder()
          ..addPlugin(
            StandardJsonPlugin(),
          ))
        .build();
  }

  T? _deserialize<T>(dynamic value) {
    final serializer = jsonSerializers?.serializerForType(T) as Serializer<T>?;
    if (serializer == null) {
      throw Exception('No serializer for type $T');
    }
    return jsonSerializers?.deserializeWith<T>(
      serializer,
      value,
    );
  }

  // BuiltList<T> _deserializeListOf<T>(Iterable value) => BuiltList(
  //       value.map((value) => _deserialize<T>(value)).toList(growable: false),
  //     );

  // dynamic _decode<T>(dynamic entity) {
  //   /// handle case when we want to access to Map<String, dynamic> directly
  //   /// getResource or getMapResource
  //   /// Avoid dynamic or unconverted value, this could lead to several issues
  //   if (entity is T) {
  //     return entity;
  //   }
  //
  //   try {
  //     if (entity is List) {
  //       return _deserializeListOf<T>(entity);
  //     }
  //     return _deserialize<T>(entity);
  //   } catch (e) {
  //     Logging.e(e);
  //     return null;
  //   }
  // }

  @override
  FutureOr<LFDioResponse<ResultType>> convertJsonResponse<ResultType>(
    Response response,
  ) async {
    return convertError<ResultType>(response);
  }

  FutureOr<LFDioResponse<ResultType>> convertError<ResultType>(
    Response response,
  ) async {
    final statusCode = response.statusCode ?? 0;
    final jsonData = response.data;
    final url = response.requestOptions.uri.toString();

    try {
      final prettyBody = const JsonEncoder.withIndent('  ').convert(jsonData);
      const maxLength = 2024; // 최대 길이
      String body = prettyBody;
      if (prettyBody.length > maxLength) {
        final truncatedJsonString = prettyBody.substring(0, maxLength);
        body = '$truncatedJsonString\n......\n...\n';
      }
      Logging.w(
        '[http_dio :: built_value_converter]\n'
        'statusCode: $statusCode\n'
        'url: $url\n'
        'body: $body\n'
        'ResultType: $ResultType',
      );
    } catch (_) {
      Logging.w(
        '[http_dio :: built_value_converter]\n'
        'statusCode: $statusCode\n'
        'url: $url\n'
        'body: ${response.data}\n'
        'ResultType: $ResultType',
      );
    }

    final body = jsonData;

    dynamic object;
    dynamic parserException;

    try {
      object ??= _deserialize<ResultType>(body);
    } catch (e) {
      parserException = e;
      object ??= body;
    }

    String errorMessage = (object is String) ? object : '';
    if (parserException != null) {
      errorMessage = '[ConvertError] ${parserException.toString()}';
    }

    final resultResponse = LFDioResponse<ResultType>(
      data: null,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      extra: response.extra,
      headers: response.headers,
    );

    if (object is ResultType) {
      return resultResponse..error = object;
    }

    HTTPException? exception;
    switch (statusCode) {
      case 400:
        exception = BadRequestException(
          statusCode,
          errorMessage,
          body,
        );
        break;
      case 401:
        exception = UnauthorisedException(
          statusCode,
          errorMessage,
          body,
        );
        break;
      case 404:
        exception = NotFoundException(
          statusCode,
          errorMessage,
          body,
        );
        break;
      case 408:
        exception = TimeoutRequestException(
          statusCode,
          errorMessage,
          body,
        );
        break;
      case 500:
        exception = InternalServerException(
          statusCode,
          errorMessage,
          body,
        );
        break;
      case 503:
        exception = ServiceUnavailableException(
          statusCode,
          errorMessage,
          body,
        );
        break;
      default:
        exception = HTTPException(
          statusCode,
          errorMessage,
          body,
        );
        break;
    }

    if (statusCode == 401) {
      throw exception;
    }
    return resultResponse..error = LFHttpExceptionObject(exception);
  }
}
