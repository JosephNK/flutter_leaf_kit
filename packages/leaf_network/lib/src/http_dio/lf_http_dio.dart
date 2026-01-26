import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:flutter_leaf_manager/leaf_manager.dart';

import 'converter/lf_dio_built_value_converter.dart';
import 'converter/lf_dio_built_value_json_key.dart';
import 'converter/lf_dio_exception_converter.dart';
import 'interceptor/lf_dio_curl_interceptor.dart';
import 'interceptor/lf_dio_request_interceptor.dart';
import 'service/lf_dio_base_service.dart';

export 'package:dio/dio.dart';

export 'converter/lf_dio_built_value_json_key.dart';
export 'interceptor/lf_dio_request_interceptor.dart';
export 'request/lf_dio_request_header.dart';
export 'response/lf_dio_response.dart';
export 'service/lf_dio_base_service.dart';

Type _typeOf<T>() => T;

typedef LFHttpDioInterceptorBuilder = List<Interceptor>? Function(Dio dio);

class LFHttpDio {
  late Dio dio;
  late LFDioBuiltValueConverter converter;
  late LFDioExceptionConverter errorConverter;
  final Map<Type, DioService> _services = {};

  Map<Type, DioService> get services => _services;

  LFHttpDio init({
    required Uri baseUrl,
    required Serializers responseSerializers,
    required List<DioService> services,
    LFHttpDioInterceptorBuilder? interceptorBuilder,
    LFDioBuiltValueJSONUndefinedKey? jsonUndefinedKey,
    Duration connectTimeout = const Duration(seconds: 5),
    Duration receiveTimeout = const Duration(seconds: 60),
    int printMaxLength = 2024,
    LFHttpDioOnHeader? onHeader,
  }) {
    final options = BaseOptions(
      baseUrl: baseUrl.toString(),
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );

    // Converter
    converter = LFDioBuiltValueConverter(
      serializers: responseSerializers,
      printMaxLength: printMaxLength,
      jsonUndefinedKey: jsonUndefinedKey,
    );
    errorConverter = LFDioExceptionConverter(
      serializers: responseSerializers,
      printMaxLength: printMaxLength,
    );

    dio = Dio(options);
    dio.interceptors.add(LFDioCurlInterceptor());
    dio.interceptors.add(LFDioRequestInterceptor(onHeader: onHeader));
    if (interceptorBuilder != null) {
      final interceptors = interceptorBuilder(dio);
      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
    }

    // Setup Services
    services.toSet().forEach((s) {
      s.dio = dio;
      s.converter = converter;
      s.errorConverter = errorConverter;
      _services[s.runtimeType] = s;
    });

    return this;
  }

  ServiceType getService<ServiceType extends DioService>() {
    final Type serviceType = _typeOf<ServiceType>();
    if (serviceType == dynamic || serviceType == DioService) {
      throw Exception(
        'Service type should be provided, `dynamic` is not allowed.',
      );
    }
    final DioService? service = _services[serviceType];
    if (service == null) {
      throw Exception('Service of type \'$serviceType\' not found.');
    }

    return service as ServiceType;
  }

  Future<File?> isExistFile({required String fileName}) async {
    final savePath = await getTemporarySavePath(fileName);
    if (File(savePath).existsSync()) {
      return File(savePath);
    }
    return null;
  }

  Future<File?> saveFile({required String fileName}) async {
    final savePath = await getTemporarySavePath(fileName);
    if (File(savePath).existsSync()) {
      return File(savePath);
    }
    return null;
  }

  Future<Response?> download(
    String urlPath, {
    required String fileName,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    final savePath = await getTemporarySavePath(fileName);
    try {
      final response = await dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static CancelToken createCancelToken() {
    return CancelToken();
  }
}

extension LFHttpDioHelper on LFHttpDio {
  Future<String> getTemporarySavePath(String fileName) async {
    final savePath =
        '${await LFFileManager.shared.getTemporaryDirectoryPath()}/$fileName';
    return savePath;
  }
}

/// Not Recommend

class LFHttpSharedDio {
  static final LFHttpSharedDio _instance = LFHttpSharedDio._internal();
  static LFHttpSharedDio get shared => _instance;
  LFHttpSharedDio._internal() {
    Logging.d('LFHttpSharedDio Init');
  }

  late LFHttpDio lfHttpDio;

  void init({
    required Uri baseUrl,
    required Serializers responseSerializers,
    required List<DioService> services,
    LFHttpDioInterceptorBuilder? interceptorBuilder,
    LFDioBuiltValueJSONUndefinedKey? jsonUndefinedKey,
    Duration connectTimeout = const Duration(seconds: 5),
    Duration receiveTimeout = const Duration(seconds: 60),
    int printMaxLength = 2024,
    LFHttpDioOnHeader? onHeader,
  }) {
    lfHttpDio = LFHttpDio().init(
      baseUrl: baseUrl,
      responseSerializers: responseSerializers,
      services: services,
      interceptorBuilder: interceptorBuilder,
      jsonUndefinedKey: jsonUndefinedKey,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      printMaxLength: printMaxLength,
      onHeader: onHeader,
    );
  }

  ServiceType getService<ServiceType extends DioService>() {
    final Type serviceType = _typeOf<ServiceType>();
    if (serviceType == dynamic || serviceType == DioService) {
      throw Exception(
        'Service type should be provided, `dynamic` is not allowed.',
      );
    }
    final DioService? service = lfHttpDio.services[serviceType];
    if (service == null) {
      throw Exception('Service of type \'$serviceType\' not found.');
    }

    return service as ServiceType;
  }
}
