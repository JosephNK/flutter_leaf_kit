part of leaf_notification_component;

typedef LeafNotificationOnTap = void Function(Flushbar flushbar);

class LeafNotification {
  static Future<void> show(
    BuildContext context, {
    required String? title,
    required String? message,
    Widget? icon,
    LeafNotificationOnTap? onTap,
  }) async {
    try {
      var flushBar = Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.GROUNDED,
        duration: const Duration(seconds: 4),
        //isDismissible: false,
        title: title,
        message: message,
        icon: icon,
        onTap: onTap,
      );
      await flushBar.show(context);
    } catch (e) {
      Logging.e('LeafNotification Show Error: $e');
    }
  }
}
