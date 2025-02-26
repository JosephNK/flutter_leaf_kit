import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../services/services/products_dio_service.dart';
import '../services/services/profile_dio_service.dart';
import '../services/services/trail_api_dio_service.dart';

class NetworkRepository {
  Future<void> getProductAll(LFHttpDio httpDio) async {
    try {
      final apiService = httpDio.getService<ProductsDioService>();
      final response = await apiService.getProductAll(limit: 5);
      if (response.isSuccessful) {
        final body = response.data;
        Logging.d('Network_body: $body');
      } else {
        final error = response.error;
        Logging.e('Network_error: $error');
      }
    } on Exception catch (e) {
      Logging.e('Network_Exception e: $e');
    }
  }

  Future<void> getTimeout(LFHttpDio httpDio) async {
    try {
      final apiService = httpDio.getService<TrailApiDioService>();
      final response = await apiService.timeout();
      if (response.isSuccessful) {
        final body = response.data;
        final message = body?.message;
        Logging.d('Network_body: $body');
        Logging.d('Network_message: $message');
      } else {
        final httpException = response.httpException;
        Logging.e('Network_error: $httpException');
      }
    } on Exception catch (e) {
      Logging.e('Network_Exception e: $e');
    }
  }

  Future<void> getNotfound(LFHttpDio httpDio) async {
    try {
      final apiService = httpDio.getService<TrailApiDioService>();
      final response = await apiService.notfound();
      if (response.isSuccessful) {
        final body = response.data;
        final message = body?.message;
        Logging.d('Network_body: $body');
        Logging.d('Network_message: $message');
      } else {
        final error = response.error;
        final httpException = response.httpException;
        Logging.e('Network_error: $error');
        Logging.e('Network_error: $httpException');
      }
    } on Exception catch (e) {
      Logging.e('Network_Exception e: $e');
    }
  }

  Future<void> getSerializerError(LFHttpDio httpDio) async {
    try {
      final apiService = httpDio.getService<TrailApiDioService>();
      final response = await apiService.serializerError();
      if (response.isSuccessful) {
        final body = response.data;
        final message = body?.message;
        Logging.d('Network_body: $body');
        Logging.d('Network_message: $message');
      } else {
        final error = response.error;
        final httpException = response.httpException;
        Logging.e('Network_error: $error');
        Logging.e('Network_error: $httpException');
      }
    } on Exception catch (e) {
      Logging.e('Network_Exception e: $e');
    }
  }

  Future<void> getProfileMe(LFHttpDio httpDio) async {
    try {
      final apiService = httpDio.getService<ProfileDioService>();
      final response = await apiService.getProfileMe();
      if (response.isSuccessful) {
        final body = response.data;
        final item = body?.item;
        Logging.d('Network_body: $body');
        Logging.d('Network_item: $item');
      } else {
        final error = response.error;
        Logging.e('Network_error: $error');
      }
    } on Exception catch (e) {
      Logging.e('Network_Exception e: $e');
    }
  }

  Future<void> postProductAdd(
    LFHttpDio httpDio, {
    required List<LFMultipartFile> files,
  }) async {
    try {
      final apiService = httpDio.getService<ProductsDioService>();
      final response = await apiService.postProductAdd(
        title: 'Test Title',
        files: files,
      );
      if (response.isSuccessful) {
        final body = response.data;
        Logging.d('Network_body: $body');
      } else {
        final error = response.error;
        Logging.e('Network_error: $error');
      }
    } on Exception catch (e) {
      Logging.e('Network_Exception e: $e');
    }
  }
}
