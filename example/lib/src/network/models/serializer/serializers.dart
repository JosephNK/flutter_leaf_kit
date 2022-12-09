import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../classes/product.dart';

part 'serializers.g.dart';

@SerializersFor([
  Product,
])
final Serializers modelSerializers = (_$modelSerializers.toBuilder()
      ..addPlugin(
        StandardJsonPlugin(),
      ))
    .build();
