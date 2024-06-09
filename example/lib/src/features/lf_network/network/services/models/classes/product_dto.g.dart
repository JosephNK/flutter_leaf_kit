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
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
              specifiedType: const FullType(num)) as num?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProductDTO extends ProductDTO {
  @override
  final num? id;
  @override
  final String? title;
  @override
  final String? description;

  factory _$ProductDTO([void Function(ProductDTOBuilder)? updates]) =>
      (new ProductDTOBuilder()..update(updates))._build();

  _$ProductDTO._({this.id, this.title, this.description}) : super._();

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
        title == other.title &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductDTO')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description))
        .toString();
  }
}

class ProductDTOBuilder implements Builder<ProductDTO, ProductDTOBuilder> {
  _$ProductDTO? _$v;

  num? _id;
  num? get id => _$this._id;
  set id(num? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ProductDTOBuilder();

  ProductDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
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
        new _$ProductDTO._(id: id, title: title, description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
