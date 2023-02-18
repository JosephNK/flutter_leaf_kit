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

  /// Create

  factory ErrorValue.fromException({
    dynamic exception,
  }) {
    return ErrorValue(
      statusCode: -9999,
      errorMessage: 'Unknown Exception',
      exception: exception,
    );
  }
}

extension ErrorValueCopyWith on ErrorValue {
  ErrorValue copyWith({
    int Function()? statusCode,
    String? Function()? errorMessage,
    Object? Function()? exception,
  }) {
    return ErrorValue(
      statusCode: statusCode != null ? statusCode() : this.statusCode,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      exception: exception != null ? exception() : this.exception,
    );
  }
}
