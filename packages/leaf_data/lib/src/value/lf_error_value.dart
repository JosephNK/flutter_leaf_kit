part of leaf_data;

class ErrorValue extends Equatable {
  final int statusCode;
  final String? errorMessage;
  final Object? exception;

  const ErrorValue({
    required this.statusCode,
    this.errorMessage,
    this.exception,
  });

  @override
  List<Object?> get props => [
        statusCode,
        errorMessage,
        exception,
      ];

  String get message {
    // final exception = this.exception;
    final errorMessage = this.errorMessage;
    // if (exception != null) return exception.toString();
    return errorMessage.toString();
  }

  factory ErrorValue.fromException({
    dynamic exception,
  }) {
    return ErrorValue(
      statusCode: -999,
      errorMessage: 'Unknown Exception',
      exception: exception,
    );
  }
}
