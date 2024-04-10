part of '../lf_common.dart';

extension SafeLookup<E> on List<E> {
  E? getSafe(int index) {
    try {
      return this[index];
    } on RangeError {
      return null;
    }
  }
}
