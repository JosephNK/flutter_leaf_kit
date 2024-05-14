import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../base/error_response.dart';
import '../base/success_response.dart';

part 'currency_response.g.dart';

abstract class CurrencyResponse
    with SuccessResponseValues, ErrorResponseValues
    implements
        SuccessResponse,
        ErrorResponse,
        Built<CurrencyResponse, CurrencyResponseBuilder> {
  @BuiltValueField(wireName: null)
  String? get item;

  CurrencyResponse._();
  factory CurrencyResponse([void Function(CurrencyResponseBuilder) updates]) =
      _$CurrencyResponse;

  static Serializer<CurrencyResponse> get serializer =>
      _$currencyResponseSerializer;
}
