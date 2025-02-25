import 'package:flutter_leaf_kit/flutter_leaf_kit_network.dart';

import '../responses/responses.dart';

class TrailApiDioService extends LFDioService {
  Future<LFDioResponse<TrailApiResponse>> timeout() async {
    try {
      const url = '/timeout';
      const queryParameters = <String, dynamic>{
        'delay': 10000,
      };
      return await get<TrailApiResponse>(
        url,
        queryParameters: queryParameters,
      );
    } catch (e) {
      rethrow;
    }
  }
}
