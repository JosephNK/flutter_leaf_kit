import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

import '../../../../common/theme/theme.dart';
import '../type/lf_toast_type_v2.dart';

/// A themed toast utility for showing brief messages and notifications.
///
/// Provides two methods:
/// - [showToast]: simple platform toast via fluttertoast
/// - [showNotification]: rich notification via toastification
///
/// Style resolution order:
///   1. Explicit parameters ([backgroundColor], [textStyle])
///   2. [LFToastThemeData] from the nearest [LFTheme]
///   3. Hardcoded defaults
class LFToastV2 {
  const LFToastV2._();

  /// Shows a simple platform toast message.
  static Future<bool?> showToast(
    BuildContext context, {
    required String message,
    LFToastTypeV2 toastType = LFToastTypeV2.lengthShort,
    LFToastGravityTypeV2 gravity = LFToastGravityTypeV2.bottom,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) async {
    final theme = LFTheme.of(context);
    final componentTheme = theme.toastTheme;

    final resolvedBg =
        backgroundColor ?? componentTheme?.backgroundColor ?? Colors.black87;
    final resolvedTextStyle = textStyle ?? componentTheme?.textStyle;

    return Fluttertoast.showToast(
      msg: message,
      toastLength: toastType.value,
      gravity: gravity.value,
      backgroundColor: resolvedBg,
      textColor: resolvedTextStyle?.color ?? Colors.white,
      fontSize: resolvedTextStyle?.fontSize ?? 16.0,
    );
  }

  /// Shows a rich notification-style toast via toastification.
  static ToastificationItem showNotification(
    BuildContext context, {
    required String message,
    String? description,
    LFToastNotificationTypeV2? type,
    LFToastNotificationStyleV2? style,
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
    final theme = LFTheme.of(context);
    final componentTheme = theme.toastTheme;

    final resolvedStyle = style ?? LFToastNotificationStyleV2.flat;
    final resolvedBorderRadius =
        borderRadius ?? componentTheme?.borderRadius;

    Color? resolvedBg = backgroundColor ?? componentTheme?.backgroundColor;
    TextStyle? resolvedTextStyle = textStyle ?? componentTheme?.textStyle;

    if (resolvedStyle == LFToastNotificationStyleV2.simple) {
      resolvedBg ??= Colors.black;
      resolvedTextStyle ??= const TextStyle(color: Colors.white);
    }

    final resolvedDescStyle =
        descriptionTextStyle ?? componentTheme?.descriptionTextStyle;

    return Toastification().show(
      context: context,
      title: Text(message, style: resolvedTextStyle),
      description: description != null
          ? Text(description, style: resolvedDescStyle)
          : null,
      type: type?.value ?? LFToastNotificationTypeV2.success.value,
      style: resolvedStyle.value,
      alignment: alignment ?? Alignment.topCenter,
      backgroundColor: resolvedBg,
      borderRadius: resolvedBorderRadius,
      borderSide: borderSide,
      autoCloseDuration: duration ?? const Duration(seconds: 5),
      showProgressBar: false,
      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.onHover,
        buttonBuilder: (_, onClose) {
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
