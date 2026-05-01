import 'dart:async';
import 'dart:developer' as developer;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_leaf_common/leaf_common.dart';

import '../response/leaf_dio_response.dart';
import 'leaf_dio_converter.dart';

class LeafDioExceptionConverter implements LeafDioExceptionConverterBase {
  final Serializers serializers;

  static Serializers? jsonSerializers;

  LeafDioExceptionConverter({required this.serializers}) {
    LeafDioExceptionConverter.jsonSerializers =
        (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
  }

  T? _deserialize<T>(dynamic value) {
    final serializer = jsonSerializers?.serializerForType(T) as Serializer<T>?;
    if (serializer == null) {
      throw Exception('No serializer for type $T');
    }
    return jsonSerializers?.deserializeWith<T>(serializer, value);
  }

  @override
  FutureOr<LeafDioResponse<ResultType, ResultErrorType>> convertDioException<
    ResultType,
    ResultErrorType
  >(DioException dioException, {LeafDioErrorParser? errorParser}) {
    final dioResponse = dioException.response;
    if (dioResponse != null) {
      return convertError<ResultType, ResultErrorType>(
        dioResponse,
        errorParser: errorParser,
      );
    }
    return convertException<ResultType, ResultErrorType>(dioException);
  }

  FutureOr<LeafDioResponse<ResultType, ResultErrorType>> convertError<
    ResultType,
    ResultErrorType
  >(Response response, {LeafDioErrorParser? errorParser}) async {
    final statusCode = response.statusCode ?? 0;
    final method = response.requestOptions.method;
    final url = response.requestOptions.uri.toString();
    final jsonData = response.data;

    dynamic printBody = getPrintBodyFromResponse(jsonData, response);

    if (kDebugMode) {
      developer.log(
        '[http_dio :: built_value_converter convertError]\n'
        '[*] statusCode: $statusCode\n'
        '[*] method: $method\n'
        '[*] url: $url\n'
        '[*] body: $printBody\n'
        '[*] ResultType: $ResultType\n'
        '[*] ResultErrorType: $ResultErrorType',
        name: 'LeafDioExceptionConverter',
      );
    }

    final body = jsonData;
    dynamic bodyObject, bodyJsonObject;
    dynamic parserException;

    // 1. errorParser가 있으면 우선 사용
    if (errorParser != null) {
      try {
        bodyObject = errorParser(statusCode, body);
      } catch (e) {
        parserException = e;
        bodyJsonObject = body;
      }
    }

    // 2. errorParser가 없거나 파싱 실패 시, 기존 E 역직렬화 fallback
    if (bodyObject == null && errorParser == null) {
      try {
        bodyObject ??= _deserialize<ResultErrorType>(body);
      } catch (e) {
        parserException ??= e;
        bodyJsonObject ??= body;
      }

      if (ResultErrorType.toString() == 'Null') {
        try {
          bodyObject = _deserialize<ResultType>(body);
        } catch (e) {
          parserException = e;
          bodyJsonObject = body;
        }
      }
    }

    String errorJsonString = (bodyJsonObject is String) ? bodyJsonObject : '';
    if (parserException != null && isEmpty(errorJsonString)) {
      errorJsonString = parserException.toString();
    }

    final errorResponse = LeafDioResponse<ResultType, ResultErrorType>(
      data: null,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      extra: response.extra,
      headers: response.headers,
    );

    LeafHttpException? exception;
    switch (statusCode) {
      case 400:
        exception = LeafBadRequestException(statusCode, errorJsonString, body);
        break;
      case 401:
        exception = LeafUnauthorisedException(
          statusCode,
          errorJsonString,
          body,
        );
        break;
      case 404:
        exception = LeafNotFoundException(statusCode, errorJsonString, body);
        break;
      case 408:
        exception = LeafTimeoutRequestException(
          statusCode,
          errorJsonString,
          body,
        );
        break;
      case 500:
        exception = LeafInternalServerException(
          statusCode,
          errorJsonString,
          body,
        );
        break;
      case 503:
        exception = LeafServiceUnavailableException(
          statusCode,
          errorJsonString,
          body,
        );
        break;
      default:
        exception = LeafUnknownException(statusCode, errorJsonString, body);
        break;
    }

    return errorResponse
      ..error = LeafErrorObject(value: bodyObject)
      ..exception = LeafHttpExceptionObject(exception);
  }

  FutureOr<LeafDioResponse<ResultType, ResultErrorType>>
  convertException<ResultType, ResultErrorType>(DioException e) async {
    final dioExceptionType = e.type;
    final dioExceptionMessage = e.message ?? 'Unknown DioException';

    LeafDioResponse<ResultType, ResultErrorType> resultResponse =
        LeafDioResponse<ResultType, ResultErrorType>(
          requestOptions: RequestOptions(),
        );

    LeafHttpException? exception;
    switch (dioExceptionType) {
      case DioExceptionType.connectionTimeout:
        exception = LeafConnectionTimeoutException(
          -99990,
          dioExceptionMessage,
          null,
        );
        break;
      case DioExceptionType.sendTimeout:
        exception = LeafSendTimeoutException(-99991, dioExceptionMessage, null);
        break;
      case DioExceptionType.receiveTimeout:
        exception = LeafReceiveTimeoutException(
          -99992,
          dioExceptionMessage,
          null,
        );
        break;
      case DioExceptionType.badCertificate:
        exception = LeafBadCertificateException(
          -99993,
          dioExceptionMessage,
          null,
        );
        break;
      case DioExceptionType.badResponse:
        exception = LeafBadResponseException(-99994, dioExceptionMessage, null);
        break;
      case DioExceptionType.cancel:
        exception = LeafCancelException(-99995, dioExceptionMessage, null);
        break;
      case DioExceptionType.connectionError:
        exception = LeafConnectionErrorException(
          -99996,
          dioExceptionMessage,
          null,
        );
        break;
      case DioExceptionType.unknown:
        exception = LeafUnknownException(-99999, dioExceptionMessage, null);
        break;
    }

    return resultResponse..exception = LeafHttpExceptionObject(exception);
  }
}
