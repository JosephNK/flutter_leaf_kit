part of '../lf_common.dart';

class LFMessageException implements Exception {
  String message;

  LFMessageException(this.message);

  @override
  String toString() {
    return message;
  }
}
