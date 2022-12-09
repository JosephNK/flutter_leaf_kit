import 'package:built_value/built_value.dart';

part 'api_success_response.g.dart';

@BuiltValue(instantiable: false)
abstract class APISuccessResponse extends Object with APISuccessResponseValues {
  APISuccessResponse rebuild(void Function(APISuccessResponseBuilder) updates);
  APISuccessResponseBuilder toBuilder();
}

abstract class APISuccessResponseValues {
  @BuiltValueField(wireName: 'total')
  int? get total;

  @BuiltValueField(wireName: 'next')
  int? get next;

  @BuiltValueField(wireName: 'skip')
  int? get skip;
}
