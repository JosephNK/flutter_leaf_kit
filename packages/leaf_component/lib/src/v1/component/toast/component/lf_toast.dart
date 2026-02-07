part of '../toast.dart';

@Deprecated('Use LFToastV2 instead.')
class LFToast {
  static Future<bool?> showToast(
    BuildContext context, {
    required String message,
    LFToastType toastType = LFToastType.lengthShort,
    LFToastGravityType toastGravityType = LFToastGravityType.bottom,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) async {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: toastType.value,
      gravity: toastGravityType.value,
      backgroundColor: backgroundColor ?? Colors.black87,
      textColor: textStyle?.color ?? Colors.white,
      fontSize: textStyle?.fontSize ?? 16.0,
    );
  }

  static ToastificationItem showNotification(
    BuildContext context, {
    required String message,
    String? description,
    LFToastNotificationType? type,
    LFToastNotificationStyle? style,
    Alignment? alignment,
    Duration? duration,
    Color? backgroundColor,
    TextStyle? textStyle,
    TextStyle? descriptionTextStyle,
    BorderRadiusGeometry? borderRadius,
    BorderSide? borderSide,
    bool closeOnClick = true,
    bool dragToClose = true,
    bool? showIcon,
  }) {
    Color? defaultBackgroundColor = backgroundColor;
    TextStyle? defaultTextStyle = textStyle;
    if (style == LFToastNotificationStyle.simple) {
      defaultBackgroundColor = backgroundColor ?? Colors.black;
      defaultTextStyle = textStyle ?? const TextStyle(color: Colors.white);
    }

    return Toastification().show(
      context: context,
      title: Text(message, style: defaultTextStyle),
      description: (description != null)
          ? Text(description, style: descriptionTextStyle)
          : null,
      type: type?.value ?? LFToastNotificationType.success.value,
      style: style?.value ?? LFToastNotificationStyle.flat.value,
      alignment: alignment ?? Alignment.topCenter,
      backgroundColor: defaultBackgroundColor,
      borderRadius: borderRadius,
      borderSide: borderSide,
      autoCloseDuration: duration ?? const Duration(seconds: 5),
      showProgressBar: false,
      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.onHover,
        buttonBuilder: (context, onClose) {
          return OutlinedButton.icon(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            label: const Text('Close'),
          );
        },
      ),
      closeOnClick: closeOnClick,
      dragToClose: dragToClose,
      showIcon: showIcon,
    );
  }
}
