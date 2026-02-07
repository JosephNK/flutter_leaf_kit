part of '../index.dart';

extension RemoveMap on Map<String, dynamic> {
  void removeNullEmptyValue() {
    removeWhere((_, dynamic value) => value == null);
  }
}
