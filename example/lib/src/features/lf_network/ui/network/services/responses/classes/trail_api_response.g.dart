// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trail_api_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TrailApiResponse> _$trailApiResponseSerializer =
    new _$TrailApiResponseSerializer();

class _$TrailApiResponseSerializer
    implements StructuredSerializer<TrailApiResponse> {
  @override
  final Iterable<Type> types = const [TrailApiResponse, _$TrailApiResponse];
  @override
  final String wireName = 'TrailApiResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, TrailApiResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
  TrailApiResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TrailApiResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$TrailApiResponse extends TrailApiResponse {
  @override
  final String? message;
  @override
  final MetaData? meta;
  @override
  final ErrorData? error;

  factory _$TrailApiResponse(
          [void Function(TrailApiResponseBuilder)? updates]) =>
      (new TrailApiResponseBuilder()..update(updates))._build();

  _$TrailApiResponse._({this.message, this.meta, this.error}) : super._();

  @override
  TrailApiResponse rebuild(void Function(TrailApiResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TrailApiResponseBuilder toBuilder() =>
      new TrailApiResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TrailApiResponse &&
        message == other.message &&
        meta == other.meta &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, meta.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TrailApiResponse')
          ..add('message', message)
          ..add('meta', meta)
          ..add('error', error))
        .toString();
  }
}

class TrailApiResponseBuilder
    implements
        Builder<TrailApiResponse, TrailApiResponseBuilder>,
        ErrorResponseBuilder {
  _$TrailApiResponse? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(covariant String? message) => _$this._message = message;

  MetaDataBuilder? _meta;
  MetaDataBuilder get meta => _$this._meta ??= new MetaDataBuilder();
  set meta(covariant MetaDataBuilder? meta) => _$this._meta = meta;

  ErrorDataBuilder? _error;
  ErrorDataBuilder get error => _$this._error ??= new ErrorDataBuilder();
  set error(covariant ErrorDataBuilder? error) => _$this._error = error;

  TrailApiResponseBuilder();

  TrailApiResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _meta = $v.meta?.toBuilder();
      _error = $v.error?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant TrailApiResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TrailApiResponse;
  }

  @override
  void update(void Function(TrailApiResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TrailApiResponse build() => _build();

  _$TrailApiResponse _build() {
    _$TrailApiResponse _$result;
    try {
      _$result = _$v ??
          new _$TrailApiResponse._(
            message: message,
            meta: _meta?.build(),
            error: _error?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'meta';
        _meta?.build();
        _$failedField = 'error';
        _error?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TrailApiResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
