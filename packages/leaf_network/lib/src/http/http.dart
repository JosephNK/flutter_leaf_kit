import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:leaf_common/leaf_common.dart';
import 'package:leaf_manager/leaf_manager.dart';

class HTTPManager extends http.BaseClient {
  final Duration timeout = const Duration(seconds: 30);
  final String timeOutMessage = '서버의 응답이 너무 늦습니다.';
  final String internetMessage = '인터넷 연결을 확인해 주세요.';
  final String imageReachMaxMessage = '사진 업로드 시에 오류가 발생하였습니다.';

  final bool followRedirects = false;

  final http.Client _httpClient = http.Client();

  static final HTTPManager _instance = HTTPManager._internal();

  static HTTPManager get shared => _instance;

  String? _appName;

  /// Header
  Map<String, String>? _header;
  // ignore: unnecessary_getters_setters
  Map<String, String>? get header {
    return _header;
  }

  // ignore: unnecessary_getters_setters
  set header(Map<String, String>? header) {
    _header = header;
  }

  HTTPManager._internal() {
    Logging.d('HTTPManager Init');
  }

  void setup({required String appName}) {
    _appName = appName;
  }

  @override
  void close() => _httpClient.close();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _httpClient.send(request);
  }

  @override
  Future<http.Response> head(
    url, {
    Map<String, String>? headers,
    List<int> excludeStatus = const [],
  }) async {
    try {
      await _throwConnectivityResultException();

      final uri = url;
      final httpHeaders = await _getHttpHeaders(uri: uri, headers: headers);
      final response = await _sendUnstreamed('HEAD', url, httpHeaders).timeout(
          timeout,
          onTimeout: () => throw LFTimeoutRequestException(timeOutMessage));
      final statusCode = response.statusCode;

      _loggingPrint(
          method: 'HEAD',
          statusCode: statusCode,
          url: url,
          requestBody: null,
          requestParam: null,
          response: response);

      if (!_isRequestSuccess(statusCode)) {
        if (!excludeStatus.contains(statusCode)) {
          _throwException(statusCode, response.body.toString());
        }
      }

      await LFCookieStoreManager.shared.setCookieByResponse(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> get(
    url, {
    Map<String, String>? headers,
    List<int> excludeStatus = const [],
  }) async {
    try {
      await _throwConnectivityResultException();

      final uri = url;
      final httpHeaders = await _getHttpHeaders(uri: uri, headers: headers);
      final response = await _sendUnstreamed('GET', url, httpHeaders).timeout(
          timeout,
          onTimeout: () => throw LFTimeoutRequestException(timeOutMessage));
      final statusCode = response.statusCode;

      _loggingPrint(
          method: 'GET',
          statusCode: statusCode,
          url: url,
          requestBody: null,
          requestParam: null,
          response: response);

      if (!_isRequestSuccess(statusCode)) {
        if (!excludeStatus.contains(statusCode)) {
          _throwException(statusCode, response.body.toString());
        }
      }

      await LFCookieStoreManager.shared.setCookieByResponse(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> post(
    url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    List<int> excludeStatus = const [],
  }) async {
    try {
      await _throwConnectivityResultException();

      final uri = url;
      final httpHeaders = await _getHttpHeaders(uri: uri, headers: headers);
      final response = await _sendUnstreamed(
              'POST', url, httpHeaders, body, encoding)
          .timeout(timeout,
              onTimeout: () => throw LFTimeoutRequestException(timeOutMessage));
      final statusCode = response.statusCode;

      _loggingPrint(
          method: 'POST',
          statusCode: statusCode,
          url: url,
          requestBody: body,
          requestParam: null,
          response: response);

      if (!_isRequestSuccess(statusCode)) {
        if (!excludeStatus.contains(statusCode)) {
          _throwException(statusCode, response.body.toString());
        }
      }

      await LFCookieStoreManager.shared.setCookieByResponse(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> put(
    url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    List<int> excludeStatus = const [],
  }) async {
    try {
      await _throwConnectivityResultException();

      final uri = url;
      final httpHeaders = await _getHttpHeaders(uri: uri, headers: headers);
      final response = await _sendUnstreamed(
              'PUT', url, httpHeaders, body, encoding)
          .timeout(timeout,
              onTimeout: () => throw LFTimeoutRequestException(timeOutMessage));
      final statusCode = response.statusCode;

      _loggingPrint(
          method: 'PUT',
          statusCode: statusCode,
          url: url,
          requestBody: body,
          requestParam: null,
          response: response);

      if (!_isRequestSuccess(statusCode)) {
        if (!excludeStatus.contains(statusCode)) {
          _throwException(statusCode, response.body.toString());
        }
      }

      await LFCookieStoreManager.shared.setCookieByResponse(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> delete(
    url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    List<int> excludeStatus = const [],
  }) async {
    try {
      await _throwConnectivityResultException();

      final uri = url;
      final httpHeaders = await _getHttpHeaders(uri: uri, headers: headers);
      final response = await _sendUnstreamed('DELETE', url, httpHeaders)
          .timeout(timeout,
              onTimeout: () => throw LFTimeoutRequestException(timeOutMessage));
      final statusCode = response.statusCode;

      _loggingPrint(
          method: 'DELETE',
          statusCode: statusCode,
          url: url,
          requestBody: body,
          requestParam: null,
          response: response);

      if (!_isRequestSuccess(statusCode)) {
        if (!excludeStatus.contains(statusCode)) {
          _throwException(statusCode, response.body.toString());
        }
      }

      await LFCookieStoreManager.shared.setCookieByResponse(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> patch(
    url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    List<int> excludeStatus = const [],
  }) async {
    try {
      await _throwConnectivityResultException();

      final uri = url;
      final httpHeaders = await _getHttpHeaders(uri: uri, headers: headers);
      final response = await _sendUnstreamed(
              'PATCH', url, httpHeaders, body, encoding)
          .timeout(timeout,
              onTimeout: () => throw LFTimeoutRequestException(timeOutMessage));
      final statusCode = response.statusCode;

      _loggingPrint(
          method: 'PATCH',
          statusCode: statusCode,
          url: url,
          requestBody: body,
          requestParam: null,
          response: response);

      if (!_isRequestSuccess(statusCode)) {
        if (!excludeStatus.contains(statusCode)) {
          _throwException(statusCode, response.body.toString());
        }
      }

      await LFCookieStoreManager.shared.setCookieByResponse(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> uploadImages(
    Uri url, {
    String httpMethod = 'POST',
    Map<String, String>? params,
    List<Uint8List>? imageDatas,
    Map<String, String>? headers,
    List<int> excludeStatus = const [],
    String imageFieldName = 'file',
  }) async {
    try {
      await _throwConnectivityResultException();

      final uri = url;
      final httpHeaders = await _getHttpHeaders(uri: uri, headers: headers);
      final request = http.MultipartRequest(httpMethod, uri);
      request.headers.addAll(httpHeaders);
      for (var imageData in imageDatas ?? []) {
        // final bytes = imageData.lengthInBytes;
        // if (bytes.isReachVolumeMaxSize()) {
        //   throw ImageVolumeMaxException(imageReachMaxMessage);
        // }

        final fileID = DateTime.now().toIso8601String();
        final fileName = '$fileID.jpg';
        final multipartFile = http.MultipartFile.fromBytes(
          imageFieldName,
          imageData,
          filename: fileName,
          contentType: MediaType('application', 'image'),
        );
        request.files.add(multipartFile);
      }

      if (params != null) {
        for (var key in params.keys) {
          final value = params[key];
          if (value != null) {
            request.fields[key] = value;
          }
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse).timeout(
          timeout,
          onTimeout: () => throw LFTimeoutRequestException(timeOutMessage));
      final statusCode = response.statusCode;

      _loggingPrint(
          method: httpMethod,
          statusCode: statusCode,
          url: url,
          requestBody: null,
          requestParam: params,
          response: response);

      if (!_isRequestSuccess(statusCode)) {
        if (!excludeStatus.contains(statusCode)) {
          _throwException(statusCode, response.body.toString());
        }
      }

      await LFCookieStoreManager.shared.setCookieByResponse(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<File> downloadFile(
    url, {
    Map<String, String>? headers,
    List<int> excludeStatus = const [],
    required String fileName,
  }) async {
    try {
      await _throwConnectivityResultException();

      final uri = url;
      final httpHeaders = await _getHttpHeaders(uri: uri, headers: headers);
      final response = await _sendUnstreamed('GET', url, httpHeaders).timeout(
          timeout,
          onTimeout: () => throw LFTimeoutRequestException(timeOutMessage));
      final statusCode = response.statusCode;

      _loggingPrint(
          method: 'GET',
          statusCode: statusCode,
          url: url,
          requestBody: null,
          requestParam: null,
          response: response);

      if (!_isRequestSuccess(statusCode)) {
        if (!excludeStatus.contains(statusCode)) {
          _throwException(statusCode, response.body.toString());
        }
      }

      var bytes = response.bodyBytes;
      var dir =
          await LFFileManager.shared.getApplicationDocumentsDirectoryPath();
      var file = await LFFileManager.shared
          .writeLocalByteFile(dir, fileName: fileName, bytes: bytes);
      return file;
    } catch (e) {
      rethrow;
    }
  }

  /// SendUnstreamed
  Future<http.Response> _sendUnstreamed(
      String method, url, Map<String, String>? headers,
      [body, Encoding? encoding]) async {
    var request = http.Request(method, _fromUriOrString(url))
      ..followRedirects = followRedirects;

    if (headers != null) request.headers.addAll(headers);
    if (encoding != null) request.encoding = encoding;
    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = body.cast<int>();
      } else if (body is Map) {
        request.bodyFields = body.cast<String, String>();
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }

    return http.Response.fromStream(await send(request));
  }

  /// FromUriOrString
  Uri _fromUriOrString(uri) => uri is String ? Uri.parse(uri) : uri as Uri;

  /// isRequestSuccess
  bool _isRequestSuccess(int statusCode) =>
      (statusCode >= 200 && statusCode < 400);

  /// Exception
  Exception _throwException(int statusCode, String body) {
    if (statusCode == 400) {
      throw LFBadRequestException(body);
    } else if (statusCode == 401) {
      throw LFUnauthorisedException(body);
    } else if (statusCode == 404) {
      throw LFNotFoundException(body);
    } else if (statusCode == 408) {
      throw LFTimeoutRequestException(body);
    } else {
      throw LFServerInternalException(body);
    }
  }

  Future<Exception?> _throwConnectivityResultException() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw LFInternetNotConnectRequestException(internetMessage);
    }
    return null;
  }

  /// Logging
  void _loggingPrint({
    required String method,
    required int statusCode,
    dynamic url,
    dynamic requestBody,
    dynamic requestParam,
    http.Response? response,
  }) {
    String message = '';
    message += 'HttpMethod => $method';
    message += '\nRequstUrl => ${url.toString()}';
    message += '\nStatusCode => ${statusCode.toString()}';
    if (requestBody != null) {
      message += '\nRequestBody => ${jsonEncode(requestBody)}';
    }
    if (requestParam != null) {
      message += '\nRequestParam => $requestParam';
    }
    if (response != null) {
      message += '\nResponseBody => ${response.body}';
    }
    Logging.d(message);
  }
}

extension HTTPManagerHeaders on HTTPManager {
  /// Default Headers
  Future<Map<String, String>> _defaultHeaders() async {
    return {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    };
  }

  /// UserAgent Headers
  Future<Map<String, String>> _userAgentHeaders() async {
    final appName = _appName;
    if (appName == null) {
      throw 'HTTPManager AppName should not be null';
    }
    final env = await Environment.packageInfo();
    final deployment = env.buildType.name;
    final version = env.version;
    final platform = env.platform;
    final agent = '$appName-$platform-$deployment-$version';
    return {
      HttpHeaders.userAgentHeader: agent,
    };
  }

  /// Get Headers
  Future<Map<String, String>> _getHttpHeaders({
    required Uri uri,
    Map<String, String>? headers,
  }) async {
    final cookieHeaders = await LFCookieStoreManager.shared.getHeader(uri);
    final defaultHeaders = await _defaultHeaders();
    final userAgentHeaders = await _userAgentHeaders();

    Map<String, String> mergeHeaders = {
      ...defaultHeaders,
      ...userAgentHeaders,
      ...cookieHeaders
    };
    if (headers != null) {
      mergeHeaders = {...mergeHeaders, ...headers};
    }

    final header = mergeHeaders;
    this.header = header;

    //Logging.d('HTTP Header: $header');

    return header;
  }
}

enum LFHTTPExceptionMessage { none, prefix, message }

class LFHTTPException implements Exception {
  final String _message;
  final String _prefix;
  final LFHTTPExceptionMessage _type;

  LFHTTPException(this._message, this._prefix, this._type);

  String get prefix => _prefix;

  @override
  String toString() {
    final prefix = _prefix;
    final message = _message;
    final type = _type;
    if (type == LFHTTPExceptionMessage.prefix) {
      return prefix;
    }
    if (type == LFHTTPExceptionMessage.message) {
      return message;
    }
    return '';
  }
}

// 400
class LFBadRequestException extends LFHTTPException {
  LFBadRequestException(String message)
      : super(
            message,
            'Invalid Request',
            kReleaseMode
                ? LFHTTPExceptionMessage.prefix
                : LFHTTPExceptionMessage.message);
}

// 401
class LFUnauthorisedException extends LFHTTPException {
  LFUnauthorisedException(String message)
      : super(
            message,
            'Unauthorised',
            kReleaseMode
                ? LFHTTPExceptionMessage.prefix
                : LFHTTPExceptionMessage.message);
}

// 404
class LFNotFoundException extends LFHTTPException {
  LFNotFoundException(String message)
      : super(
            message,
            'Not Found',
            kReleaseMode
                ? LFHTTPExceptionMessage.prefix
                : LFHTTPExceptionMessage.message);
}

// 408
class LFTimeoutRequestException extends LFHTTPException {
  LFTimeoutRequestException(String message)
      : super(message, 'Request Timeout', LFHTTPExceptionMessage.message);
}

// 500
class LFServerInternalException extends LFHTTPException {
  LFServerInternalException(String message)
      : super(
            message,
            'Internal Server Error',
            kReleaseMode
                ? LFHTTPExceptionMessage.prefix
                : LFHTTPExceptionMessage.message);
}

// 인터넷 연결 에러
class LFInternetNotConnectRequestException extends LFHTTPException {
  LFInternetNotConnectRequestException(String message)
      : super(message, 'Internet Not Connect', LFHTTPExceptionMessage.message);
}

// 이미지 용량 초과
class LFImageVolumeMaxException extends LFHTTPException {
  LFImageVolumeMaxException(String message)
      : super(message, 'Image Volume Max', LFHTTPExceptionMessage.message);
}
