bool isLeafHttpException(Object? e) {
  if (e is LeafBadRequestException ||
      e is LeafUnauthorisedException ||
      e is LeafNotFoundException ||
      e is LeafTimeoutRequestException ||
      e is LeafInternalServerException ||
      e is LeafServiceUnavailableException ||
      e is LeafInternetNotConnectException ||
      e is LeafImageVolumeMaxException) {
    return true;
  }
  return false;
}

class LeafHttpException implements Exception {
  final int statusCode;
  final String message;
  final dynamic value;

  LeafHttpException(this.statusCode, this.message, this.value);

  @override
  String toString() {
    return 'LeafHttpException \n[*] statusCode: $statusCode\n[*] message: $message\n[*] value: $value';
  }
}

/// HttpStatus 400
class LeafBadRequestException extends LeafHttpException {
  LeafBadRequestException(super.statusCode, super.message, super.value);
}

/// HttpStatus 401
class LeafUnauthorisedException extends LeafHttpException {
  LeafUnauthorisedException(super.statusCode, super.message, super.value);
}

/// HttpStatus 404
class LeafNotFoundException extends LeafHttpException {
  LeafNotFoundException(super.statusCode, super.message, super.value);
}

/// HttpStatus 408
class LeafTimeoutRequestException extends LeafHttpException {
  LeafTimeoutRequestException(super.statusCode, super.message, super.value);
}

/// HttpStatus 500
class LeafInternalServerException extends LeafHttpException {
  LeafInternalServerException(super.statusCode, super.message, super.value);
}

/// HttpStatus 503
class LeafServiceUnavailableException extends LeafHttpException {
  LeafServiceUnavailableException(super.statusCode, super.message, super.value);
}

/// Internet Connection Error
class LeafInternetNotConnectException extends LeafHttpException {
  LeafInternetNotConnectException(super.statusCode, super.message, super.value);
}

/// Image Volume Max Error
class LeafImageVolumeMaxException extends LeafHttpException {
  LeafImageVolumeMaxException(super.statusCode, super.message, super.value);
}

/// ConnectionTimeout
class LeafConnectionTimeoutException extends LeafHttpException {
  LeafConnectionTimeoutException(super.statusCode, super.message, super.value);
}

/// SendTimeout
class LeafSendTimeoutException extends LeafHttpException {
  LeafSendTimeoutException(super.statusCode, super.message, super.value);
}

/// ReceiveTimeout
class LeafReceiveTimeoutException extends LeafHttpException {
  LeafReceiveTimeoutException(super.statusCode, super.message, super.value);
}

/// BadCertificate
class LeafBadCertificateException extends LeafHttpException {
  LeafBadCertificateException(super.statusCode, super.message, super.value);
}

/// BadResponse
class LeafBadResponseException extends LeafHttpException {
  LeafBadResponseException(super.statusCode, super.message, super.value);
}

/// Cancel
class LeafCancelException extends LeafHttpException {
  LeafCancelException(super.statusCode, super.message, super.value);
}

/// ConnectionError
class LeafConnectionErrorException extends LeafHttpException {
  LeafConnectionErrorException(super.statusCode, super.message, super.value);
}

/// Unknown
class LeafUnknownException extends LeafHttpException {
  LeafUnknownException(super.statusCode, super.message, super.value);
}

class LeafHttpExceptionObject extends Object {
  final LeafHttpException httpException;

  LeafHttpExceptionObject(this.httpException);

  @override
  String toString() {
    return '\n[*] runtimeType: ${runtimeType.toString()}'
        '\n[*] httpException: ${httpException.runtimeType.toString()}'
        '${httpException.toString()}';
  }
}
