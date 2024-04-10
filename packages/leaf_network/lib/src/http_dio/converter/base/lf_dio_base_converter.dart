import 'dart:async';

import 'package:dio/dio.dart';

import '../../response/lf_dio_response.dart';

abstract class DioConverter {
  FutureOr<LFDioResponse<ResultType>> convertJsonResponse<ResultType>(
    Response response,
  );
}
