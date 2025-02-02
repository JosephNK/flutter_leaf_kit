import 'package:built_value/built_value.dart';

part 'success_response.g.dart';

@BuiltValue(instantiable: false)
abstract class SuccessResponse extends Object with SuccessResponseValues {
  SuccessResponse rebuild(void Function(SuccessResponseBuilder) updates);
  SuccessResponseBuilder toBuilder();
}

mixin SuccessResponseValues {
  @BuiltValueField(wireName: 'result')
  bool? get result;
}
