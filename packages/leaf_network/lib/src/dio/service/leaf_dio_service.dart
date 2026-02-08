import 'package:dio/dio.dart';

import '../converter/leaf_dio_built_value_converter.dart';
import '../converter/leaf_dio_exception_converter.dart';
import '../response/leaf_dio_response.dart';

abstract class LeafDioServiceBase {
  late Dio dio;
  late LeafDioBuiltValueConverter converter;
  late LeafDioExceptionConverter errorConverter;
}

class LeafDioService extends LeafDioServiceBase {
  /// Convenience method to make an HTTP GET request.
  Future<LeafDioResponse<R>> get<R, E>(
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
      return await converter.convertJsonResponse<R, E>(response);
    } on DioException catch (e) {
      return await errorConverter.convertDioException<R, E>(e);
    } catch (e) {
      rethrow;
    }
  }

  /// Convenience method to make an HTTP POST request.
  Future<LeafDioResponse<R>> post<R, E>(
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
      return await converter.convertJsonResponse<R, E>(response);
    } on DioException catch (e) {
      return await errorConverter.convertDioException<R, E>(e);
    } catch (e) {
      rethrow;
    }
  }

  /// Convenience method to make an HTTP PUT request.
  Future<LeafDioResponse<R>> put<R, E>(
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
      return await converter.convertJsonResponse<R, E>(response);
    } on DioException catch (e) {
      return await errorConverter.convertDioException<R, E>(e);
    } catch (e) {
      rethrow;
    }
  }

  /// Convenience method to make an HTTP DELETE request.
  Future<LeafDioResponse<R>> delete<R, E>(
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
      return await converter.convertJsonResponse<R, E>(response);
    } on DioException catch (e) {
      return await errorConverter.convertDioException<R, E>(e);
    } catch (e) {
      rethrow;
    }
  }
}
