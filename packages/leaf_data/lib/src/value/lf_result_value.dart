part of leaf_data;

class ResultValue<T> extends Equatable {
  final ErrorValue? errorValue;
  final T? data;
  final Object? option;

  const ResultValue({
    this.errorValue,
    this.data,
    this.option,
  });

  @override
  List<Object?> get props => [
        errorValue,
        data,
        option,
      ];

  bool get empty {
    return errorValue == null && data == null && option == null;
  }

  /// Chain

  Future<ResultValue<T>> showIfExistErrorMessage(BuildContext context) async {
    final errorValue = this.errorValue;
    if (errorValue == null || errorValue.errorMessage == null) return this;
    await LFAlertDialog.showErrorMessage(context,
        errorMessage: errorValue.errorMessage);
    return this;
  }

  Future<ResultValue<T>> showIfExistExceptionMessage(
      BuildContext context) async {
    final errorValue = this.errorValue;
    if (errorValue == null || errorValue.exception == null) return this;
    await LFAlertDialog.showException(context, exception: errorValue.exception);
    return this;
  }

  /// Create

  static ResultValue<T> fromValue<T>({
    required int statusCode,
    String? errorCode,
    String? errorMessage,
    Object? exception,
    T? data,
    Object? option,
  }) {
    return ResultValue(
      errorValue: (errorMessage == null && exception == null)
          ? null
          : ErrorValue(
              statusCode: statusCode,
              errorCode: errorCode,
              errorMessage: errorMessage,
              exception: exception,
            ),
      data: data,
      option: option,
    );
  }

  static ResultValue<T> fromSuccess<T>(T? data, {Object? option}) {
    return ResultValue<T>(
      errorValue: null,
      data: data,
      option: option,
    );
  }

  static ResultValue<T> fromError<T>(T? data,
      {required ErrorValue? errorValue, Object? option}) {
    return ResultValue<T>(
      errorValue: errorValue,
      data: data,
      option: option,
    );
  }

  static ResultValue fromEmpty() {
    return const ResultValue();
  }
}

extension ResultValueCopyWith on ResultValue {
  ResultValue<T> copyWith<T>({
    ErrorValue? Function()? errorValue,
    T? Function()? data,
    Object? Function()? option,
  }) {
    return ResultValue<T>(
      errorValue: errorValue != null ? errorValue() : this.errorValue,
      data: data != null ? data() : this.data,
      option: option != null ? option() : this.option,
    );
  }
}
