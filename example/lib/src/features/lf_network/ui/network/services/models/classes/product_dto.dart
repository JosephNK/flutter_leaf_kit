import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_dto.g.dart';

abstract class ProductDTO implements Built<ProductDTO, ProductDTOBuilder> {
  @BuiltValueField(wireName: 'id')
  num? get id;

  @BuiltValueField(wireName: 'title')
  String? get title;

  @BuiltValueField(wireName: 'description')
  String? get description;

  ProductDTO._();
  factory ProductDTO([void Function(ProductDTOBuilder) updates]) = _$ProductDTO;

  static Serializer<ProductDTO> get serializer => _$productDTOSerializer;
}
