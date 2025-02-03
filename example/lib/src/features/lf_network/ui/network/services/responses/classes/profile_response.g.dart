// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProfileMeGetResponse> _$profileMeGetResponseSerializer =
    new _$ProfileMeGetResponseSerializer();

class _$ProfileMeGetResponseSerializer
    implements StructuredSerializer<ProfileMeGetResponse> {
  @override
  final Iterable<Type> types = const [
    ProfileMeGetResponse,
    _$ProfileMeGetResponse
  ];
  @override
  final String wireName = 'ProfileMeGetResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ProfileMeGetResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.item;
    if (value != null) {
      result
        ..add('item')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ProfileDTO)));
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
  ProfileMeGetResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfileMeGetResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'item':
          result.item.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProfileDTO))! as ProfileDTO);
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

class _$ProfileMeGetResponse extends ProfileMeGetResponse {
  @override
  final ProfileDTO? item;
  @override
  final MetaData? meta;
  @override
  final ErrorData? error;

  factory _$ProfileMeGetResponse(
          [void Function(ProfileMeGetResponseBuilder)? updates]) =>
      (new ProfileMeGetResponseBuilder()..update(updates))._build();

  _$ProfileMeGetResponse._({this.item, this.meta, this.error}) : super._();

  @override
  ProfileMeGetResponse rebuild(
          void Function(ProfileMeGetResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileMeGetResponseBuilder toBuilder() =>
      new ProfileMeGetResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileMeGetResponse &&
        item == other.item &&
        meta == other.meta &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, item.hashCode);
    _$hash = $jc(_$hash, meta.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProfileMeGetResponse')
          ..add('item', item)
          ..add('meta', meta)
          ..add('error', error))
        .toString();
  }
}

class ProfileMeGetResponseBuilder
    implements
        Builder<ProfileMeGetResponse, ProfileMeGetResponseBuilder>,
        ErrorResponseBuilder {
  _$ProfileMeGetResponse? _$v;

  ProfileDTOBuilder? _item;
  ProfileDTOBuilder get item => _$this._item ??= new ProfileDTOBuilder();
  set item(covariant ProfileDTOBuilder? item) => _$this._item = item;

  MetaDataBuilder? _meta;
  MetaDataBuilder get meta => _$this._meta ??= new MetaDataBuilder();
  set meta(covariant MetaDataBuilder? meta) => _$this._meta = meta;

  ErrorDataBuilder? _error;
  ErrorDataBuilder get error => _$this._error ??= new ErrorDataBuilder();
  set error(covariant ErrorDataBuilder? error) => _$this._error = error;

  ProfileMeGetResponseBuilder();

  ProfileMeGetResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _item = $v.item?.toBuilder();
      _meta = $v.meta?.toBuilder();
      _error = $v.error?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant ProfileMeGetResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProfileMeGetResponse;
  }

  @override
  void update(void Function(ProfileMeGetResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileMeGetResponse build() => _build();

  _$ProfileMeGetResponse _build() {
    _$ProfileMeGetResponse _$result;
    try {
      _$result = _$v ??
          new _$ProfileMeGetResponse._(
            item: _item?.build(),
            meta: _meta?.build(),
            error: _error?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'item';
        _item?.build();
        _$failedField = 'meta';
        _meta?.build();
        _$failedField = 'error';
        _error?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProfileMeGetResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
