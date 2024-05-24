part of '../lf_common.dart';

extension FocusNodeHelper on FocusNode {
  void ensureVisibleRequestFocus({
    double alignment = 0.5,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
  }) {
    requestFocus();
    if (context != null) {
      Scrollable.ensureVisible(
        context!,
        alignment: alignment,
        duration: duration,
        curve: curve,
        alignmentPolicy: alignmentPolicy,
      );
    }
  }
}
