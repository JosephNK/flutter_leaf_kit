import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'error_response.g.dart';

@BuiltValue(instantiable: false)
abstract class ErrorResponse extends Object with ErrorResponseValues {
  ErrorResponse rebuild(void Function(ErrorResponseBuilder) updates);
  ErrorResponseBuilder toBuilder();
}

mixin ErrorResponseValues {
  @BuiltValueField(wireName: 'meta')
  MetaData? get meta;

  @BuiltValueField(wireName: 'error')
  ErrorData? get error;

  // @memoized
  // String get errorLocaleMessage {
  //   final localeMessage = this.localeMessage;
  //   final errorCode = this.errorCode;
  //   if (isNotEmpty(localeMessage)) {
  //     if (isNotEmpty(errorCode)) {
  //       return '$localeMessage ($errorCode)';
  //     }
  //     return localeMessage!;
  //   }
  //   return '$error\n(LocaleMessage is Empty)';
  // }
}

abstract class MetaData implements Built<MetaData, MetaDataBuilder> {
  @BuiltValueField(wireName: 'statusCode') // 500
  int? get statusCode;

  @BuiltValueField(wireName: 'timestamp') // "2024-04-14T07:54:07.490Z"
  String? get timestamp;

  @BuiltValueField(
      wireName:
          'path') // "/v1/products?url=https%3A%2F%2Fwww.google.com&lang=ja&currency=JPY&useCache=true&useAi=false&usePremium=false"
  String? get path;

  @BuiltValueField(wireName: 'message') // "Internal server error"
  String? get message;

  MetaData._();
  factory MetaData([void Function(MetaDataBuilder) updates]) = _$MetaData;

  static Serializer<MetaData> get serializer => _$metaDataSerializer;
}

abstract class ErrorData implements Built<ErrorData, ErrorDataBuilder> {
  @BuiltValueField(wireName: 'code') // 500
  int? get code;

  @BuiltValueField(wireName: 'message') // "Internal server error"
  String? get message;

  ErrorData._();
  factory ErrorData([void Function(ErrorDataBuilder) updates]) = _$ErrorData;

  static Serializer<ErrorData> get serializer => _$errorDataSerializer;
}
