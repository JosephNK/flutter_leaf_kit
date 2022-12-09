import 'package:built_value/built_value.dart';
import 'package:quiver/strings.dart';

part 'api_error_response.g.dart';

@BuiltValue(instantiable: false)
abstract class APIErrorResponse extends Object with APIErrorResponseValues {
  APIErrorResponse rebuild(void Function(APIErrorResponseBuilder) updates);
  APIErrorResponseBuilder toBuilder();
}

abstract class APIErrorResponseValues {
  @BuiltValueField(wireName: 'error_message')
  String? get errorMessage;

  @memoized
  bool get isError => isNotEmpty(errorMessage);
}
