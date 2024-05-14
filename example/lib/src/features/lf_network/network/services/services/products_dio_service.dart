import 'package:flutter_leaf_kit/flutter_leaf_kit_network.dart';

import '../responses/responses.dart';

class ProductsDioService extends DioService {
  Future<LFDioResponse<ProductsGetPickResponse>> get({
    int limit = 5,
  }) async {
    const url = '/v1/products/pick';
    try {
      final response = await dio.get(url, queryParameters: {
        'limit': limit,
      });
      return await converter
          .convertJsonResponse<ProductsGetPickResponse>(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return await errorConverter
            .convertJsonResponse<ProductsGetPickResponse>(e.response!);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
