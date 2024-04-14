import 'package:flutter_leaf_kit/flutter_leaf_kit_network.dart';

import '../responses/responses.dart';

class CurrencyDioService extends DioService {
  Future<LFDioResponse<CurrencyResponse>> get() async {
    const url = '/v1/currency?from=krw&to=jpy';
    try {
      final response = await dio.get(url);
      return await converter.convertJsonResponse<CurrencyResponse>(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return await errorConverter
            .convertJsonResponse<CurrencyResponse>(e.response!);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
