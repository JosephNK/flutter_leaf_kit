import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

const kDefaultStatusCode = -9999;

class LeafErrorValueException implements Exception {
  LeafErrorValue value;

  LeafErrorValueException(this.value);

  @override
  String toString() {
    return 'LeafErrorValueException: ${value.toJson()}';
  }
}

///////////////////////////////////////////////////////////////////////////////

typedef LeafErrorValueOnWait = Future<void> Function(
    BuildContext context, LeafErrorValue errorValue);

class LeafErrorValue extends Equatable {
  final int statusCode;
  final String? errorCode;
  final String? errorMessage;
  final Object? exception;

  const LeafErrorValue({
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

  LeafErrorValueException get objectToException {
    return LeafErrorValueException(this);
  }

  /// Create

  factory LeafErrorValue.empty() {
    return const LeafErrorValue(
      statusCode: kDefaultStatusCode,
      errorCode: null,
      errorMessage: null,
      exception: null,
    );
  }

  factory LeafErrorValue.fromException({
    dynamic exception,
    String? errorCode,
  }) {
    if (exception is LeafErrorValue) {
      return exception;
    }
    final errorMessage =
        (exception != null) ? exception.toString() : 'Unknown Exception';
    return LeafErrorValue(
      statusCode: kDefaultStatusCode,
      errorCode: errorCode,
      errorMessage: errorMessage,
      exception: exception,
    );
  }

  factory LeafErrorValue.fromErrorMessage(
    String errorMessage, {
    String? errorCode,
  }) {
    return LeafErrorValue(
      statusCode: kDefaultStatusCode,
      errorCode: errorCode,
      errorMessage: errorMessage,
      exception: null,
    );
  }

  /// Utils

  static LeafErrorValue? getFirstErrorValues(List<LeafErrorValue?> errorValues) {
    final errorValue1s = errorValues.nonNulls.toList();
    return errorValue1s.firstOrNull;
  }

  static LeafErrorValue? getLastErrorValues(List<LeafErrorValue?> errorValues) {
    final errorValue1s = errorValues.nonNulls.toList();
    return errorValue1s.lastOrNull;
  }

  static Future<void> waitForErrorValues(
    BuildContext context, {
    required List<LeafErrorValue?> errorValues,
    LeafErrorValueOnWait? onWait,
  }) async {
    final errorValue1s = errorValues.nonNulls.toList();
    await Future.forEach<LeafErrorValue>(errorValue1s, (errorValue) async {
      if (context.mounted) {
        await onWait?.call(context, errorValue);
      }
    });
  }
}

extension LeafErrorValueCopyWith on LeafErrorValue {
  LeafErrorValue copyWith({
    int Function()? statusCode,
    String? Function()? errorCode,
    String? Function()? errorMessage,
    Object? Function()? exception,
  }) {
    return LeafErrorValue(
      statusCode: statusCode != null ? statusCode() : this.statusCode,
      errorCode: errorCode != null ? errorCode() : this.errorCode,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      exception: exception != null ? exception() : this.exception,
    );
  }
}
