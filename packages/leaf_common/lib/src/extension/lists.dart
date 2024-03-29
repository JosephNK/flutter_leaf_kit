part of lf_common;

extension SafeLookup<E> on List<E> {
  E? getSafe(int index) {
    try {
      return this[index];
    } on RangeError {
      return null;
    }
  }
}
