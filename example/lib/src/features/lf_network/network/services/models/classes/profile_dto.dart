import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'profile_dto.g.dart';

abstract class ProfileDTO implements Built<ProfileDTO, ProfileDTOBuilder> {
  @BuiltValueField(wireName: 'id')
  String? get id;

  @BuiltValueField(wireName: 'nickName')
  String? get nickName;

  @BuiltValueField(wireName: 'phoneNumber')
  String? get phoneNumber;

  @BuiltValueField(wireName: 'description')
  String? get description;

  ProfileDTO._();
  factory ProfileDTO([void Function(ProfileDTOBuilder) updates]) = _$ProfileDTO;

  static Serializer<ProfileDTO> get serializer => _$profileDTOSerializer;
}
