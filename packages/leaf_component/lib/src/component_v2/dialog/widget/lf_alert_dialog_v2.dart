import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'lf_dialog_button_v2.dart';
import 'lf_dialog_message_v2.dart';
import 'lf_dialog_title_v2.dart';

/// A themed alert dialog with static [show] and [confirm] methods.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LFDialogThemeData] from the nearest [LFTheme]
///   3. Global tokens / hardcoded defaults
class LFAlertDialogV2 {
  const LFAlertDialogV2._();

  /// Shows an alert dialog with a single OK button.
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required String message,
    bool autoPop = true,
    bool barrierDismissible = true,
    bool visibleCloseButton = false,
    bool expandableButton = false,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    String? okText,
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    VoidCallback? onOK,
  }) async {
    final theme = LFTheme.of(context);
    final dialogTheme = theme.dialogTheme;
    final resolvedBorderRadius = dialogTheme?.borderRadius;

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext ctx) {
        Widget? titleWidget;
        if (title != null && title.isNotEmpty) {
          if (visibleCloseButton) {
            titleWidget = Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24.0),
                      LFDialogTitleV2(
                        text: title,
                        textStyle: titleStyle,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (autoPop) {
                      Navigator.of(ctx).pop();
                    }
                  },
                  child: const Icon(Icons.close, size: 24.0),
                ),
              ],
            );
          } else {
            titleWidget = LFDialogTitleV2(
              text: title,
              textStyle: titleStyle,
            );
          }
        }

        final messageWidget = LFDialogMessageV2(
          text: message,
          textStyle: messageStyle,
        );

        final okButton = LFDialogOKButtonV2(
          autoPop: autoPop,
          text: okText,
          textStyle: okTextStyle,
          backgroundColor: okTextBackgroundColor,
          borderColor: okTextBorderColor,
          padding: okTextPadding,
          onPressed: onOK,
        );

        return Semantics(
          label: 'Alert dialog',
          child: AlertDialog(
            title: titleWidget,
            content: messageWidget,
            actionsPadding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            shape: resolvedBorderRadius != null
                ? RoundedRectangleBorder(borderRadius: resolvedBorderRadius)
                : null,
            actions: [
              if (expandableButton)
                Row(
                  children: [Expanded(child: okButton)],
                )
              else
                okButton,
            ],
          ),
        );
      },
    );
  }

  /// Shows a confirmation dialog with Cancel and OK buttons.
  static Future<T?> confirm<T>(
    BuildContext context, {
    String? title,
    required String message,
    bool autoPop = true,
    bool barrierDismissible = true,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    String? okText,
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    String? cancelText,
    TextStyle? cancelTextStyle,
    Color? cancelTextBackgroundColor,
    Color? cancelTextBorderColor,
    EdgeInsets? cancelTextPadding,
    VoidCallback? onCancel,
    VoidCallback? onOK,
  }) async {
    final theme = LFTheme.of(context);
    final dialogTheme = theme.dialogTheme;
    final resolvedBorderRadius = dialogTheme?.borderRadius;

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext ctx) {
        Widget? titleWidget;
        if (title != null && title.isNotEmpty) {
          titleWidget = LFDialogTitleV2(
            text: title,
            textStyle: titleStyle,
          );
        }

        final messageWidget = LFDialogMessageV2(
          text: message,
          textStyle: messageStyle,
        );

        return Semantics(
          label: 'Confirmation dialog',
          child: AlertDialog(
            title: titleWidget,
            content: messageWidget,
            actionsPadding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            shape: resolvedBorderRadius != null
                ? RoundedRectangleBorder(borderRadius: resolvedBorderRadius)
                : null,
            actions: [
              LFDialogCancelButtonV2(
                autoPop: autoPop,
                text: cancelText,
                textStyle: cancelTextStyle,
                backgroundColor: cancelTextBackgroundColor,
                borderColor: cancelTextBorderColor,
                padding: cancelTextPadding,
                onPressed: onCancel,
              ),
              LFDialogOKButtonV2(
                autoPop: autoPop,
                text: okText,
                textStyle: okTextStyle,
                backgroundColor: okTextBackgroundColor,
                borderColor: okTextBorderColor,
                padding: okTextPadding,
                onPressed: onOK,
              ),
            ],
          ),
        );
      },
    );
  }
}
