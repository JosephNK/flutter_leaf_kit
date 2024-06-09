import 'package:flutter_leaf_kit/flutter_leaf_kit_common.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_network.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_store.dart';

import '../responses/responses.dart';

class ProductsDioService extends DioService {
  Future<LFDioResponse<ProductsGetAllResponse>> get({
    int limit = 5,
  }) async {
    try {
      const url = '/products';
      final response = await dio.get(url, queryParameters: {
        'limit': limit,
      });
      return await converter
          .convertJsonResponse<ProductsGetAllResponse>(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return await errorConverter
            .convertJsonResponse<ProductsGetAllResponse>(e.response!);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<LFDioResponse<ProductsGetAllResponse>> postAdd({
    required String title,
    List<LFMultipartFile> files = const [],
  }) async {
    try {
      const url = '/products/add';
      final uploadFiles = files
          .map((file) {
            final path = file.getFile()?.path;
            if (path == null) return null;
            print('path: $path');
            print('path1: ${file.getPayload<String>()}');
            return MultipartFile.fromFileSync(
              path,
              filename: '${file.getPayload<String>()}.jpg',
              contentType: MediaType('image', 'jpeg'),
            );
          })
          .whereNotNull()
          .toList();
      final formData = FormData.fromMap({
        'images': uploadFiles,
        'title': title,
      });
      final response = await dio.post(url, data: formData);
      return await converter
          .convertJsonResponse<ProductsGetAllResponse>(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return await errorConverter
            .convertJsonResponse<ProductsGetAllResponse>(e.response!);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
