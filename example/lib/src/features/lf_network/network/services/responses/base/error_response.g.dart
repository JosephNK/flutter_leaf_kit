// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MetaData> _$metaDataSerializer = new _$MetaDataSerializer();
Serializer<ErrorData> _$errorDataSerializer = new _$ErrorDataSerializer();

class _$MetaDataSerializer implements StructuredSerializer<MetaData> {
  @override
  final Iterable<Type> types = const [MetaData, _$MetaData];
  @override
  final String wireName = 'MetaData';

  @override
  Iterable<Object?> serialize(Serializers serializers, MetaData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.statusCode;
    if (value != null) {
      result
        ..add('statusCode')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
    return result;
  }

  @override
  MetaData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MetaDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'statusCode':
          result.statusCode = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
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
      }
    }

    return result.build();
  }
}

class _$ErrorDataSerializer implements StructuredSerializer<ErrorData> {
  @override
  final Iterable<Type> types = const [ErrorData, _$ErrorData];
  @override
  final String wireName = 'ErrorData';

  @override
  Iterable<Object?> serialize(Serializers serializers, ErrorData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ErrorData deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ErrorDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

abstract mixin class ErrorResponseBuilder {
  void replace(ErrorResponse other);
  void update(void Function(ErrorResponseBuilder) updates);
  MetaDataBuilder get meta;
  set meta(MetaDataBuilder? meta);

  ErrorDataBuilder get error;
  set error(ErrorDataBuilder? error);
}

class _$MetaData extends MetaData {
  @override
  final int? statusCode;
  @override
  final String? timestamp;
  @override
  final String? path;
  @override
  final String? message;

  factory _$MetaData([void Function(MetaDataBuilder)? updates]) =>
      (new MetaDataBuilder()..update(updates))._build();

  _$MetaData._({this.statusCode, this.timestamp, this.path, this.message})
      : super._();

  @override
  MetaData rebuild(void Function(MetaDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MetaDataBuilder toBuilder() => new MetaDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MetaData &&
        statusCode == other.statusCode &&
        timestamp == other.timestamp &&
        path == other.path &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, statusCode.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MetaData')
          ..add('statusCode', statusCode)
          ..add('timestamp', timestamp)
          ..add('path', path)
          ..add('message', message))
        .toString();
  }
}

class MetaDataBuilder implements Builder<MetaData, MetaDataBuilder> {
  _$MetaData? _$v;

  int? _statusCode;
  int? get statusCode => _$this._statusCode;
  set statusCode(int? statusCode) => _$this._statusCode = statusCode;

  String? _timestamp;
  String? get timestamp => _$this._timestamp;
  set timestamp(String? timestamp) => _$this._timestamp = timestamp;

  String? _path;
  String? get path => _$this._path;
  set path(String? path) => _$this._path = path;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  MetaDataBuilder();

  MetaDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _statusCode = $v.statusCode;
      _timestamp = $v.timestamp;
      _path = $v.path;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MetaData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MetaData;
  }

  @override
  void update(void Function(MetaDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MetaData build() => _build();

  _$MetaData _build() {
    final _$result = _$v ??
        new _$MetaData._(
            statusCode: statusCode,
            timestamp: timestamp,
            path: path,
            message: message);
    replace(_$result);
    return _$result;
  }
}

class _$ErrorData extends ErrorData {
  @override
  final int? code;
  @override
  final String? message;

  factory _$ErrorData([void Function(ErrorDataBuilder)? updates]) =>
      (new ErrorDataBuilder()..update(updates))._build();

  _$ErrorData._({this.code, this.message}) : super._();

  @override
  ErrorData rebuild(void Function(ErrorDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorDataBuilder toBuilder() => new ErrorDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorData && code == other.code && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ErrorData')
          ..add('code', code)
          ..add('message', message))
        .toString();
  }
}

class ErrorDataBuilder implements Builder<ErrorData, ErrorDataBuilder> {
  _$ErrorData? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ErrorDataBuilder();

  ErrorDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ErrorData;
  }

  @override
  void update(void Function(ErrorDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorData build() => _build();

  _$ErrorData _build() {
    final _$result = _$v ?? new _$ErrorData._(code: code, message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
