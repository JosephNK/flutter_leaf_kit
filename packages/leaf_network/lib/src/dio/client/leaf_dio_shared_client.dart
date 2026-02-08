import 'package:built_value/serializer.dart';

import '../converter/leaf_dio_json_key.dart';
import '../interceptor/leaf_dio_request_interceptor.dart';
import '../service/leaf_dio_service.dart';
import 'leaf_dio_client.dart';

class LeafDioSharedClient {
  static final LeafDioSharedClient _instance = LeafDioSharedClient._internal();
  static LeafDioSharedClient get shared => _instance;
  LeafDioSharedClient._internal();

  late LeafDioClient dioClient;

  void init({
    required Uri baseUrl,
    required Serializers responseSerializers,
    required List<LeafDioServiceBase> services,
    LeafDioInterceptorBuilder? interceptorBuilder,
    LeafDioJsonUndefinedKey? jsonUndefinedKey,
    Duration connectTimeout = const Duration(seconds: 5),
    Duration receiveTimeout = const Duration(seconds: 60),
    int printMaxLength = 2024,
    LeafDioOnHeader? onHeader,
    Future<String> Function()? getTemporaryDirectoryPath,
  }) {
    dioClient = LeafDioClient().init(
      baseUrl: baseUrl,
      responseSerializers: responseSerializers,
      services: services,
      interceptorBuilder: interceptorBuilder,
      jsonUndefinedKey: jsonUndefinedKey,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      printMaxLength: printMaxLength,
      onHeader: onHeader,
      getTemporaryDirectoryPath: getTemporaryDirectoryPath,
    );
  }

  ServiceType getService<ServiceType extends LeafDioServiceBase>() {
    return dioClient.getService<ServiceType>();
  }
}
