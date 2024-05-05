part of '../../leaf_store.dart';

const kDefaultStatusCode = -9999;

class ErrorValueException implements Exception {
  ErrorValue value;

  ErrorValueException(this.value);
}

///////////////////////////////////////////////////////////////////////////////

class ErrorValue extends Equatable {
  final int statusCode;
  final String? errorCode;
  final String? errorMessage;
  final Object? exception;

  const ErrorValue({
    required this.statusCode,
    this.errorCode,
    this.errorMessage,
    this.exception,
  });

  @override
  List<Object?> get props => [
        statusCode,
        errorCode,
        errorMessage,
        exception,
      ];

  String get displayErrorMessage {
    final errorCode = this.errorCode;
    final errorMessage = this.errorMessage;
    if (isNotEmpty(errorCode)) {
      return '$errorMessage ($errorCode)';
    }
    return '$errorMessage';
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
      'exception': exception,
    };
  }

  ErrorValueException get objectToException {
    return ErrorValueException(this);
  }

  /// Create

  factory ErrorValue.empty() {
    return const ErrorValue(
      statusCode: kDefaultStatusCode,
      errorCode: null,
      errorMessage: null,
      exception: null,
    );
  }

  factory ErrorValue.fromException({
    dynamic exception,
    String? errorCode,
  }) {
    if (exception is ErrorValue) {
      return exception;
    }
    return ErrorValue(
      statusCode: kDefaultStatusCode,
      errorCode: errorCode,
      errorMessage: 'Unknown Exception',
      exception: exception,
    );
  }

  factory ErrorValue.fromErrorMessage(
    String errorMessage, {
    String? errorCode,
  }) {
    return ErrorValue(
      statusCode: kDefaultStatusCode,
      errorCode: errorCode,
      errorMessage: errorMessage,
      exception: null,
    );
  }
}

extension ErrorValueCopyWith on ErrorValue {
  ErrorValue copyWith({
    int Function()? statusCode,
    String? Function()? errorCode,
    String? Function()? errorMessage,
    Object? Function()? exception,
  }) {
    return ErrorValue(
      statusCode: statusCode != null ? statusCode() : this.statusCode,
      errorCode: errorCode != null ? errorCode() : this.errorCode,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      exception: exception != null ? exception() : this.exception,
    );
  }
}
