// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProductDTO> _$productDTOSerializer = new _$ProductDTOSerializer();

class _$ProductDTOSerializer implements StructuredSerializer<ProductDTO> {
  @override
  final Iterable<Type> types = const [ProductDTO, _$ProductDTO];
  @override
  final String wireName = 'ProductDTO';

  @override
  Iterable<Object?> serialize(Serializers serializers, ProductDTO object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.productName;
    if (value != null) {
      result
        ..add('productName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.translatedProductName;
    if (value != null) {
      result
        ..add('translatedProductName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.exchangedPrice;
    if (value != null) {
      result
        ..add('exchangedPrice')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.mallUrl;
    if (value != null) {
      result
        ..add('mallUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.expectedShippingFee;
    if (value != null) {
      result
        ..add('expectedShippingFee')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.starRating;
    if (value != null) {
      result
        ..add('starRating')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.reviewCount;
    if (value != null) {
      result
        ..add('reviewCount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.priority;
    if (value != null) {
      result
        ..add('priority')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ProductDTO deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductDTOBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'productName':
          result.productName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'translatedProductName':
          result.translatedProductName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'exchangedPrice':
          result.exchangedPrice = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'mallUrl':
          result.mallUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'expectedShippingFee':
          result.expectedShippingFee = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'starRating':
          result.starRating = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'reviewCount':
          result.reviewCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'priority':
          result.priority = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProductDTO extends ProductDTO {
  @override
  final String? id;
  @override
  final String? productName;
  @override
  final String? translatedProductName;
  @override
  final int? price;
  @override
  final int? exchangedPrice;
  @override
  final String? mallUrl;
  @override
  final String? imageUrl;
  @override
  final int? expectedShippingFee;
  @override
  final int? starRating;
  @override
  final int? reviewCount;
  @override
  final int? priority;

  factory _$ProductDTO([void Function(ProductDTOBuilder)? updates]) =>
      (new ProductDTOBuilder()..update(updates))._build();

  _$ProductDTO._(
      {this.id,
      this.productName,
      this.translatedProductName,
      this.price,
      this.exchangedPrice,
      this.mallUrl,
      this.imageUrl,
      this.expectedShippingFee,
      this.starRating,
      this.reviewCount,
      this.priority})
      : super._();

  @override
  ProductDTO rebuild(void Function(ProductDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductDTOBuilder toBuilder() => new ProductDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductDTO &&
        id == other.id &&
        productName == other.productName &&
        translatedProductName == other.translatedProductName &&
        price == other.price &&
        exchangedPrice == other.exchangedPrice &&
        mallUrl == other.mallUrl &&
        imageUrl == other.imageUrl &&
        expectedShippingFee == other.expectedShippingFee &&
        starRating == other.starRating &&
        reviewCount == other.reviewCount &&
        priority == other.priority;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, translatedProductName.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, exchangedPrice.hashCode);
    _$hash = $jc(_$hash, mallUrl.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, expectedShippingFee.hashCode);
    _$hash = $jc(_$hash, starRating.hashCode);
    _$hash = $jc(_$hash, reviewCount.hashCode);
    _$hash = $jc(_$hash, priority.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductDTO')
          ..add('id', id)
          ..add('productName', productName)
          ..add('translatedProductName', translatedProductName)
          ..add('price', price)
          ..add('exchangedPrice', exchangedPrice)
          ..add('mallUrl', mallUrl)
          ..add('imageUrl', imageUrl)
          ..add('expectedShippingFee', expectedShippingFee)
          ..add('starRating', starRating)
          ..add('reviewCount', reviewCount)
          ..add('priority', priority))
        .toString();
  }
}

class ProductDTOBuilder implements Builder<ProductDTO, ProductDTOBuilder> {
  _$ProductDTO? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  String? _translatedProductName;
  String? get translatedProductName => _$this._translatedProductName;
  set translatedProductName(String? translatedProductName) =>
      _$this._translatedProductName = translatedProductName;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  int? _exchangedPrice;
  int? get exchangedPrice => _$this._exchangedPrice;
  set exchangedPrice(int? exchangedPrice) =>
      _$this._exchangedPrice = exchangedPrice;

  String? _mallUrl;
  String? get mallUrl => _$this._mallUrl;
  set mallUrl(String? mallUrl) => _$this._mallUrl = mallUrl;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  int? _expectedShippingFee;
  int? get expectedShippingFee => _$this._expectedShippingFee;
  set expectedShippingFee(int? expectedShippingFee) =>
      _$this._expectedShippingFee = expectedShippingFee;

  int? _starRating;
  int? get starRating => _$this._starRating;
  set starRating(int? starRating) => _$this._starRating = starRating;

  int? _reviewCount;
  int? get reviewCount => _$this._reviewCount;
  set reviewCount(int? reviewCount) => _$this._reviewCount = reviewCount;

  int? _priority;
  int? get priority => _$this._priority;
  set priority(int? priority) => _$this._priority = priority;

  ProductDTOBuilder();

  ProductDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productName = $v.productName;
      _translatedProductName = $v.translatedProductName;
      _price = $v.price;
      _exchangedPrice = $v.exchangedPrice;
      _mallUrl = $v.mallUrl;
      _imageUrl = $v.imageUrl;
      _expectedShippingFee = $v.expectedShippingFee;
      _starRating = $v.starRating;
      _reviewCount = $v.reviewCount;
      _priority = $v.priority;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductDTO;
  }

  @override
  void update(void Function(ProductDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductDTO build() => _build();

  _$ProductDTO _build() {
    final _$result = _$v ??
        new _$ProductDTO._(
            id: id,
            productName: productName,
            translatedProductName: translatedProductName,
            price: price,
            exchangedPrice: exchangedPrice,
            mallUrl: mallUrl,
            imageUrl: imageUrl,
            expectedShippingFee: expectedShippingFee,
            starRating: starRating,
            reviewCount: reviewCount,
            priority: priority);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
