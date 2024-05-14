import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reviews_dto.g.dart';

abstract class ReviewsDTO implements Built<ReviewsDTO, ReviewsDTOBuilder> {
  @BuiltValueField(wireName: 'like')
  int? get like;

  @BuiltValueField(wireName: 'created')
  int? get created;

  @BuiltValueField(wireName: 'contents')
  String? get contents;

  ReviewsDTO._();
  factory ReviewsDTO([void Function(ReviewsDTOBuilder) updates]) = _$ReviewsDTO;

  static Serializer<ReviewsDTO> get serializer => _$reviewsDTOSerializer;
}
