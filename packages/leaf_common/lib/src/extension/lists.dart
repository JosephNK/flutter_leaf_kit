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

extension IterableExt<T> on Iterable<T> {
  Iterable<T> joinSeparator(T separator) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return [];
    final ll = [iterator.current];
    while (iterator.moveNext()) {
      ll
        ..add(separator)
        ..add(iterator.current);
    }
    return ll;
  }
}
