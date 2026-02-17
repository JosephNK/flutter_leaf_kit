import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import '../converter/leaf_dio_built_value_converter.dart';
import '../converter/leaf_dio_exception_converter.dart';
import '../converter/leaf_dio_json_key.dart';
import '../interceptor/leaf_dio_curl_interceptor.dart';
import '../interceptor/leaf_dio_request_interceptor.dart';
import '../service/leaf_dio_service.dart';

Type _typeOf<T>() => T;

typedef LeafDioInterceptorBuilder = List<Interceptor>? Function(Dio dio);

class LeafDioClient {
  late Dio dio;
  late LeafDioBuiltValueConverter converter;
  late LeafDioExceptionConverter errorConverter;
  final Map<Type, LeafDioServiceBase> _services = {};
  Future<String> Function()? _getTemporaryDirectoryPath;

  Map<Type, LeafDioServiceBase> get services => _services;

  /// Dio HTTP 클라이언트를 초기화합니다.
  ///
  /// - [baseUrl] API 서버의 기본 URL
  /// - [responseSerializers] built_value 응답 직렬화기
  /// - [services] 등록할 [LeafDioServiceBase] 목록
  /// - [interceptorBuilder] 추가 Dio 인터셉터를 구성하는 빌더
  /// - [jsonUndefinedKey] JSON 파싱 시 정의되지 않은 키 처리 정책
  /// - [connectTimeout] 연결 타임아웃 (기본값: 5초)
  /// - [receiveTimeout] 응답 수신 타임아웃 (기본값: 60초)
  /// - [printMaxLength] 로그 출력 시 최대 문자 수 (기본값: 2024)
  /// - [onHeader] 요청 헤더를 동적으로 구성하는 콜백
  /// - [getTemporaryDirectoryPath] 파일 다운로드 시 임시 저장 경로를 반환하는 콜백
  LeafDioClient init({
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
    _getTemporaryDirectoryPath = getTemporaryDirectoryPath;

    final options = BaseOptions(
      baseUrl: baseUrl.toString(),
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );

    // Converter
    converter = LeafDioBuiltValueConverter(
      serializers: responseSerializers,
      printMaxLength: printMaxLength,
      jsonUndefinedKey: jsonUndefinedKey,
    );
    errorConverter = LeafDioExceptionConverter(
      serializers: responseSerializers,
      printMaxLength: printMaxLength,
    );

    dio = Dio(options);
    dio.interceptors.add(LeafDioCurlInterceptor());
    dio.interceptors.add(LeafDioRequestInterceptor(onHeader: onHeader));
    if (interceptorBuilder != null) {
      final interceptors = interceptorBuilder(dio);
      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
    }

    // Setup Services
    services.toSet().forEach((s) {
      s.dio = dio;
      s.converter = converter;
      s.errorConverter = errorConverter;
      _services[s.runtimeType] = s;
    });

    return this;
  }

  ServiceType getService<ServiceType extends LeafDioServiceBase>() {
    final Type serviceType = _typeOf<ServiceType>();
    if (serviceType == dynamic || serviceType == LeafDioServiceBase) {
      throw Exception(
        'Service type should be provided, `dynamic` is not allowed.',
      );
    }
    final LeafDioServiceBase? service = _services[serviceType];
    if (service == null) {
      throw Exception('Service of type \'$serviceType\' not found.');
    }
    return service as ServiceType;
  }

  Future<String> getTemporarySavePath(String fileName) async {
    assert(
      _getTemporaryDirectoryPath != null,
      'getTemporaryDirectoryPath callback is required for file operations.',
    );
    final savePath = '${await _getTemporaryDirectoryPath!()}/$fileName';
    return savePath;
  }

  Future<File?> isExistFile({required String fileName}) async {
    final savePath = await getTemporarySavePath(fileName);
    if (File(savePath).existsSync()) {
      return File(savePath);
    }
    return null;
  }

  Future<File?> saveFile({required String fileName}) async {
    final savePath = await getTemporarySavePath(fileName);
    if (File(savePath).existsSync()) {
      return File(savePath);
    }
    return null;
  }

  Future<Response?> download(
    String urlPath, {
    required String fileName,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    final savePath = await getTemporarySavePath(fileName);
    try {
      final response = await dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List?> resizeDownloadImage(
    Uri uri, {
    required int targetWidth,
    required int targetHeight,
  }) async {
    try {
      final response = await dio.get<List<int>>(
        uri.toString(),
        options: Options(responseType: ResponseType.bytes),
      );
      final originalUnit8List = Uint8List.fromList(response.data!);
      var codec = await ui.instantiateImageCodec(
        originalUnit8List,
        targetHeight: targetHeight,
        targetWidth: targetWidth,
      );
      var frameInfo = await codec.getNextFrame();
      ui.Image targetUiImage = frameInfo.image;
      ByteData? targetByteData = await targetUiImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List? targetUint8List = targetByteData?.buffer.asUint8List();
      return targetUint8List;
    } catch (e) {
      rethrow;
    }
  }

  static CancelToken createCancelToken() {
    return CancelToken();
  }
}
