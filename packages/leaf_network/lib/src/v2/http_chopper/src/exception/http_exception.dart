part of http_chopper;

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
  BadRequestException(int statusCode, String message, dynamic value)
      : super(statusCode, message, value);
}

/// HttpStatus 401
class UnauthorisedException extends HTTPException {
  UnauthorisedException(int statusCode, String message, dynamic value)
      : super(statusCode, message, value);
}

/// HttpStatus 404
class NotFoundException extends HTTPException {
  NotFoundException(int statusCode, String message, dynamic value)
      : super(statusCode, message, value);
}

/// HttpStatus 408
class TimeoutRequestException extends HTTPException {
  TimeoutRequestException(int statusCode, String message, dynamic value)
      : super(statusCode, message, value);
}

/// HttpStatus 500
class InternalServerException extends HTTPException {
  InternalServerException(int statusCode, String message, dynamic value)
      : super(statusCode, message, value);
}
