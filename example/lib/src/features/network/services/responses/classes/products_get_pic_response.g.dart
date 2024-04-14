// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_get_pic_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProductsGetPickResponse> _$productsGetPickResponseSerializer =
    new _$ProductsGetPickResponseSerializer();

class _$ProductsGetPickResponseSerializer
    implements StructuredSerializer<ProductsGetPickResponse> {
  @override
  final Iterable<Type> types = const [
    ProductsGetPickResponse,
    _$ProductsGetPickResponse
  ];
  @override
  final String wireName = 'ProductsGetPickResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ProductsGetPickResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.items;
    if (value != null) {
      result
        ..add('items')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(ProductDTO)])));
    }
    value = object.result;
    if (value != null) {
      result
        ..add('result')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.meta;
    if (value != null) {
      result
        ..add('meta')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(MetaData)));
    }
    value = object.error;
    if (value != null) {
      result
        ..add('error')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ErrorData)));
    }
    return result;
  }

  @override
  ProductsGetPickResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductsGetPickResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'items':
          result.items.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ProductDTO)]))!
              as BuiltList<Object?>);
          break;
        case 'result':
          result.result = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'meta':
          result.meta.replace(serializers.deserialize(value,
              specifiedType: const FullType(MetaData))! as MetaData);
          break;
        case 'error':
          result.error.replace(serializers.deserialize(value,
              specifiedType: const FullType(ErrorData))! as ErrorData);
          break;
      }
    }

    return result.build();
  }
}

class _$ProductsGetPickResponse extends ProductsGetPickResponse {
  @override
  final BuiltList<ProductDTO>? items;
  @override
  final bool? result;
  @override
  final MetaData? meta;
  @override
  final ErrorData? error;

  factory _$ProductsGetPickResponse(
          [void Function(ProductsGetPickResponseBuilder)? updates]) =>
      (new ProductsGetPickResponseBuilder()..update(updates))._build();

  _$ProductsGetPickResponse._({this.items, this.result, this.meta, this.error})
      : super._();

  @override
  ProductsGetPickResponse rebuild(
          void Function(ProductsGetPickResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductsGetPickResponseBuilder toBuilder() =>
      new ProductsGetPickResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductsGetPickResponse &&
        items == other.items &&
        result == other.result &&
        meta == other.meta &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, result.hashCode);
    _$hash = $jc(_$hash, meta.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductsGetPickResponse')
          ..add('items', items)
          ..add('result', result)
          ..add('meta', meta)
          ..add('error', error))
        .toString();
  }
}

class ProductsGetPickResponseBuilder
    implements
        Builder<ProductsGetPickResponse, ProductsGetPickResponseBuilder>,
        SuccessResponseBuilder,
        ErrorResponseBuilder {
  _$ProductsGetPickResponse? _$v;

  ListBuilder<ProductDTO>? _items;
  ListBuilder<ProductDTO> get items =>
      _$this._items ??= new ListBuilder<ProductDTO>();
  set items(covariant ListBuilder<ProductDTO>? items) => _$this._items = items;

  bool? _result;
  bool? get result => _$this._result;
  set result(covariant bool? result) => _$this._result = result;

  MetaDataBuilder? _meta;
  MetaDataBuilder get meta => _$this._meta ??= new MetaDataBuilder();
  set meta(covariant MetaDataBuilder? meta) => _$this._meta = meta;

  ErrorDataBuilder? _error;
  ErrorDataBuilder get error => _$this._error ??= new ErrorDataBuilder();
  set error(covariant ErrorDataBuilder? error) => _$this._error = error;

  ProductsGetPickResponseBuilder();

  ProductsGetPickResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items?.toBuilder();
      _result = $v.result;
      _meta = $v.meta?.toBuilder();
      _error = $v.error?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
// ignore: override_on_non_overriding_method
  void replace(covariant ProductsGetPickResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductsGetPickResponse;
  }

  @override
  void update(void Function(ProductsGetPickResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductsGetPickResponse build() => _build();

  _$ProductsGetPickResponse _build() {
    _$ProductsGetPickResponse _$result;
    try {
      _$result = _$v ??
          new _$ProductsGetPickResponse._(
              items: _items?.build(),
              result: result,
              meta: _meta?.build(),
              error: _error?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();

        _$failedField = 'meta';
        _meta?.build();
        _$failedField = 'error';
        _error?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProductsGetPickResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
