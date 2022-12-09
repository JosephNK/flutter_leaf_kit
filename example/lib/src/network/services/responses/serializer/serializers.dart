import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../../../models/serializer/serializers.dart';
import '../classes/product_response.dart';

part 'serializers.g.dart';

@SerializersFor([
  ProductResponse,
])
final Serializers responseSerializers = (_$responseSerializers.toBuilder()
      ..addPlugin(
        StandardJsonPlugin(),
      ))
    .build();

final Serializers serializers =
    Serializers.merge([responseSerializers, modelSerializers]);
