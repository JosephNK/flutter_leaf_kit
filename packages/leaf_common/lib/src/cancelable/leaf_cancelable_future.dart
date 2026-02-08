// https://stackoverflow.com/questions/66380613/how-to-make-a-delayed-future-cancelable-in-dart

class LeafCancelableFuture<T> {
  bool _cancelled = false;
  LeafCancelableFuture({
    required Future<dynamic> future,
    required void Function(T) onComplete,
  }) {
    future.then((value) {
      if (!_cancelled) onComplete(value);
    });
  }
  void cancel() {
    _cancelled = true;
  }
}
