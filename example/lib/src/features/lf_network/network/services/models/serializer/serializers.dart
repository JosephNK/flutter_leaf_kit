import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../model.dart';

part 'serializers.g.dart';

@SerializersFor([
  ProductDTO,
])
final Serializers modelSerializers = (_$modelSerializers.toBuilder()
      ..addPlugin(
        StandardJsonPlugin(),
      ))
    .build();
