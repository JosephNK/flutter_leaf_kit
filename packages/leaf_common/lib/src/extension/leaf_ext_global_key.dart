import 'package:flutter/widgets.dart';

import '../logger/leaf_logging.dart';

extension GlobalKeyHelper on GlobalKey {
  void ensureVisibleScroll({
    Duration delayDuration = const Duration(milliseconds: 250),
    Duration scrollDuration = const Duration(milliseconds: 250),
  }) {
    try {
      final keyContext = currentContext;
      if (keyContext != null) {
        Future.delayed(delayDuration).then((value) {
          if (keyContext.mounted) {
            Scrollable.ensureVisible(keyContext, duration: scrollDuration);
          }
        });
      }
    } catch (e) {
      Logging.e('ensureVisibleScroll Error: $e');
    }
  }
}
