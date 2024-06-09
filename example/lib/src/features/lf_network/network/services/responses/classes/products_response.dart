import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../models/model.dart';
import '../base/error_response.dart';
import '../base/success_response.dart';

part 'products_response.g.dart';

abstract class ProductsGetAllResponse
    with SuccessResponseValues, ErrorResponseValues
    implements
        SuccessResponse,
        ErrorResponse,
        Built<ProductsGetAllResponse, ProductsGetAllResponseBuilder> {
  @BuiltValueField(wireName: 'products')
  BuiltList<ProductDTO>? get products;

  ProductsGetAllResponse._();
  factory ProductsGetAllResponse(
          [void Function(ProductsGetAllResponseBuilder) updates]) =
      _$ProductsGetAllResponse;

  static Serializer<ProductsGetAllResponse> get serializer =>
      _$productsGetAllResponseSerializer;
}
