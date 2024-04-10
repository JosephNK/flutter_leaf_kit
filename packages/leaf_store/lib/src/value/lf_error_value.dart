part of '../../leaf_store.dart';

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
    return '$errorMessage ($errorCode)';
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

  factory ErrorValue.fromException({
    dynamic exception,
  }) {
    return ErrorValue(
      statusCode: -9999,
      errorCode: null,
      errorMessage: 'Unknown Exception',
      exception: exception,
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
