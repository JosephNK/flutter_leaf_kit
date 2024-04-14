// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CurrencyResponse> _$currencyResponseSerializer =
    new _$CurrencyResponseSerializer();

class _$CurrencyResponseSerializer
    implements StructuredSerializer<CurrencyResponse> {
  @override
  final Iterable<Type> types = const [CurrencyResponse, _$CurrencyResponse];
  @override
  final String wireName = 'CurrencyResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, CurrencyResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.item;
    if (value != null) {
      result
        ..add('item')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
  CurrencyResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CurrencyResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'item':
          result.item = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$CurrencyResponse extends CurrencyResponse {
  @override
  final String? item;
  @override
  final bool? result;
  @override
  final MetaData? meta;
  @override
  final ErrorData? error;

  factory _$CurrencyResponse(
          [void Function(CurrencyResponseBuilder)? updates]) =>
      (new CurrencyResponseBuilder()..update(updates))._build();

  _$CurrencyResponse._({this.item, this.result, this.meta, this.error})
      : super._();

  @override
  CurrencyResponse rebuild(void Function(CurrencyResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyResponseBuilder toBuilder() =>
      new CurrencyResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrencyResponse &&
        item == other.item &&
        result == other.result &&
        meta == other.meta &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, item.hashCode);
    _$hash = $jc(_$hash, result.hashCode);
    _$hash = $jc(_$hash, meta.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CurrencyResponse')
          ..add('item', item)
          ..add('result', result)
          ..add('meta', meta)
          ..add('error', error))
        .toString();
  }
}

class CurrencyResponseBuilder
    implements
        Builder<CurrencyResponse, CurrencyResponseBuilder>,
        SuccessResponseBuilder,
        ErrorResponseBuilder {
  _$CurrencyResponse? _$v;

  String? _item;
  String? get item => _$this._item;
  set item(covariant String? item) => _$this._item = item;

  bool? _result;
  bool? get result => _$this._result;
  set result(covariant bool? result) => _$this._result = result;

  MetaDataBuilder? _meta;
  MetaDataBuilder get meta => _$this._meta ??= new MetaDataBuilder();
  set meta(covariant MetaDataBuilder? meta) => _$this._meta = meta;

  ErrorDataBuilder? _error;
  ErrorDataBuilder get error => _$this._error ??= new ErrorDataBuilder();
  set error(covariant ErrorDataBuilder? error) => _$this._error = error;

  CurrencyResponseBuilder();

  CurrencyResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _item = $v.item;
      _result = $v.result;
      _meta = $v.meta?.toBuilder();
      _error = $v.error?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
// ignore: override_on_non_overriding_method
  void replace(covariant CurrencyResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CurrencyResponse;
  }

  @override
  void update(void Function(CurrencyResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CurrencyResponse build() => _build();

  _$CurrencyResponse _build() {
    _$CurrencyResponse _$result;
    try {
      _$result = _$v ??
          new _$CurrencyResponse._(
              item: item,
              result: result,
              meta: _meta?.build(),
              error: _error?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'meta';
        _meta?.build();
        _$failedField = 'error';
        _error?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CurrencyResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
