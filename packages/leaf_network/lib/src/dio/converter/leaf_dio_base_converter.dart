import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../response/leaf_dio_response.dart';

abstract class DioJsonConverter {
  FutureOr<LeafDioResponse<ResultType>>
  convertJsonResponse<ResultType, ResultErrorType>(Response response);
}

abstract class DioExceptionConverter {
  FutureOr<LeafDioResponse<ResultType>>
  convertDioException<ResultType, ResultErrorType>(DioException dioException);
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
