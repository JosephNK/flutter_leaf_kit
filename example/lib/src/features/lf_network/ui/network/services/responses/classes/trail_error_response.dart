import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../base/error_response.dart';

part 'trail_error_response.g.dart';

abstract class TrailErrorResponse
    with ErrorResponseValues
    implements
        ErrorResponse,
        Built<TrailErrorResponse, TrailErrorResponseBuilder> {
  @BuiltValueField(wireName: 'statusCode')
  num? get statusCode;

  @BuiltValueField(wireName: 'timestamp')
  String? get timestamp;

  @BuiltValueField(wireName: 'path')
  String? get path;

  @BuiltValueField(wireName: 'message')
  String? get message;

  TrailErrorResponse._();
  factory TrailErrorResponse(
          [void Function(TrailErrorResponseBuilder) updates]) =
      _$TrailErrorResponse;

  static Serializer<TrailErrorResponse> get serializer =>
      _$trailErrorResponseSerializer;
}

abstract class TrailErrorNoSerializerResponse
    with
        ErrorResponseValues
    implements
        ErrorResponse,
        Built<TrailErrorNoSerializerResponse,
            TrailErrorNoSerializerResponseBuilder> {
  @BuiltValueField(wireName: 'statusCode')
  num? get statusCode;

  @BuiltValueField(wireName: 'timestamp')
  String? get timestamp;

  @BuiltValueField(wireName: 'path')
  String? get path;

  @BuiltValueField(wireName: 'message')
  String? get message;

  TrailErrorNoSerializerResponse._();
  factory TrailErrorNoSerializerResponse(
          [void Function(TrailErrorNoSerializerResponseBuilder) updates]) =
      _$TrailErrorNoSerializerResponse;

  static Serializer<TrailErrorNoSerializerResponse> get serializer =>
      _$trailErrorNoSerializerResponseSerializer;
}
