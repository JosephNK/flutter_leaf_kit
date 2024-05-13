part of '../../leaf_store.dart';

const kDefaultStatusCode = -9999;

class ErrorValueException implements Exception {
  ErrorValue value;

  ErrorValueException(this.value);
}

///////////////////////////////////////////////////////////////////////////////

typedef ErrorValueOnWait = Future<void> Function(
    BuildContext context, ErrorValue errorValue);

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
    final errorMessage = this.errorMessage;
    if (isEmpty(errorMessage)) {
      return '';
    }
    return '$errorMessage';
  }

  String get displayErrorMessageWithErrorCode {
    final errorCode = this.errorCode;
    final errorMessage = this.errorMessage;
    if (isNotEmpty(errorMessage) && isNotEmpty(errorCode)) {
      return '$errorMessage ($errorCode)';
    }
    if (isEmpty(errorMessage)) {
      return '';
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

  /// Utils

  static ErrorValue? getFirstErrorValues(List<ErrorValue?> errorValues) {
    final errorValue1s = errorValues.whereNotNull().toList();
    return errorValue1s.firstOrNull;
  }

  static ErrorValue? getLastErrorValues(List<ErrorValue?> errorValues) {
    final errorValue1s = errorValues.whereNotNull().toList();
    return errorValue1s.lastOrNull;
  }

  static Future<void> waitForErrorValues(
    BuildContext context, {
    required List<ErrorValue?> errorValues,
    ErrorValueOnWait? onWait,
  }) async {
    final errorValue1s = errorValues.whereNotNull().toList();
    await Future.forEach<ErrorValue>(errorValue1s, (errorValue) async {
      await onWait?.call(context, errorValue);
    });
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
