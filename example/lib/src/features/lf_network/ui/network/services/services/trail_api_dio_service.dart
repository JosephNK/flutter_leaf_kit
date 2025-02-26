import 'package:flutter_leaf_kit/flutter_leaf_kit_network.dart';

import '../responses/responses.dart';

class TrailApiDioService extends LFDioService {
  Future<LFDioResponse<TrailApiResponse>> timeout() async {
    try {
      const url = '/api/timeout';
      const queryParameters = <String, dynamic>{
        'delay': 10000,
      };
      return await get<TrailApiResponse, TrailErrorResponse>(
        url,
        queryParameters: queryParameters,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<LFDioResponse<TrailApiResponse>> notfound() async {
    try {
      const url = '/api/notfound';
      const queryParameters = <String, dynamic>{
        'force': true,
      };
      return await get<TrailApiResponse, TrailErrorResponse>(
        url,
        queryParameters: queryParameters,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<LFDioResponse<TrailApiResponse>> serializerError() async {
    try {
      const url = '/api/serializernumber';
      return await get<TrailApiResponse, TrailErrorResponse>(
        url,
      );
    } catch (e) {
      rethrow;
    }
  }
}
