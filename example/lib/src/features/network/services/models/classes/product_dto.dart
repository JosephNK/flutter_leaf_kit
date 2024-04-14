import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_dto.g.dart';

abstract class ProductDTO implements Built<ProductDTO, ProductDTOBuilder> {
  @BuiltValueField(wireName: 'id')
  String? get id;

  @BuiltValueField(wireName: 'productName')
  String? get productName;

  @BuiltValueField(wireName: 'translatedProductName')
  String? get translatedProductName;

  @BuiltValueField(wireName: 'price')
  int? get price;

  @BuiltValueField(wireName: 'exchangedPrice')
  int? get exchangedPrice;

  @BuiltValueField(wireName: 'mallUrl')
  String? get mallUrl;

  @BuiltValueField(wireName: 'imageUrl')
  String? get imageUrl;

  @BuiltValueField(wireName: 'expectedShippingFee')
  int? get expectedShippingFee;

  @BuiltValueField(wireName: 'starRating')
  int? get starRating;

  @BuiltValueField(wireName: 'reviewCount')
  int? get reviewCount;

  @BuiltValueField(wireName: 'priority')
  int? get priority;

  ProductDTO._();
  factory ProductDTO([void Function(ProductDTOBuilder) updates]) = _$ProductDTO;

  static Serializer<ProductDTO> get serializer => _$productDTOSerializer;
}
