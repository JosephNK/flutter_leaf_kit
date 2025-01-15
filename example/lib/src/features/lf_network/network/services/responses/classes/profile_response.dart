import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../models/classes/profile_dto.dart';
import '../../models/model.dart';
import '../base/error_response.dart';
import '../base/success_response.dart';

part 'profile_response.g.dart';

abstract class ProfileMeGetResponse
    with ErrorResponseValues
    implements
        ErrorResponse,
        Built<ProfileMeGetResponse, ProfileMeGetResponseBuilder> {
  @BuiltValueField(wireName: 'item')
  ProfileDTO? get item;

  ProfileMeGetResponse._();
  factory ProfileMeGetResponse(
          [void Function(ProfileMeGetResponseBuilder) updates]) =
      _$ProfileMeGetResponse;

  static Serializer<ProfileMeGetResponse> get serializer =>
      _$profileMeGetResponseSerializer;
}
