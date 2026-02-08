import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter_leaf_common/leaf_common.dart';

import '../../http/exception/http_exception.dart';
import '../response/leaf_dio_response.dart';
import 'leaf_dio_base_converter.dart';

class LeafDioExceptionConverter implements DioExceptionConverter {
  final Serializers serializers;
  final int printMaxLength;

  static Serializers? jsonSerializers;

  LeafDioExceptionConverter({
    required this.serializers,
    this.printMaxLength = 2024,
  }) {
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
  FutureOr<LeafDioResponse<ResultType>>
  convertDioException<ResultType, ResultErrorType>(DioException dioException) {
    final dioResponse = dioException.response;
    if (dioResponse != null) {
      return convertError<ResultType, ResultErrorType>(dioResponse);
    }
    return convertException<ResultType, ResultErrorType>(dioException);
  }

  FutureOr<LeafDioResponse<ResultType>>
  convertError<ResultType, ResultErrorType>(Response response) async {
    final statusCode = response.statusCode ?? 0;
    final method = response.requestOptions.method;
    final url = response.requestOptions.uri.toString();
    final jsonData = response.data;

    dynamic printBody = getPrintBodyFromResponse(
      jsonData,
      response,
      printMaxLength: printMaxLength,
    );

    Logging.w(
      '[http_dio :: built_value_converter convertError]\n'
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
      bodyObject ??= _deserialize<ResultErrorType>(body);
    } catch (e) {
      parserException ??= e;
      bodyErrorObject ??= body;
    }

    if (ResultErrorType.toString() == 'Null') {
      try {
        bodyObject = _deserialize<ResultType>(body);
      } catch (e) {
        parserException = e;
        bodyErrorObject = body;
      }
    }

    String errorMessage = (bodyErrorObject is String) ? bodyErrorObject : '';
    if (isNotEmpty(errorMessage)) {
      errorMessage = '[DioException ConvertError] $errorMessage';
    }
    if (parserException != null && isEmpty(errorMessage)) {
      final message = parserException.toString();
      errorMessage = '[DioException ConvertError] $message';
    }

    final errorResponse = LeafDioResponse<ResultType>(
      data: null,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      extra: response.extra,
      headers: response.headers,
    );

    HTTPException? exception;
    switch (statusCode) {
      case 400:
        exception = BadRequestException(statusCode, errorMessage, body);
        break;
      case 401:
        exception = UnauthorisedException(statusCode, errorMessage, body);
        break;
      case 404:
        exception = NotFoundException(statusCode, errorMessage, body);
        break;
      case 408:
        exception = TimeoutRequestException(statusCode, errorMessage, body);
        break;
      case 500:
        exception = InternalServerException(statusCode, errorMessage, body);
        break;
      case 503:
        exception = ServiceUnavailableException(statusCode, errorMessage, body);
        break;
      default:
        exception = UnknownException(statusCode, errorMessage, body);
        break;
    }

    return errorResponse
      ..error = bodyObject
      ..exception = LeafHttpExceptionObject(exception);
  }

  FutureOr<LeafDioResponse<ResultType>>
  convertException<ResultType, ResultErrorType>(DioException e) async {
    final dioExceptionType = e.type;
    final dioExceptionMessage = e.message ?? 'Unknown DioException';

    LeafDioResponse<ResultType> resultResponse = LeafDioResponse<ResultType>(
      requestOptions: RequestOptions(),
    );

    HTTPException? exception;
    switch (dioExceptionType) {
      case DioExceptionType.connectionTimeout:
        exception = ConnectionTimeoutException(
          -99990,
          dioExceptionMessage,
          null,
        );
        break;
      case DioExceptionType.sendTimeout:
        exception = SendTimeoutException(-99991, dioExceptionMessage, null);
        break;
      case DioExceptionType.receiveTimeout:
        exception = ReceiveTimeoutException(-99992, dioExceptionMessage, null);
        break;
      case DioExceptionType.badCertificate:
        exception = BadCertificateException(-99993, dioExceptionMessage, null);
        break;
      case DioExceptionType.badResponse:
        exception = BadResponseException(-99994, dioExceptionMessage, null);
        break;
      case DioExceptionType.cancel:
        exception = CancelException(-99995, dioExceptionMessage, null);
        break;
      case DioExceptionType.connectionError:
        exception = ConnectionErrorException(-99996, dioExceptionMessage, null);
        break;
      case DioExceptionType.unknown:
        exception = UnknownException(-99999, dioExceptionMessage, null);
        break;
    }

    return resultResponse..exception = LeafHttpExceptionObject(exception);
  }
}
