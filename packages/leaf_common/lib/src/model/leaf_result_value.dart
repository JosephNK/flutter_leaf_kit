import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'leaf_error_value.dart';

typedef LeafResultValueOnError =
    Future<void> Function(
      BuildContext context,
      String? errorMessage,
      Object? exception,
    );
typedef LeafResultValueOnErrorMessage =
    Future<void> Function(BuildContext context, String errorMessage);
typedef LeafResultValueOnException =
    Future<void> Function(BuildContext context, Object? exception);
typedef LeafResultValueOnErrorValue =
    Future<void> Function(BuildContext context, LeafErrorValue errorValue);

class LeafResultValue<T> extends Equatable {
  final LeafErrorValue? errorValue;
  final T? data;
  final Object? option;

  const LeafResultValue({this.errorValue, this.data, this.option});

  @override
  List<Object?> get props => [errorValue, data, option];

  bool get empty {
    return errorValue == null && data == null && option == null;
  }

  /// Chain

  Future<LeafResultValue<T>> showIfExistError(
    BuildContext context, {
    LeafResultValueOnError? onError,
  }) async {
    final errorValue = this.errorValue;
    if (errorValue == null || errorValue.errorMessage == null) return this;
    if (context.mounted) {
      final errorMessage = errorValue.errorMessage;
      final exception = errorValue.exception;
      await onError?.call(context, errorMessage, exception);
    }
    return this;
  }

  Future<LeafResultValue<T>> showIfExistErrorMessage(
    BuildContext context, {
    LeafResultValueOnErrorMessage? onErrorMessage,
  }) async {
    final errorValue = this.errorValue;
    if (errorValue == null || errorValue.errorMessage == null) return this;
    if (context.mounted) {
      final errorMessage = errorValue.errorMessage;
      if (errorMessage != null) {
        await onErrorMessage?.call(context, errorMessage);
      }
    }
    return this;
  }

  Future<LeafResultValue<T>> showIfExistExceptionMessage(
    BuildContext context, {
    LeafResultValueOnException? onException,
  }) async {
    final errorValue = this.errorValue;
    if (errorValue == null || errorValue.exception == null) return this;
    if (context.mounted) {
      final exception = errorValue.exception;
      await onException?.call(context, exception);
    }
    return this;
  }

  /// Create

  static LeafResultValue<T> fromValue<T>({
    LeafErrorValue? errorValue,
    T? data,
    Object? option,
  }) {
    return LeafResultValue<T>(
      errorValue: errorValue,
      data: data,
      option: option,
    );
  }

  static LeafResultValue<T> fromSuccess<T>(T? data, {Object? option}) {
    return LeafResultValue<T>(errorValue: null, data: data, option: option);
  }

  static LeafResultValue<T> fromError<T>(
    T? data, {
    required LeafErrorValue? errorValue,
    Object? option,
  }) {
    return LeafResultValue<T>(
      errorValue: errorValue,
      data: data,
      option: option,
    );
  }

  static LeafResultValue<T> fromEmpty<T>() {
    return LeafResultValue<T>();
  }

  /// Helper

  static Future<void> waitForShowErrorValues(
    BuildContext? context,
    List<LeafErrorValue?> errorValues, {
    LeafResultValueOnErrorValue? onErrorValue,
    bool sync = false,
  }) async {
    if (context != null && context.mounted) {
      if (sync) {
        await LeafErrorValue.waitForErrorValues(
          context,
          errorValues: errorValues,
          onWait: (context, errorValue) async {
            await onErrorValue?.call(context, errorValue);
          },
        );
      } else {
        LeafErrorValue.waitForErrorValues(
          context,
          errorValues: errorValues,
          onWait: (context, errorValue) async {
            await onErrorValue?.call(context, errorValue);
          },
        );
      }
    }
  }
}

extension LeafResultValueCopyWith on LeafResultValue {
  LeafResultValue<T> copyWith<T>({
    LeafErrorValue? Function()? errorValue,
    T? Function()? data,
    Object? Function()? option,
  }) {
    return LeafResultValue<T>(
      errorValue: errorValue != null ? errorValue() : this.errorValue,
      data: data != null ? data() : this.data,
      option: option != null ? option() : this.option,
    );
  }
}
