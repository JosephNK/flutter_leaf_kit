part of '../index.dart';

class LeafMessageException implements Exception {
  String message;

  LeafMessageException(this.message);

  @override
  String toString() {
    return message;
  }
}
