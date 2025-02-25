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

/// Internet Connection Error
class InternetNotConnectException extends HTTPException {
  InternetNotConnectException(super.statusCode, super.message, super.value);
}

/// Image Volume Max Error
class ImageVolumeMaxException extends HTTPException {
  ImageVolumeMaxException(super.statusCode, super.message, super.value);
}

/// ConnectionTimeout
class ConnectionTimeoutException extends HTTPException {
  ConnectionTimeoutException(super.statusCode, super.message, super.value);
}

/// SendTimeout
class SendTimeoutException extends HTTPException {
  SendTimeoutException(super.statusCode, super.message, super.value);
}

/// ReceiveTimeout
class ReceiveTimeoutException extends HTTPException {
  ReceiveTimeoutException(super.statusCode, super.message, super.value);
}

/// BadCertificate
class BadCertificateException extends HTTPException {
  BadCertificateException(super.statusCode, super.message, super.value);
}

/// BadResponse
class BadResponseException extends HTTPException {
  BadResponseException(super.statusCode, super.message, super.value);
}

/// Cancel
class CancelException extends HTTPException {
  CancelException(super.statusCode, super.message, super.value);
}

/// ConnectionError
class ConnectionErrorException extends HTTPException {
  ConnectionErrorException(super.statusCode, super.message, super.value);
}

/// Unknown
class UnknownException extends HTTPException {
  UnknownException(super.statusCode, super.message, super.value);
}

class LFHttpExceptionObject extends Object {
  final HTTPException exception;

  LFHttpExceptionObject(this.exception);
}
