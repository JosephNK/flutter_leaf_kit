import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../models/model.dart';
import '../base/error_response.dart';
import '../base/success_response.dart';

part 'reviews_gets_response.g.dart';

abstract class ReviewsGetsResponse
    with SuccessResponseValues, ErrorResponseValues
    implements
        SuccessResponse,
        ErrorResponse,
        Built<ReviewsGetsResponse, ReviewsGetsResponseBuilder> {
  // @BuiltValueField(wireName: 'total')
  int? get total;

  // @BuiltValueField(wireName: 'data')
  BuiltList<ReviewsDTO>? get data;

  ReviewsGetsResponse._();
  factory ReviewsGetsResponse(
          [void Function(ReviewsGetsResponseBuilder) updates]) =
      _$ReviewsGetsResponse;

  static Serializer<ReviewsGetsResponse> get serializer =>
      _$reviewsGetsResponseSerializer;
}
