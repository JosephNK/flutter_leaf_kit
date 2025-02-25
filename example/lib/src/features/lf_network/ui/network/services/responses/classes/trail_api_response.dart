import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../base/error_response.dart';

part 'trail_api_response.g.dart';

abstract class TrailApiResponse
    with ErrorResponseValues
    implements ErrorResponse, Built<TrailApiResponse, TrailApiResponseBuilder> {
  @BuiltValueField(wireName: 'message')
  String? get message;

  TrailApiResponse._();
  factory TrailApiResponse([void Function(TrailApiResponseBuilder) updates]) =
      _$TrailApiResponse;

  static Serializer<TrailApiResponse> get serializer =>
      _$trailApiResponseSerializer;
}
