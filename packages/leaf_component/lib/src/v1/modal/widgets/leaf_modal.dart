part of leaf_modal_component;

class LeafModal {
  static Future<void> show(
    BuildContext context, {
    required Widget child,
    Duration? delay,
  }) async {
    if (delay != null) {
      await Future.delayed(delay);
    }
    // ignore: use_build_context_synchronously
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 250),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return child;
      },
    );
  }
}
