import 'package:flutter_leaf_kit/flutter_leaf_kit_network.dart';

import '../responses/responses.dart';

class ReviewsDioService extends DioService {
  Future<LFDioResponse<ReviewsGetsResponse>> get() async {
    const url =
        '/v1/reviews?uid=testUid1&includeImages=false&tag=tag1%2Ctag2&limit=10&sort=created_desc&page=1';
    try {
      final response = await dio.get(url);
      return await converter.convertJsonResponse<ReviewsGetsResponse>(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return await errorConverter
            .convertJsonResponse<ReviewsGetsResponse>(e.response!);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
