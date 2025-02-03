import 'package:flutter_leaf_kit/flutter_leaf_kit_network.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_store.dart';

import '../responses/responses.dart';

class ProductsDioService extends LFDioService {
  Future<LFDioResponse<ProductsGetAllResponse>> getProductAll({
    int limit = 5,
  }) async {
    try {
      const url = '/products';
      final queryParameters = {
        'limit': limit,
      };
      return await get<ProductsGetAllResponse>(
        url,
        queryParameters: queryParameters,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<LFDioResponse<ProductsGetAllResponse>> postProductAdd({
    required String title,
    List<LFMultipartFile> files = const [],
  }) async {
    try {
      const url = '/products/add';
      final uploadFiles = files
          .map((file) {
            final path = file.getPath();
            if (path == null) return null;
            return MultipartFile.fromFileSync(
              path,
              filename: '${file.getPayload()}.jpg',
              contentType: MediaType('image', 'jpeg'),
            );
          })
          .nonNulls
          .toList();
      final formData = FormData.fromMap({
        'images': uploadFiles,
        'title': title,
      });
      return await post<ProductsGetAllResponse>(
        url,
        data: formData,
      );
    } catch (e) {
      rethrow;
    }
  }
}
