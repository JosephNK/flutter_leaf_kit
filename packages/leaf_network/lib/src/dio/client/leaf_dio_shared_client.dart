import 'package:built_value/serializer.dart';

import '../converter/leaf_dio_json_key.dart';
import '../interceptor/leaf_dio_request_interceptor.dart';
import '../service/leaf_dio_service.dart';
import 'leaf_dio_client.dart';

/// 싱글톤으로 관리되는 [LeafDioClient] 래퍼.
///
/// [LeafDioSharedClient.shared]를 통해 앱 전역에서 동일한 Dio 인스턴스를 사용합니다.
class LeafDioSharedClient {
  static final LeafDioSharedClient _instance = LeafDioSharedClient._internal();
  static LeafDioSharedClient get shared => _instance;
  LeafDioSharedClient._internal();

  late LeafDioClient dioClient;

  /// 공유 Dio 클라이언트를 초기화합니다.
  ///
  /// - [baseUrl] API 서버의 기본 URL
  /// - [responseSerializers] built_value 응답 직렬화기
  /// - [services] 등록할 [LeafDioServiceBase] 목록
  /// - [interceptorBuilder] 추가 Dio 인터셉터를 구성하는 빌더
  /// - [jsonUndefinedKey] JSON 파싱 시 정의되지 않은 키 처리 정책
  /// - [connectTimeout] 연결 타임아웃 (기본값: 5초)
  /// - [receiveTimeout] 응답 수신 타임아웃 (기본값: 60초)
  /// - [onHeader] 요청 헤더를 동적으로 구성하는 콜백
  /// - [getTemporaryDirectoryPath] 파일 다운로드 시 임시 저장 경로를 반환하는 콜백
  void init({
    required Uri baseUrl,
    required Serializers responseSerializers,
    required List<LeafDioServiceBase> services,
    LeafDioInterceptorBuilder? interceptorBuilder,
    LeafDioJsonUndefinedKey? jsonUndefinedKey,
    Duration connectTimeout = const Duration(seconds: 5),
    Duration receiveTimeout = const Duration(seconds: 60),
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
      onHeader: onHeader,
      getTemporaryDirectoryPath: getTemporaryDirectoryPath,
    );
  }

  ServiceType getService<ServiceType extends LeafDioServiceBase>() {
    return dioClient.getService<ServiceType>();
  }
}
