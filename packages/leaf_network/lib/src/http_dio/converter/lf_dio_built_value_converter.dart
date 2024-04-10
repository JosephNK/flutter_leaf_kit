import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter_leaf_common/leaf_common.dart';

import '../response/lf_dio_response.dart';
import 'base/lf_dio_base_converter.dart';

class LFDioBuiltValueConverter implements DioConverter {
  final Serializers serializers;

  static Serializers? jsonSerializers;

  LFDioBuiltValueConverter({
    required this.serializers,
  }) {
    LFDioBuiltValueConverter.jsonSerializers = (serializers.toBuilder()
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

  BuiltList<T> _deserializeListOf<T>(Iterable value) => BuiltList(
        value.map((value) => _deserialize<T>(value)).toList(growable: false),
      );

  dynamic _decode<T>(dynamic entity) {
    /// handle case when we want to access to Map<String, dynamic> directly
    /// getResource or getMapResource
    /// Avoid dynamic or unconverted value, this could lead to several issues
    if (entity is T) {
      return entity;
    }

    try {
      if (entity is List) {
        return _deserializeListOf<T>(entity);
      }
      return _deserialize<T>(entity);
    } catch (e) {
      Logging.e(e);
      return null;
    }
  }

  @override
  FutureOr<LFDioResponse<ResultType>> convertJsonResponse<ResultType>(
    Response response,
  ) async {
    return convertSuccess<ResultType>(response);
  }

  FutureOr<LFDioResponse<ResultType>> convertSuccess<ResultType>(
    Response response,
  ) async {
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
      Logging.i(
        '[http_dio :: built_value_converter]\n'
        'url: $url\n'
        'body: $body\n'
        'ResultType: $ResultType',
      );
    } catch (_) {
      Logging.i(
        '[http_dio :: built_value_converter]\n'
        'url: $url\n'
        'body: ${response.data}\n'
        'ResultType: $ResultType',
      );
    }

    final body = _decode<ResultType>(jsonData);

    return LFDioResponse<ResultType>(
      data: body,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      extra: response.extra,
      headers: response.headers,
    );
  }
}