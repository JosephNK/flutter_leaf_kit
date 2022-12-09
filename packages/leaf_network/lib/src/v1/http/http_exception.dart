part of leaf_network;

enum LeafHTTPExceptionMessage { none, prefix, message }

class LeafHTTPException implements Exception {
  final String _message;
  final String _prefix;
  final LeafHTTPExceptionMessage _type;

  LeafHTTPException(this._message, this._prefix, this._type);

  String get prefix => _prefix;

  @override
  String toString() {
    final prefix = _prefix;
    final message = _message;
    final type = _type;
    if (type == LeafHTTPExceptionMessage.prefix) {
      return prefix;
    }
    if (type == LeafHTTPExceptionMessage.message) {
      return message;
    }
    return '';
  }
}

// 400
class LeafBadRequestException extends LeafHTTPException {
  LeafBadRequestException(String message)
      : super(
            message,
            'Invalid Request',
            kReleaseMode
                ? LeafHTTPExceptionMessage.prefix
                : LeafHTTPExceptionMessage.message);
}

// 401
class LeafUnauthorisedException extends LeafHTTPException {
  LeafUnauthorisedException(String message)
      : super(
            message,
            'Unauthorised',
            kReleaseMode
                ? LeafHTTPExceptionMessage.prefix
                : LeafHTTPExceptionMessage.message);
}

// 404
class LeafNotFoundException extends LeafHTTPException {
  LeafNotFoundException(String message)
      : super(
            message,
            'Not Found',
            kReleaseMode
                ? LeafHTTPExceptionMessage.prefix
                : LeafHTTPExceptionMessage.message);
}

// 408
class LeafTimeoutRequestException extends LeafHTTPException {
  LeafTimeoutRequestException(String message)
      : super(message, 'Request Timeout', LeafHTTPExceptionMessage.message);
}

// 500
class LeafServerInternalException extends LeafHTTPException {
  LeafServerInternalException(String message)
      : super(
            message,
            'Internal Server Error',
            kReleaseMode
                ? LeafHTTPExceptionMessage.prefix
                : LeafHTTPExceptionMessage.message);
}

// 인터넷 연결 에러
class LeafInternetNotConnectRequestException extends LeafHTTPException {
  LeafInternetNotConnectRequestException(String message)
      : super(
            message, 'Internet Not Connect', LeafHTTPExceptionMessage.message);
}

// 이미지 용량 초과
class LeafImageVolumeMaxException extends LeafHTTPException {
  LeafImageVolumeMaxException(String message)
      : super(message, 'Image Volume Max', LeafHTTPExceptionMessage.message);
}
