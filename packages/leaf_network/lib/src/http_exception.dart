part of leaf_network;

enum HTTPExceptionMessage { none, prefix, message }

class HTTPException implements Exception {
  final String _message;
  final String _prefix;
  final HTTPExceptionMessage _type;

  HTTPException(this._message, this._prefix, this._type);

  String get prefix => _prefix;

  @override
  String toString() {
    final prefix = _prefix;
    final message = _message;
    final type = _type;
    if (type == HTTPExceptionMessage.prefix) {
      return prefix;
    }
    if (type == HTTPExceptionMessage.message) {
      return message;
    }
    return '';
  }
}

// 400
class BadRequestException extends HTTPException {
  BadRequestException(String message)
      : super(
            message,
            'Invalid Request',
            kReleaseMode
                ? HTTPExceptionMessage.prefix
                : HTTPExceptionMessage.message);
}

// 401
class UnauthorisedException extends HTTPException {
  UnauthorisedException(String message)
      : super(
            message,
            'Unauthorised',
            kReleaseMode
                ? HTTPExceptionMessage.prefix
                : HTTPExceptionMessage.message);
}

// 404
class NotFoundException extends HTTPException {
  NotFoundException(String message)
      : super(
            message,
            'Not Found',
            kReleaseMode
                ? HTTPExceptionMessage.prefix
                : HTTPExceptionMessage.message);
}

// 408
class TimeoutRequestException extends HTTPException {
  TimeoutRequestException(String message)
      : super(message, 'Request Timeout', HTTPExceptionMessage.message);
}

// 500
class ServerIntrnalException extends HTTPException {
  ServerIntrnalException(String message)
      : super(
            message,
            'Internal Server Error',
            kReleaseMode
                ? HTTPExceptionMessage.prefix
                : HTTPExceptionMessage.message);
}

// 인터넷 연결 에러
class InternetNotConnectRequestException extends HTTPException {
  InternetNotConnectRequestException(String message)
      : super(message, 'Internet Not Connect', HTTPExceptionMessage.message);
}

// 이미지 용량 초과
class ImageVolumMaxException extends HTTPException {
  ImageVolumMaxException(String message)
      : super(message, 'Image Volume Max', HTTPExceptionMessage.message);
}
