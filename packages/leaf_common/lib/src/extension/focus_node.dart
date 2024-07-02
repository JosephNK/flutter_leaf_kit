part of '../lf_common.dart';

class LFExtFocusNode {
  static void removeFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

extension FocusNodeHelper on FocusNode {
  Future<void> ensureVisibleRequestFocus({
    double alignment = 0.5,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
  }) async {
    requestFocus();
    if (context != null) {
      await Scrollable.ensureVisible(
        context!,
        alignment: alignment,
        duration: duration,
        curve: curve,
        alignmentPolicy: alignmentPolicy,
      ).catchError((e) {
        Logging.e('Scrollable ensureVisible Error: e');
      });
    }
  }
}
