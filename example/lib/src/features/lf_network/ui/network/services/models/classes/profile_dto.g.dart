// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProfileDTO> _$profileDTOSerializer = new _$ProfileDTOSerializer();

class _$ProfileDTOSerializer implements StructuredSerializer<ProfileDTO> {
  @override
  final Iterable<Type> types = const [ProfileDTO, _$ProfileDTO];
  @override
  final String wireName = 'ProfileDTO';

  @override
  Iterable<Object?> serialize(Serializers serializers, ProfileDTO object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.nickName;
    if (value != null) {
      result
        ..add('nickName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phoneNumber')
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
  ProfileDTO deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfileDTOBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'nickName':
          result.nickName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'phoneNumber':
          result.phoneNumber = serializers.deserialize(value,
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

class _$ProfileDTO extends ProfileDTO {
  @override
  final String? id;
  @override
  final String? nickName;
  @override
  final String? phoneNumber;
  @override
  final String? description;

  factory _$ProfileDTO([void Function(ProfileDTOBuilder)? updates]) =>
      (new ProfileDTOBuilder()..update(updates))._build();

  _$ProfileDTO._({this.id, this.nickName, this.phoneNumber, this.description})
      : super._();

  @override
  ProfileDTO rebuild(void Function(ProfileDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileDTOBuilder toBuilder() => new ProfileDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileDTO &&
        id == other.id &&
        nickName == other.nickName &&
        phoneNumber == other.phoneNumber &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, nickName.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProfileDTO')
          ..add('id', id)
          ..add('nickName', nickName)
          ..add('phoneNumber', phoneNumber)
          ..add('description', description))
        .toString();
  }
}

class ProfileDTOBuilder implements Builder<ProfileDTO, ProfileDTOBuilder> {
  _$ProfileDTO? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _nickName;
  String? get nickName => _$this._nickName;
  set nickName(String? nickName) => _$this._nickName = nickName;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ProfileDTOBuilder();

  ProfileDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _nickName = $v.nickName;
      _phoneNumber = $v.phoneNumber;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProfileDTO;
  }

  @override
  void update(void Function(ProfileDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileDTO build() => _build();

  _$ProfileDTO _build() {
    final _$result = _$v ??
        new _$ProfileDTO._(
            id: id,
            nickName: nickName,
            phoneNumber: phoneNumber,
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
