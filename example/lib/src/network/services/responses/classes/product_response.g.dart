// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProductResponse> _$productResponseSerializer =
    new _$ProductResponseSerializer();

class _$ProductResponseSerializer
    implements StructuredSerializer<ProductResponse> {
  @override
  final Iterable<Type> types = const [ProductResponse, _$ProductResponse];
  @override
  final String wireName = 'ProductResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, ProductResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.products;
    if (value != null) {
      result
        ..add('products')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Product)])));
    }
    value = object.total;
    if (value != null) {
      result
        ..add('total')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.next;
    if (value != null) {
      result
        ..add('next')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.skip;
    if (value != null) {
      result
        ..add('skip')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.errorMessage;
    if (value != null) {
      result
        ..add('error_message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ProductResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'products':
          result.products.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Product)]))!
              as BuiltList<Object?>);
          break;
        case 'total':
          result.total = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'next':
          result.next = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'skip':
          result.skip = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'error_message':
          result.errorMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProductResponse extends ProductResponse {
  @override
  final BuiltList<Product>? products;
  @override
  final int? total;
  @override
  final int? next;
  @override
  final int? skip;
  @override
  final String? errorMessage;

  factory _$ProductResponse([void Function(ProductResponseBuilder)? updates]) =>
      (new ProductResponseBuilder()..update(updates))._build();

  _$ProductResponse._(
      {this.products, this.total, this.next, this.skip, this.errorMessage})
      : super._();

  @override
  ProductResponse rebuild(void Function(ProductResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductResponseBuilder toBuilder() =>
      new ProductResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductResponse &&
        products == other.products &&
        total == other.total &&
        next == other.next &&
        skip == other.skip &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, products.hashCode), total.hashCode), next.hashCode),
            skip.hashCode),
        errorMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductResponse')
          ..add('products', products)
          ..add('total', total)
          ..add('next', next)
          ..add('skip', skip)
          ..add('errorMessage', errorMessage))
        .toString();
  }
}

class ProductResponseBuilder
    implements
        Builder<ProductResponse, ProductResponseBuilder>,
        APISuccessResponseBuilder,
        APIErrorResponseBuilder {
  _$ProductResponse? _$v;

  ListBuilder<Product>? _products;
  ListBuilder<Product> get products =>
      _$this._products ??= new ListBuilder<Product>();
  set products(covariant ListBuilder<Product>? products) =>
      _$this._products = products;

  int? _total;
  int? get total => _$this._total;
  set total(covariant int? total) => _$this._total = total;

  int? _next;
  int? get next => _$this._next;
  set next(covariant int? next) => _$this._next = next;

  int? _skip;
  int? get skip => _$this._skip;
  set skip(covariant int? skip) => _$this._skip = skip;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(covariant String? errorMessage) =>
      _$this._errorMessage = errorMessage;

  ProductResponseBuilder();

  ProductResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _products = $v.products?.toBuilder();
      _total = $v.total;
      _next = $v.next;
      _skip = $v.skip;
      _errorMessage = $v.errorMessage;
      _$v = null;
    }
    return this;
  }

  @override
// ignore: override_on_non_overriding_method
  void replace(covariant ProductResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductResponse;
  }

  @override
  void update(void Function(ProductResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductResponse build() => _build();

  _$ProductResponse _build() {
    _$ProductResponse _$result;
    try {
      _$result = _$v ??
          new _$ProductResponse._(
              products: _products?.build(),
              total: total,
              next: next,
              skip: skip,
              errorMessage: errorMessage);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'products';
        _products?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProductResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
