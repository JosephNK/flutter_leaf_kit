import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../models/model.dart';
import '../base/error_response.dart';
import '../base/success_response.dart';

part 'products_get_pic_response.g.dart';

abstract class ProductsGetPickResponse
    with SuccessResponseValues, ErrorResponseValues
    implements
        SuccessResponse,
        ErrorResponse,
        Built<ProductsGetPickResponse, ProductsGetPickResponseBuilder> {
  @BuiltValueField(wireName: null)
  BuiltList<ProductDTO>? get items;

  ProductsGetPickResponse._();
  factory ProductsGetPickResponse(
          [void Function(ProductsGetPickResponseBuilder) updates]) =
      _$ProductsGetPickResponse;

  static Serializer<ProductsGetPickResponse> get serializer =>
      _$productsGetPickResponseSerializer;
}
