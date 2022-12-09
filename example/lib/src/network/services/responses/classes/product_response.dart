import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../../models/classes/product.dart';
import '../api_error_response.dart';
import '../api_success_response.dart';

export '../../../models/classes/product.dart';

part 'product_response.g.dart';

abstract class ProductResponse
    with APISuccessResponseValues, APIErrorResponseValues
    implements
        APISuccessResponse,
        APIErrorResponse,
        Built<ProductResponse, ProductResponseBuilder> {
  @BuiltValueField(wireName: 'products')
  BuiltList<Product>? get products;

  ProductResponse._();
  factory ProductResponse([void Function(ProductResponseBuilder) updates]) =
      _$ProductResponse;

  static Serializer<ProductResponse> get serializer =>
      _$productResponseSerializer;
}
