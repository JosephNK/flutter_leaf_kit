import 'package:chopper/chopper.dart';

import 'responses/classes/product_response.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class APIService extends ChopperService {
  static APIService create([ChopperClient? client]) => _$APIService(client);

  @Get(path: '/products')
  Future<Response<ProductResponse>> getProducts(
      @QueryMap() Map<String, dynamic> query);

  @Get(path: '/productss')
  Future<Response<ProductResponse>> getNotFound(
      @QueryMap() Map<String, dynamic> query);
}
