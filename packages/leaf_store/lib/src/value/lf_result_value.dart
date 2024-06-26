part of '../../leaf_store.dart';

typedef ResultValueOnErrorMessage = Future<Widget> Function(
  BuildContext context, {
  required String errorMessage,
});
typedef ResultValueOnException = Future<Widget> Function(
  BuildContext context, {
  Object? exception,
});

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

  Future<ResultValue<T>> showIfExistErrorMessage(
    BuildContext context, {
    ResultValueOnErrorMessage? onErrorMessage,
  }) async {
    final errorValue = this.errorValue;
    if (errorValue == null || errorValue.errorMessage == null) return this;
    if (context.mounted) {
      final errorMessage = errorValue.errorMessage;
      if (errorMessage != null) {
        await onErrorMessage?.call(context, errorMessage: errorMessage);
      }
    }
    return this;
  }

  Future<ResultValue<T>> showIfExistExceptionMessage(
    BuildContext context, {
    ResultValueOnException? onException,
  }) async {
    final errorValue = this.errorValue;
    if (errorValue == null || errorValue.exception == null) return this;
    if (context.mounted) {
      final exception = errorValue.exception;
      await onException?.call(context, exception: exception);
    }
    return this;
  }

  /// Create

  static ResultValue<T> fromValue<T>({
    ErrorValue? errorValue,
    T? data,
    Object? option,
  }) {
    return ResultValue<T>(
      errorValue: errorValue,
      data: data,
      option: option,
    );
  }

  static ResultValue<T> fromSuccess<T>(
    T? data, {
    Object? option,
  }) {
    return ResultValue<T>(
      errorValue: null,
      data: data,
      option: option,
    );
  }

  static ResultValue<T> fromError<T>(
    T? data, {
    required ErrorValue? errorValue,
    Object? option,
  }) {
    return ResultValue<T>(
      errorValue: errorValue,
      data: data,
      option: option,
    );
  }

  static ResultValue<T> fromEmpty<T>() {
    return ResultValue<T>();
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
