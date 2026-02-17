import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../response/leaf_dio_response.dart';

/// HTTP 상태 코드별로 다른 에러 타입을 파싱하는 콜백.
///
/// `statusCode`: HTTP 상태 코드 (400, 401, 500 등)
/// `body`: 서버 응답 body (보통 `Map<String, dynamic>` 또는 String)
///
/// 반환값이 null이면 기존 제네릭 E 역직렬화로 fallback.
typedef LeafDioErrorParser = Object? Function(int statusCode, dynamic body);

abstract class LeafDioJsonConverter {
  FutureOr<LeafDioResponse<ResultType>>
  convertJsonResponse<ResultType, ResultErrorType>(Response response);
}

abstract class LeafDioExceptionConverterBase {
  FutureOr<LeafDioResponse<ResultType>> convertDioException<
    ResultType,
    ResultErrorType
  >(DioException dioException, {LeafDioErrorParser? errorParser});
}

dynamic getPrintBodyFromResponse(
  dynamic jsonData,
  Response response, {
  int printMaxLength = 2024,
}) {
  dynamic printBody;
  try {
    final prettyBody = const JsonEncoder.withIndent('  ').convert(jsonData);
    final maxLength = printMaxLength; // 최대 길이
    String body = prettyBody;
    if (prettyBody.length > maxLength) {
      final truncatedJsonString = prettyBody.substring(0, maxLength);
      body = '$truncatedJsonString\n......\n...\n';
    }
    printBody = body;
  } catch (_) {
    printBody = response.data;
  }
  return printBody;
}
