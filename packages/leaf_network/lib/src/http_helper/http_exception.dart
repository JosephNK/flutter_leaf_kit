bool isContainsHTTPException(Object? e) {
  if (e is BadRequestException ||
      e is UnauthorisedException ||
      e is NotFoundException ||
      e is TimeoutRequestException ||
      e is InternalServerException ||
      e is ServiceUnavailableException ||
      e is InternetNotConnectException ||
      e is ImageVolumeMaxException) {
    return true;
  }
  return false;
}

class HTTPException implements Exception {
  final int statusCode;
  final String message;
  final dynamic value;

  HTTPException(this.statusCode, this.message, this.value);

  @override
  String toString() {
    return '\n[*] statusCode: $statusCode\n[*] message: $message\n[*] value: $value';
  }
}

/// HttpStatus 400
class BadRequestException extends HTTPException {
  BadRequestException(super.statusCode, super.message, super.value);
}

/// HttpStatus 401
class UnauthorisedException extends HTTPException {
  UnauthorisedException(super.statusCode, super.message, super.value);
}

/// HttpStatus 404
class NotFoundException extends HTTPException {
  NotFoundException(super.statusCode, super.message, super.value);
}

/// HttpStatus 408
class TimeoutRequestException extends HTTPException {
  TimeoutRequestException(super.statusCode, super.message, super.value);
}

/// HttpStatus 500
class InternalServerException extends HTTPException {
  InternalServerException(super.statusCode, super.message, super.value);
}

/// HttpStatus 503
class ServiceUnavailableException extends HTTPException {
  ServiceUnavailableException(super.statusCode, super.message, super.value);
}

/// 인터넷 연결 에러
class InternetNotConnectException extends HTTPException {
  InternetNotConnectException(super.statusCode, super.message, super.value);
}

/// 이미지 용량 초과
class ImageVolumeMaxException extends HTTPException {
  ImageVolumeMaxException(super.statusCode, super.message, super.value);
}

class LFHttpExceptionObject extends Object {
  final HTTPException exception;

  LFHttpExceptionObject(this.exception);
}
