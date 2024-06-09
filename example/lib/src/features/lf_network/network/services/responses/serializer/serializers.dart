import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../../models/model.dart';
import '../../models/serializer/serializers.dart';
import '../base/error_response.dart';
import '../responses.dart';

part 'serializers.g.dart';

@SerializersFor([
  ProductsGetAllResponse,
])
final Serializers responseSerializers = (_$responseSerializers.toBuilder()
      ..addPlugin(
        StandardJsonPlugin(),
      ))
    .build();

final Serializers responseMergedSerializers =
    Serializers.merge([responseSerializers, modelSerializers]);
