import 'package:dio/dio.dart';

import '../converter/lf_dio_built_value_converter.dart';
import '../converter/lf_dio_exception_converter.dart';
import '../response/lf_dio_response.dart';

abstract class DioService {
  late Dio dio;
  late LFDioBuiltValueConverter converter;
  late LFDioExceptionConverter errorConverter;
}

class LFDioService extends DioService {
  /// Convenience method to make an HTTP GET request.
  Future<LFDioResponse<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return await converter.convertJsonResponse<T>(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return await errorConverter.convertJsonResponse<T>(e.response!);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// Convenience method to make an HTTP POST request.
  Future<LFDioResponse<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return await converter.convertJsonResponse<T>(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return await errorConverter.convertJsonResponse<T>(e.response!);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// Convenience method to make an HTTP PUT request.
  Future<LFDioResponse<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return await converter.convertJsonResponse<T>(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return await errorConverter.convertJsonResponse<T>(e.response!);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// Convenience method to make an HTTP DELETE request.
  Future<LFDioResponse<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return await converter.convertJsonResponse<T>(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return await errorConverter.convertJsonResponse<T>(e.response!);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
