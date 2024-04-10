library lf_http_dio;

import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:flutter_leaf_manager/leaf_manager.dart';

import 'converter/lf_dio_built_value_converter.dart';
import 'converter/lf_dio_exception_converter.dart';
import 'interceptor/lf_dio_curl_interceptor.dart';
import 'interceptor/lf_dio_request_interceptor.dart';
import 'service/base/lf_dio_base_service.dart';

Type _typeOf<T>() => T;

class LFHttpDio {
  static final LFHttpDio _instance = LFHttpDio._internal();

  static LFHttpDio get shared => _instance;

  LFHttpDio._internal() {
    Logging.d('LFHttpDio Init');
  }

  late Dio dio;
  late LFDioBuiltValueConverter converter;
  late LFDioExceptionConverter errorConverter;
  final Map<Type, DioService> _services = {};

  void init({
    required Uri baseUrl,
    required Serializers responseSerializers,
    required List<DioService> services,
    LFHttpDioOnHeader? onHeader,
    VoidCallback? onAuthenticatorSuccess,
    VoidCallback? onAuthenticatorFailed,
    VoidCallback? onAuthenticatorFailedToSingIn,
  }) {
    final options = BaseOptions(
      baseUrl: baseUrl.toString(),
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 60),
    );

    // Converter
    converter = LFDioBuiltValueConverter(
      serializers: responseSerializers,
    );
    errorConverter = LFDioExceptionConverter(
      serializers: responseSerializers,
    );

    dio = Dio(options);
    dio.interceptors.add(LFDioCurlInterceptor());
    dio.interceptors.add(LFDioRequestInterceptor(onHeader: onHeader));
    // dio.interceptors.add(
    //   LFDioAuthInterceptor(
    //     dio,
    //     onSuccess: onAuthenticatorSuccess,
    //     onFailed: onAuthenticatorFailed,
    //     onFailedToSignIn: onAuthenticatorFailedToSingIn,
    //   ),
    // );

    // Setup Services
    services.toSet().forEach((s) {
      s.dio = dio;
      s.converter = converter;
      s.errorConverter = errorConverter;
      _services[s.runtimeType] = s;
    });
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
