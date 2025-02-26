// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trail_error_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TrailErrorResponse> _$trailErrorResponseSerializer =
    new _$TrailErrorResponseSerializer();
Serializer<TrailErrorNoSerializerResponse>
    _$trailErrorNoSerializerResponseSerializer =
    new _$TrailErrorNoSerializerResponseSerializer();

class _$TrailErrorResponseSerializer
    implements StructuredSerializer<TrailErrorResponse> {
  @override
  final Iterable<Type> types = const [TrailErrorResponse, _$TrailErrorResponse];
  @override
  final String wireName = 'TrailErrorResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TrailErrorResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.statusCode;
    if (value != null) {
      result
        ..add('statusCode')
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
    }
    value = object.timestamp;
    if (value != null) {
      result
        ..add('timestamp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.path;
    if (value != null) {
      result
        ..add('path')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
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
  TrailErrorResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TrailErrorResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'statusCode':
          result.statusCode = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num?;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'path':
          result.path = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
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

class _$TrailErrorNoSerializerResponseSerializer
    implements StructuredSerializer<TrailErrorNoSerializerResponse> {
  @override
  final Iterable<Type> types = const [
    TrailErrorNoSerializerResponse,
    _$TrailErrorNoSerializerResponse
  ];
  @override
  final String wireName = 'TrailErrorNoSerializerResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TrailErrorNoSerializerResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.statusCode;
    if (value != null) {
      result
        ..add('statusCode')
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
    }
    value = object.timestamp;
    if (value != null) {
      result
        ..add('timestamp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.path;
    if (value != null) {
      result
        ..add('path')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
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
  TrailErrorNoSerializerResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TrailErrorNoSerializerResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'statusCode':
          result.statusCode = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num?;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'path':
          result.path = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
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

class _$TrailErrorResponse extends TrailErrorResponse {
  @override
  final num? statusCode;
  @override
  final String? timestamp;
  @override
  final String? path;
  @override
  final String? message;
  @override
  final MetaData? meta;
  @override
  final ErrorData? error;

  factory _$TrailErrorResponse(
          [void Function(TrailErrorResponseBuilder)? updates]) =>
      (new TrailErrorResponseBuilder()..update(updates))._build();

  _$TrailErrorResponse._(
      {this.statusCode,
      this.timestamp,
      this.path,
      this.message,
      this.meta,
      this.error})
      : super._();

  @override
  TrailErrorResponse rebuild(
          void Function(TrailErrorResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TrailErrorResponseBuilder toBuilder() =>
      new TrailErrorResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TrailErrorResponse &&
        statusCode == other.statusCode &&
        timestamp == other.timestamp &&
        path == other.path &&
        message == other.message &&
        meta == other.meta &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, statusCode.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, meta.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TrailErrorResponse')
          ..add('statusCode', statusCode)
          ..add('timestamp', timestamp)
          ..add('path', path)
          ..add('message', message)
          ..add('meta', meta)
          ..add('error', error))
        .toString();
  }
}

class TrailErrorResponseBuilder
    implements
        Builder<TrailErrorResponse, TrailErrorResponseBuilder>,
        ErrorResponseBuilder {
  _$TrailErrorResponse? _$v;

  num? _statusCode;
  num? get statusCode => _$this._statusCode;
  set statusCode(covariant num? statusCode) => _$this._statusCode = statusCode;

  String? _timestamp;
  String? get timestamp => _$this._timestamp;
  set timestamp(covariant String? timestamp) => _$this._timestamp = timestamp;

  String? _path;
  String? get path => _$this._path;
  set path(covariant String? path) => _$this._path = path;

  String? _message;
  String? get message => _$this._message;
  set message(covariant String? message) => _$this._message = message;

  MetaDataBuilder? _meta;
  MetaDataBuilder get meta => _$this._meta ??= new MetaDataBuilder();
  set meta(covariant MetaDataBuilder? meta) => _$this._meta = meta;

  ErrorDataBuilder? _error;
  ErrorDataBuilder get error => _$this._error ??= new ErrorDataBuilder();
  set error(covariant ErrorDataBuilder? error) => _$this._error = error;

  TrailErrorResponseBuilder();

  TrailErrorResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _statusCode = $v.statusCode;
      _timestamp = $v.timestamp;
      _path = $v.path;
      _message = $v.message;
      _meta = $v.meta?.toBuilder();
      _error = $v.error?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant TrailErrorResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TrailErrorResponse;
  }

  @override
  void update(void Function(TrailErrorResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TrailErrorResponse build() => _build();

  _$TrailErrorResponse _build() {
    _$TrailErrorResponse _$result;
    try {
      _$result = _$v ??
          new _$TrailErrorResponse._(
            statusCode: statusCode,
            timestamp: timestamp,
            path: path,
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
            r'TrailErrorResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TrailErrorNoSerializerResponse extends TrailErrorNoSerializerResponse {
  @override
  final num? statusCode;
  @override
  final String? timestamp;
  @override
  final String? path;
  @override
  final String? message;
  @override
  final MetaData? meta;
  @override
  final ErrorData? error;

  factory _$TrailErrorNoSerializerResponse(
          [void Function(TrailErrorNoSerializerResponseBuilder)? updates]) =>
      (new TrailErrorNoSerializerResponseBuilder()..update(updates))._build();

  _$TrailErrorNoSerializerResponse._(
      {this.statusCode,
      this.timestamp,
      this.path,
      this.message,
      this.meta,
      this.error})
      : super._();

  @override
  TrailErrorNoSerializerResponse rebuild(
          void Function(TrailErrorNoSerializerResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TrailErrorNoSerializerResponseBuilder toBuilder() =>
      new TrailErrorNoSerializerResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TrailErrorNoSerializerResponse &&
        statusCode == other.statusCode &&
        timestamp == other.timestamp &&
        path == other.path &&
        message == other.message &&
        meta == other.meta &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, statusCode.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, meta.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TrailErrorNoSerializerResponse')
          ..add('statusCode', statusCode)
          ..add('timestamp', timestamp)
          ..add('path', path)
          ..add('message', message)
          ..add('meta', meta)
          ..add('error', error))
        .toString();
  }
}

class TrailErrorNoSerializerResponseBuilder
    implements
        Builder<TrailErrorNoSerializerResponse,
            TrailErrorNoSerializerResponseBuilder>,
        ErrorResponseBuilder {
  _$TrailErrorNoSerializerResponse? _$v;

  num? _statusCode;
  num? get statusCode => _$this._statusCode;
  set statusCode(covariant num? statusCode) => _$this._statusCode = statusCode;

  String? _timestamp;
  String? get timestamp => _$this._timestamp;
  set timestamp(covariant String? timestamp) => _$this._timestamp = timestamp;

  String? _path;
  String? get path => _$this._path;
  set path(covariant String? path) => _$this._path = path;

  String? _message;
  String? get message => _$this._message;
  set message(covariant String? message) => _$this._message = message;

  MetaDataBuilder? _meta;
  MetaDataBuilder get meta => _$this._meta ??= new MetaDataBuilder();
  set meta(covariant MetaDataBuilder? meta) => _$this._meta = meta;

  ErrorDataBuilder? _error;
  ErrorDataBuilder get error => _$this._error ??= new ErrorDataBuilder();
  set error(covariant ErrorDataBuilder? error) => _$this._error = error;

  TrailErrorNoSerializerResponseBuilder();

  TrailErrorNoSerializerResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _statusCode = $v.statusCode;
      _timestamp = $v.timestamp;
      _path = $v.path;
      _message = $v.message;
      _meta = $v.meta?.toBuilder();
      _error = $v.error?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant TrailErrorNoSerializerResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TrailErrorNoSerializerResponse;
  }

  @override
  void update(void Function(TrailErrorNoSerializerResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TrailErrorNoSerializerResponse build() => _build();

  _$TrailErrorNoSerializerResponse _build() {
    _$TrailErrorNoSerializerResponse _$result;
    try {
      _$result = _$v ??
          new _$TrailErrorNoSerializerResponse._(
            statusCode: statusCode,
            timestamp: timestamp,
            path: path,
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
            r'TrailErrorNoSerializerResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
