// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_gets_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ReviewsGetsResponse> _$reviewsGetsResponseSerializer =
    new _$ReviewsGetsResponseSerializer();

class _$ReviewsGetsResponseSerializer
    implements StructuredSerializer<ReviewsGetsResponse> {
  @override
  final Iterable<Type> types = const [
    ReviewsGetsResponse,
    _$ReviewsGetsResponse
  ];
  @override
  final String wireName = 'ReviewsGetsResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ReviewsGetsResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.total;
    if (value != null) {
      result
        ..add('total')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.data;
    if (value != null) {
      result
        ..add('data')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(ReviewsDTO)])));
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
  ReviewsGetsResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewsGetsResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'total':
          result.total = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ReviewsDTO)]))!
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

class _$ReviewsGetsResponse extends ReviewsGetsResponse {
  @override
  final int? total;
  @override
  final BuiltList<ReviewsDTO>? data;
  @override
  final bool? result;
  @override
  final MetaData? meta;
  @override
  final ErrorData? error;

  factory _$ReviewsGetsResponse(
          [void Function(ReviewsGetsResponseBuilder)? updates]) =>
      (new ReviewsGetsResponseBuilder()..update(updates))._build();

  _$ReviewsGetsResponse._(
      {this.total, this.data, this.result, this.meta, this.error})
      : super._();

  @override
  ReviewsGetsResponse rebuild(
          void Function(ReviewsGetsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewsGetsResponseBuilder toBuilder() =>
      new ReviewsGetsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewsGetsResponse &&
        total == other.total &&
        data == other.data &&
        result == other.result &&
        meta == other.meta &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, result.hashCode);
    _$hash = $jc(_$hash, meta.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewsGetsResponse')
          ..add('total', total)
          ..add('data', data)
          ..add('result', result)
          ..add('meta', meta)
          ..add('error', error))
        .toString();
  }
}

class ReviewsGetsResponseBuilder
    implements
        Builder<ReviewsGetsResponse, ReviewsGetsResponseBuilder>,
        SuccessResponseBuilder,
        ErrorResponseBuilder {
  _$ReviewsGetsResponse? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(covariant int? total) => _$this._total = total;

  ListBuilder<ReviewsDTO>? _data;
  ListBuilder<ReviewsDTO> get data =>
      _$this._data ??= new ListBuilder<ReviewsDTO>();
  set data(covariant ListBuilder<ReviewsDTO>? data) => _$this._data = data;

  bool? _result;
  bool? get result => _$this._result;
  set result(covariant bool? result) => _$this._result = result;

  MetaDataBuilder? _meta;
  MetaDataBuilder get meta => _$this._meta ??= new MetaDataBuilder();
  set meta(covariant MetaDataBuilder? meta) => _$this._meta = meta;

  ErrorDataBuilder? _error;
  ErrorDataBuilder get error => _$this._error ??= new ErrorDataBuilder();
  set error(covariant ErrorDataBuilder? error) => _$this._error = error;

  ReviewsGetsResponseBuilder();

  ReviewsGetsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _data = $v.data?.toBuilder();
      _result = $v.result;
      _meta = $v.meta?.toBuilder();
      _error = $v.error?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
// ignore: override_on_non_overriding_method
  void replace(covariant ReviewsGetsResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewsGetsResponse;
  }

  @override
  void update(void Function(ReviewsGetsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewsGetsResponse build() => _build();

  _$ReviewsGetsResponse _build() {
    _$ReviewsGetsResponse _$result;
    try {
      _$result = _$v ??
          new _$ReviewsGetsResponse._(
              total: total,
              data: _data?.build(),
              result: result,
              meta: _meta?.build(),
              error: _error?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();

        _$failedField = 'meta';
        _meta?.build();
        _$failedField = 'error';
        _error?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReviewsGetsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
