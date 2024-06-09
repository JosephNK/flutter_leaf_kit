// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProductsGetAllResponse> _$productsGetAllResponseSerializer =
    new _$ProductsGetAllResponseSerializer();

class _$ProductsGetAllResponseSerializer
    implements StructuredSerializer<ProductsGetAllResponse> {
  @override
  final Iterable<Type> types = const [
    ProductsGetAllResponse,
    _$ProductsGetAllResponse
  ];
  @override
  final String wireName = 'ProductsGetAllResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ProductsGetAllResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.products;
    if (value != null) {
      result
        ..add('products')
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
  ProductsGetAllResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductsGetAllResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'products':
          result.products.replace(serializers.deserialize(value,
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

class _$ProductsGetAllResponse extends ProductsGetAllResponse {
  @override
  final BuiltList<ProductDTO>? products;
  @override
  final bool? result;
  @override
  final MetaData? meta;
  @override
  final ErrorData? error;

  factory _$ProductsGetAllResponse(
          [void Function(ProductsGetAllResponseBuilder)? updates]) =>
      (new ProductsGetAllResponseBuilder()..update(updates))._build();

  _$ProductsGetAllResponse._(
      {this.products, this.result, this.meta, this.error})
      : super._();

  @override
  ProductsGetAllResponse rebuild(
          void Function(ProductsGetAllResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductsGetAllResponseBuilder toBuilder() =>
      new ProductsGetAllResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductsGetAllResponse &&
        products == other.products &&
        result == other.result &&
        meta == other.meta &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jc(_$hash, result.hashCode);
    _$hash = $jc(_$hash, meta.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductsGetAllResponse')
          ..add('products', products)
          ..add('result', result)
          ..add('meta', meta)
          ..add('error', error))
        .toString();
  }
}

class ProductsGetAllResponseBuilder
    implements
        Builder<ProductsGetAllResponse, ProductsGetAllResponseBuilder>,
        SuccessResponseBuilder,
        ErrorResponseBuilder {
  _$ProductsGetAllResponse? _$v;

  ListBuilder<ProductDTO>? _products;
  ListBuilder<ProductDTO> get products =>
      _$this._products ??= new ListBuilder<ProductDTO>();
  set products(covariant ListBuilder<ProductDTO>? products) =>
      _$this._products = products;

  bool? _result;
  bool? get result => _$this._result;
  set result(covariant bool? result) => _$this._result = result;

  MetaDataBuilder? _meta;
  MetaDataBuilder get meta => _$this._meta ??= new MetaDataBuilder();
  set meta(covariant MetaDataBuilder? meta) => _$this._meta = meta;

  ErrorDataBuilder? _error;
  ErrorDataBuilder get error => _$this._error ??= new ErrorDataBuilder();
  set error(covariant ErrorDataBuilder? error) => _$this._error = error;

  ProductsGetAllResponseBuilder();

  ProductsGetAllResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _products = $v.products?.toBuilder();
      _result = $v.result;
      _meta = $v.meta?.toBuilder();
      _error = $v.error?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
// ignore: override_on_non_overriding_method
  void replace(covariant ProductsGetAllResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductsGetAllResponse;
  }

  @override
  void update(void Function(ProductsGetAllResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductsGetAllResponse build() => _build();

  _$ProductsGetAllResponse _build() {
    _$ProductsGetAllResponse _$result;
    try {
      _$result = _$v ??
          new _$ProductsGetAllResponse._(
              products: _products?.build(),
              result: result,
              meta: _meta?.build(),
              error: _error?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'products';
        _products?.build();

        _$failedField = 'meta';
        _meta?.build();
        _$failedField = 'error';
        _error?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProductsGetAllResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
