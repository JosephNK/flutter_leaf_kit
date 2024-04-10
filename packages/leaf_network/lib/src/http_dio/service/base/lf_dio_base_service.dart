import 'package:dio/dio.dart';

import '../../converter/lf_dio_built_value_converter.dart';
import '../../converter/lf_dio_exception_converter.dart';

abstract class DioService {
  late Dio dio;
  late LFDioBuiltValueConverter converter;
  late LFDioExceptionConverter errorConverter;
}
