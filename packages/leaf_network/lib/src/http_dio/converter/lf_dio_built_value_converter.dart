import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter_leaf_common/leaf_common.dart';

import '../../http_helper/http_exception.dart';
import '../response/lf_dio_response.dart';
import 'lf_dio_base_converter.dart';
import 'lf_dio_built_value_json_key.dart';

class LFDioBuiltValueConverter implements DioJsonConverter {
  final Serializers serializers;
  final int printMaxLength;
  final LFDioBuiltValueJSONUndefinedKey? jsonUndefinedKey;

  static Serializers? jsonSerializers;

  LFDioBuiltValueConverter({
    required this.serializers,
    this.printMaxLength = 2024,
    this.jsonUndefinedKey,
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

  // BuiltList<T> _deserializeListOf<T>(Iterable value) => BuiltList(
  //       value.map((value) => _deserialize<T>(value)).toList(growable: false),
  //     );

  dynamic _decode<T>(dynamic entity) {
    /// handle case when we want to access to Map<String, dynamic> directly
    /// getResource or getMapResource
    /// Avoid dynamic or unconverted value, this could lead to several issues
    if (entity is T) {
      return entity;
    }

    try {
      dynamic deserializeEntity = entity;
      if (jsonUndefinedKey != null) {
        final collectionKey = jsonUndefinedKey!.collectionKey;
        final objectKey = jsonUndefinedKey!.objectKey;
        final excludeStructs = jsonUndefinedKey!.excludeStructs ?? [];

        if (entity is List) {
          /// collectionKey 설정시,
          /// (entity 데이터 collectionKey 묶는 용도)

          /// example
          /// [{'name': 'Kim'}, {'name': 'Park'}]
          deserializeEntity = {'$collectionKey': entity};
        } else {
          /// objectKey 설정시,
          /// entity 데이터 Keys 중에서 없는 Key 로 설정.
          /// (objectKey 는 임의로 Single Object 묶는 용도)

          /// example
          /// "Kim", 5232, false
          if (entity is! Map) {
            deserializeEntity = {'$objectKey': entity};
          }
        }

        /// example
        /// { "data" : [], "meta": {} }, { "age": 10, 'name': "Kim" }
        if (entity is Map) {
          bool isPass = false;
          final entityKeys = entity.keys;
          for (var excludeStruct in excludeStructs) {
            final excludeKeys = excludeStruct.keys;
            final existCount = excludeKeys
                .where((excludeKey) => entityKeys.contains(excludeKey))
                .length;
            if (excludeKeys.length == existCount) {
              isPass = true;
              break;
            }
          }
          if (!isPass) {
            deserializeEntity = {'$objectKey': entity};
          }
        }
      }
      return _deserialize<T>(deserializeEntity);
    } catch (e) {
      Logging.e(e);
      rethrow;
    }
  }

  @override
  FutureOr<LFDioResponse<ResultType>>
      convertJsonResponse<ResultType, ResultErrorType>(
    Response response,
  ) async {
    return convertSuccess<ResultType, ResultErrorType>(response);
  }

  FutureOr<LFDioResponse<ResultType>>
      convertSuccess<ResultType, ResultErrorType>(
    Response response,
  ) async {
    final statusCode = response.statusCode ?? 0;
    final requestOptions = response.requestOptions;
    final statusMessage = response.statusMessage;
    final isRedirect = response.isRedirect;
    final redirects = response.redirects;
    final extra = response.extra;
    final headers = response.headers;
    final method = requestOptions.method;
    final url = requestOptions.uri.toString();
    final jsonData = response.data;

    dynamic printBody = getPrintBodyFromResponse(
      jsonData,
      response,
      printMaxLength: printMaxLength,
    );

    Logging.i(
      '[http_dio :: built_value_converter convertSuccess]\n'
      '[*] statusCode: $statusCode\n'
      '[*] method: $method\n'
      '[*] url: $url\n'
      '[*] body: $printBody\n'
      '[*] ResultType: $ResultType\n'
      '[*] ResultErrorType: $ResultErrorType',
    );

    final body = jsonData;
    dynamic bodyObject, bodyErrorObject;
    dynamic parserException;

    try {
      bodyObject = _decode<ResultType>(body);
    } catch (e) {
      parserException = e;
      bodyErrorObject = body;
    }

    String errorMessage =
        ((bodyErrorObject is String) ? bodyErrorObject : '').trim();
    if (isNotEmpty(errorMessage)) {
      Logging.i(
        '[http_dio :: built_value_converter errorMessage]\n'
        '[*] errorMessage: $errorMessage\n'
        '[*] ResultType: $ResultType\n'
        '[*] ResultErrorType: $ResultErrorType',
      );
      errorMessage = '[DioBuiltValue ConvertError] $errorMessage';
    }
    if (parserException != null) {
      Logging.i(
        '[http_dio :: built_value_converter parserException]\n'
        '[*] parserException: $parserException\n'
        '[*] ResultType: $ResultType\n'
        '[*] ResultErrorType: $ResultErrorType',
      );
      final message = parserException.toString();
      errorMessage = '[DioBuiltValue ConvertError] $message';
    }

    HTTPException? exception;
    if (isNotEmpty(errorMessage)) {
      exception = UnknownException(
        statusCode,
        errorMessage,
        body,
      );
    }

    final successResponse = LFDioResponse<ResultType>(
      data: (bodyObject is ResultType) ? bodyObject : null,
      requestOptions: requestOptions,
      statusCode: statusCode,
      statusMessage: statusMessage,
      isRedirect: isRedirect,
      redirects: redirects,
      extra: extra,
      headers: headers,
    );

    if (exception != null) {
      return successResponse
        ..error = null
        ..exception = LFHttpExceptionObject(
          exception,
        );
    }

    return successResponse;
  }
}
