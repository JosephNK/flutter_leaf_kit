import 'package:dio/dio.dart';
import 'package:flutter_leaf_core/leaf_core.dart';

typedef LeafDioOnHeader = Future<Map<String, dynamic>> Function();

class LeafDioRequestInterceptor extends InterceptorsWrapper {
  final LeafDioOnHeader? onHeader;

  LeafDioRequestInterceptor({this.onHeader});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Map<String, dynamic> headers = await onHeader?.call() ?? {};
    options.headers = {...options.headers, ...headers};
    options.queryParameters = options.queryParameters..removeNullEmptyValue();
    if (options.data != null) {
      if (options.data is FormData) {
        FormData data = options.data;
        Map<String, dynamic> map = {};
        _transformFiles(data.files).forEach((key, value) {
          map[key] = value;
        });
        _transformFields(data.fields).forEach((key, value) {
          map[key] = value;
        });
        options.data = FormData.fromMap(map);
      } else if (options.data is Map<String, dynamic>) {
        Map<String, dynamic> data = options.data;
        options.data = data..removeNullEmptyValue();
      }
    }
    return handler.next(options); //continue
  }
}

extension LeafDioRequestInterceptorHelper on LeafDioRequestInterceptor {
  Map<String, dynamic> _transformFiles(List<MapEntry> items) {
    Map<String, dynamic> result = {};
    for (var item in items) {
      final key = item.key;
      final value = item.value;
      result.putIfAbsent(key, () => []);
      result[key]!.add(value);
    }
    return result;
  }

  Map<String, dynamic> _transformFields(List<MapEntry> items) {
    Map<String, dynamic> result = {};
    for (var item in items) {
      final key = item.key;
      final value = item.value;
      if (value is String) {
        if (isNotEmpty(value)) result[key] = value;
      } else {
        result[key] = value;
      }
    }
    return result;
  }
}
