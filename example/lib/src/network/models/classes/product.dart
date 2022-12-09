import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product.g.dart';

abstract class Product implements Built<Product, ProductBuilder> {
  @BuiltValueField(wireName: 'id')
  int? get id;

  @BuiltValueField(wireName: 'title')
  String? get title;

  @BuiltValueField(wireName: 'price')
  int? get price;

  Product._();
  factory Product([void Function(ProductBuilder) updates]) = _$Product;

  static Serializer<Product> get serializer => _$productSerializer;
}
