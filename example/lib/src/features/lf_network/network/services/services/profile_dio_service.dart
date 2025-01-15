import 'package:flutter_leaf_kit/flutter_leaf_kit_network.dart';

import '../responses/responses.dart';

class ProfileDioService extends DioService {
  Future<LFDioResponse<ProfileMeGetResponse>> getProfileMe() async {
    try {
      const urlString = '/profile/me';
      final response = await dio.get(
        urlString,
        options: Options(
          headers: {
            "authorization": "Bearer aaa",
          },
        ),
      );
      return await converter
          .convertJsonResponse<ProfileMeGetResponse>(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return await errorConverter
            .convertJsonResponse<ProfileMeGetResponse>(e.response!);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
