part of '../lf_common.dart';

extension GlobalKeyHelper on GlobalKey {
  void ensureVisibleScroll({
    Duration delayDuration = const Duration(milliseconds: 250),
    Duration scrollDuration = const Duration(milliseconds: 250),
  }) {
    try {
      final keyContext = currentContext;
      if (keyContext != null) {
        Future.delayed(delayDuration).then((value) {
          Scrollable.ensureVisible(keyContext, duration: scrollDuration);
        });
      }
    } catch (e) {
      Logging.e('ensureVisibleScroll Error: $e');
    }
  }
}
