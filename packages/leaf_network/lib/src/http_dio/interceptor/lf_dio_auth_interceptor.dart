// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_leaf_common/leaf_common.dart';
//
// class LFDioAuthInterceptor extends QueuedInterceptorsWrapper {
//   final Dio dio;
//   final VoidCallback? onSuccess;
//   final VoidCallback? onFailed;
//   final VoidCallback? onFailedToSignIn;
//
//   LFDioAuthInterceptor(
//     this.dio, {
//     this.onSuccess,
//     this.onFailed,
//     this.onFailedToSignIn,
//   });
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     int statusCode = err.response?.statusCode ?? 0;
//     RequestOptions errorRequestOptions = err.requestOptions;
//     String errorUrl = errorRequestOptions.path;
//
//     await LFPreferences.shared.setHttpInitErrorCodeInfo(statusCode);
//     await LFPreferences.shared.setHttpInitErrorMessageInfo(errorUrl);
//
//     debugPrint('LFDioAuthInterceptor - onError : $statusCode');
//
//     if (statusCode == 401) {
//       Logging.e(
//         'LFDioAuthInterceptor Regenerate Token API Before Request ErrorUrl(401): $errorUrl',
//       );
//
//       // RefreshToken 이 만료 되었을 경우, 처리
//       if (errorUrl == TokenDioService.regenerateUrl) {
//         Logging.e('LFDioAuthInterceptor RefreshToken Expired');
//         onFailedToSignIn?.call();
//         return handler.reject(err);
//       }
//
//       final accessToken = await LFPreferences.shared.getAccessToken();
//       final refreshToken = await LFPreferences.shared.getRefreshToken();
//
//       if (isEmpty(accessToken.trim())) {
//         Logging.e(
//           'LFDioAuthInterceptor Regenerate Token API Before Request accessToken empty',
//         );
//         await LFPreferences.shared
//             .setHttpInitErrorMessageInfo('accessToken empty');
//         onFailed?.call();
//         return handler.reject(err);
//       }
//
//       bool resultSuccess = false;
//
//       try {
//         const r = RetryOptions(maxAttempts: 5);
//         final response = await r.retry(
//           () => requestRefreshToken(
//             accessToken: accessToken,
//             refreshToken: refreshToken,
//           ),
//           retryIf: (e) {
//             if (e is UnauthorisedException) return false;
//             return true;
//           },
//         );
//
//         if (response != null) {
//           Logging.e(
//               'LFDioAuthInterceptor Regenerate Token API Retry Successful');
//           await updateTokenData(response);
//           resultSuccess = true;
//         } else {
//           Logging.e('LFDioAuthInterceptor Regenerate Token API Retry Failed');
//           resultSuccess = false;
//         }
//       } catch (e) {
//         resultSuccess = false;
//       }
//
//       if (!resultSuccess) {
//         onFailed?.call();
//         return handler.reject(err);
//       }
//
//       onSuccess?.call();
//
//       String newToken = await LFPreferences.shared.getAccessToken();
//
//       try {
//         // 요청 재전송
//         final Map<String, dynamic> updatedHeaders =
//             Map<String, dynamic>.of(errorRequestOptions.headers);
//         if (isNotEmpty(newToken)) {
//           newToken = 'Bearer $newToken';
//           updatedHeaders.update(
//             'Authorization',
//             (dynamic _) => newToken,
//             ifAbsent: () => newToken,
//           );
//         }
//         errorRequestOptions.headers = updatedHeaders;
//
//         RequestOptions errorNewOptions =
//             LFRequestOptions(errorRequestOptions).generator();
//
//         final response = await dio.fetch(errorNewOptions);
//         return handler.resolve(response);
//       } on DioException catch (e) {
//         return handler.reject(e);
//       }
//     } else if (statusCode == 400) {
//       // 400으로 잘못되어 발생되는 경우도 있어 추가
//       if (errorUrl == TokenDioService.regenerateUrl) {
//         Logging.e(
//           'LFDioAuthInterceptor Regenerate Token API Before Request ErrorUrl(400 ??): $errorUrl',
//         );
//         onFailedToSignIn?.call();
//         return handler.reject(err);
//       }
//     }
//
//     return handler.reject(err);
//   }
//
//   // Request RefreshToken
//   Future<TokenResponse?> requestRefreshToken({
//     required String accessToken,
//     required String refreshToken,
//   }) async {
//     try {
//       final apiService = LFHttpDio.shared.getService<TokenDioService>();
//       final response = await apiService.refreshToken(
//           expiredAccessToken: accessToken, refreshToken: refreshToken);
//       final statusCode = response.statusCode ?? 200;
//       if (response.isSuccessful) {
//         final body = response.data;
//         return body;
//       } else {
//         if (statusCode == 401) {
//           throw UnauthorisedException(statusCode, '', null);
//         } else {
//           throw Exception('Another HTTP Exception Error');
//         }
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   // Update TokenData Method
//   Future<void> updateTokenData(TokenResponse? data) async {
//     final accessToken = data?.accessToken ?? 'Unknown-AccessToken';
//     final refreshToken = data?.refreshToken ?? 'Unknown-RefreshToken';
//     final sessionToken = data?.sessionToken ?? 'Unknown-SessionToken';
//     await LFPreferences.shared.setAccessToken(accessToken);
//     await LFPreferences.shared.setRefreshToken(refreshToken);
//     await LFPreferences.shared.setSendbirdSessionToken(sessionToken);
//   }
// }
//
// class LFRequestOptions {
//   final RequestOptions options;
//
//   LFRequestOptions(this.options);
//
//   // TODO: https://github.com/cfug/dio/issues/482
//   RequestOptions generator() {
//     bool isExistMultipartFile = false;
//     Map<String, dynamic> map = {};
//     final extra = options.extra..removeEmptyValue();
//     if (extra.isNotEmpty) {
//       for (var key in extra.keys) {
//         final value = extra[key];
//         if (value is MultipartFileExtended) {
//           final byteValue = value.byteValue;
//           final filename = value.filename;
//           if (byteValue != null) {
//             isExistMultipartFile = true;
//             map[key] = MultipartFileExtended.fromBytes(
//               byteValue,
//               filename: filename,
//             );
//           }
//         }
//       }
//     }
//     final data = options.data;
//     if (data != null) {
//       if (data is FormData) {
//         FormData data = options.data;
//         Map<String, dynamic> map = {};
//         for (MapEntry mapFile in data.files) {
//           final key = mapFile.key;
//           final value = mapFile.value;
//           map[key] = value;
//         }
//         for (MapEntry mapFile in data.fields) {
//           final key = mapFile.key;
//           final value = mapFile.value;
//           if (value is String) {
//             if (isNotEmpty(value)) map[key] = value;
//           } else {
//             map[key] = value;
//           }
//         }
//       } else if (data is Map<dynamic, dynamic>) {
//         if (data.isNotEmpty) {
//           for (var key in data.keys) {
//             final value = data[key];
//             map[key] = value;
//           }
//         }
//       }
//     }
//     if (map.isNotEmpty) {
//       if (isExistMultipartFile) {
//         options.data = FormData.fromMap(map);
//       } else {
//         options.data = map;
//       }
//     }
//     return options;
//   }
// }
//
// // class LFDioAuthRetryToken {
// //   static final LFDioAuthRetryToken _instance = LFDioAuthRetryToken._internal();
// //
// //   static LFDioAuthRetryToken get shared => _instance;
// //
// //   LFDioAuthRetryToken._internal();
// //
// //   final Map<String, int> _pathMap = {};
// //
// //   Future<bool> checkingMaxCount(String path, int maxCount) async {
// //     final value = _pathMap[path] ?? 0;
// //     if (maxCount == value) {
// //       clear(path);
// //       return false;
// //     }
// //     _pathMap[path] = value + 1;
// //     await Future.delayed(Duration(milliseconds: 120 * value));
// //     return true;
// //   }
// //
// //   void clear(String path) {
// //     _pathMap[path] = 0;
// //   }
// // }
