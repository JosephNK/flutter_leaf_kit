// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$APIService extends APIService {
  _$APIService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = APIService;

  @override
  Future<Response<ProductResponse>> getProducts(Map<String, dynamic> query) {
    final String $url = '/products';
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ProductResponse, ProductResponse>($request);
  }

  @override
  Future<Response<ProductResponse>> getNotFound(Map<String, dynamic> query) {
    final String $url = '/productss';
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ProductResponse, ProductResponse>($request);
  }
}
