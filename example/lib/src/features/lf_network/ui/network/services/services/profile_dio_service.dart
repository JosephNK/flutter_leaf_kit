import 'package:flutter_leaf_kit/flutter_leaf_kit_network.dart';

import '../responses/responses.dart';

class ProfileDioService extends LFDioService {
  Future<LFDioResponse<ProfileMeGetResponse>> getProfileMe() async {
    try {
      const url = '/profile/me';
      return await get<ProfileMeGetResponse>(
        url,
        options: Options(
          headers: {
            "authorization": "Bearer aaa",
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
