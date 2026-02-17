import 'package:built_value/serializer.dart';
import 'package:flutter_leaf_network/leaf_network.dart';
import 'package:flutter_test/flutter_test.dart';

// 빈 Serializers (built_value 모델 없이 테스트)
final _emptySerializers = (Serializers().toBuilder()).build();

LeafDioExceptionConverter _createConverter() {
  return LeafDioExceptionConverter(serializers: _emptySerializers);
}

DioException _createDioException({
  required int statusCode,
  required dynamic data,
}) {
  final requestOptions = RequestOptions(path: '/test');
  return DioException(
    requestOptions: requestOptions,
    response: Response(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: data,
    ),
    type: DioExceptionType.badResponse,
  );
}

void main() {
  group('LeafDioExceptionConverter errorParser', () {
    test('errorParser 없이 호출하면 기존 fallback 동작', () async {
      final converter = _createConverter();
      final dioException = _createDioException(
        statusCode: 400,
        data: {'message': 'Bad request'},
      );

      final result = await converter.convertDioException<String, Null>(
        dioException,
      );

      expect(result.isSuccessful, isFalse);
      expect(result.statusCode, 400);
      expect(result.httpException, isA<LeafBadRequestException>());
    });

    test('errorParser가 상태 코드별 다른 객체 반환', () async {
      final converter = _createConverter();
      final dioException400 = _createDioException(
        statusCode: 400,
        data: {'field': 'email', 'message': 'invalid'},
      );
      final dioException500 = _createDioException(
        statusCode: 500,
        data: {'error': 'Internal server error', 'trace_id': 'abc123'},
      );

      Object? errorParser(int statusCode, dynamic body) {
        if (statusCode == 400 && body is Map) {
          return {'type': 'validation', 'field': body['field']};
        }
        if (statusCode >= 500 && body is Map) {
          return {'type': 'server', 'trace_id': body['trace_id']};
        }
        return null;
      }

      // 400 에러
      final result400 = await converter.convertDioException<String, Null>(
        dioException400,
        errorParser: errorParser,
      );
      expect(result400.error, isA<Map>());
      final error400 = result400.error as Map;
      expect(error400['type'], 'validation');
      expect(error400['field'], 'email');
      expect(result400.httpException, isA<LeafBadRequestException>());

      // 500 에러
      final result500 = await converter.convertDioException<String, Null>(
        dioException500,
        errorParser: errorParser,
      );
      expect(result500.error, isA<Map>());
      final error500 = result500.error as Map;
      expect(error500['type'], 'server');
      expect(error500['trace_id'], 'abc123');
      expect(result500.httpException, isA<LeafInternalServerException>());
    });

    test('errorParser가 null 반환하면 error는 null', () async {
      final converter = _createConverter();
      final dioException = _createDioException(
        statusCode: 404,
        data: {'message': 'Not found'},
      );

      final result = await converter.convertDioException<String, Null>(
        dioException,
        errorParser: (statusCode, body) => null,
      );

      expect(result.error, isNull);
      expect(result.httpException, isA<LeafNotFoundException>());
    });

    test('errorParser가 예외를 throw하면 에러 처리', () async {
      final converter = _createConverter();
      final dioException = _createDioException(
        statusCode: 400,
        data: {'error': 'bad input'},
      );

      final result = await converter.convertDioException<String, Null>(
        dioException,
        errorParser: (statusCode, body) {
          throw FormatException('parse failed');
        },
      );

      expect(result.error, isNull);
      expect(result.httpException, isA<LeafBadRequestException>());
      // body가 Map이면 parserException 메시지가 errorMessage에 포함
      final message = result.httpException?.message ?? '';
      expect(message, contains('FormatException'));
    });

    test('네트워크 에러(응답 없음)에는 errorParser 영향 없음', () async {
      final converter = _createConverter();
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
        message: 'Connection timeout',
      );

      var parserCalled = false;
      final result = await converter.convertDioException<String, Null>(
        dioException,
        errorParser: (statusCode, body) {
          parserCalled = true;
          return {'parsed': true};
        },
      );

      expect(parserCalled, isFalse);
      expect(result.httpException, isA<LeafConnectionTimeoutException>());
    });

    test('errorParser 없이 다양한 상태 코드 매핑 확인', () async {
      final converter = _createConverter();

      final cases = <int, Type>{
        400: LeafBadRequestException,
        401: LeafUnauthorisedException,
        404: LeafNotFoundException,
        408: LeafTimeoutRequestException,
        500: LeafInternalServerException,
        503: LeafServiceUnavailableException,
        999: LeafUnknownException,
      };

      for (final entry in cases.entries) {
        final dioException = _createDioException(
          statusCode: entry.key,
          data: 'error',
        );
        final result = await converter.convertDioException<String, Null>(
          dioException,
        );
        expect(
          result.httpException.runtimeType,
          entry.value,
          reason: 'statusCode ${entry.key} should map to ${entry.value}',
        );
      }
    });
  });
}
