part of '../lf_dialog.dart';

class LFAlertDialog {
  static final LFAlertDialog _instance = LFAlertDialog._internal();
  static LFAlertDialog get shared => _instance;
  LFAlertDialog._internal();

  static Future<void> show(
    BuildContext context, {
    String? title,
    required String message,
    bool autoPop = true,
    String? okText,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    VoidCallback? onOK,
  }) async {
    final okTextStr =
        okText ?? LFComponentConfigure.shared.alert?.okText ?? 'OK';

    final titleStyleValue =
        titleStyle ?? LFComponentConfigure.shared.alert?.titleStyle;
    final messageStyleValue =
        messageStyle ?? LFComponentConfigure.shared.alert?.messageStyle;
    final okTextStyleValue = LFComponentConfigure.shared.alert?.okTextStyle;
    final okTextBackgroundColorValue =
        LFComponentConfigure.shared.alert?.okTextBackgroundColor;
    final okTextBorderColor =
        LFComponentConfigure.shared.alert?.okTextBorderColor;
    final buttonPadding = LFComponentConfigure.shared.alert?.buttonPadding;

    await _LFAlertDialog().show(
      context,
      title: title,
      message: message,
      autoPop: autoPop,
      titleStyle: titleStyleValue,
      messageStyle: messageStyleValue,
      onOK: onOK,
      okText: okTextStr,
      okTextStyle: okTextStyleValue,
      okTextBackgroundColor: okTextBackgroundColorValue,
      okTextBorderColor: okTextBorderColor,
      okTextPadding: buttonPadding,
    );
  }

  static Future<void> confirm(
    BuildContext context, {
    String? title,
    required String message,
    bool autoPop = true,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    String? okText,
    VoidCallback? onCancel,
    VoidCallback? onOK,
  }) async {
    final cancelTextStr =
        LFComponentConfigure.shared.alert?.cancelText ?? 'Close';
    final okTextStr =
        okText ?? LFComponentConfigure.shared.alert?.okText ?? 'OK';

    final titleStyleValue =
        titleStyle ?? LFComponentConfigure.shared.alert?.titleStyle;
    final messageStyleValue =
        messageStyle ?? LFComponentConfigure.shared.alert?.messageStyle;
    final okTextStyleValue = LFComponentConfigure.shared.alert?.okTextStyle;
    final okTextBackgroundColorValue =
        LFComponentConfigure.shared.alert?.okTextBackgroundColor;
    final okTextBorderColor =
        LFComponentConfigure.shared.alert?.okTextBorderColor;
    final cancelTextStyleValue =
        LFComponentConfigure.shared.alert?.cancelTextStyle;
    final cancelTextBackgroundColorValue =
        LFComponentConfigure.shared.alert?.cancelTextBackgroundColor;
    final cancelTextBorderColor =
        LFComponentConfigure.shared.alert?.cancelTextBorderColor;
    final buttonPadding = LFComponentConfigure.shared.alert?.buttonPadding;

    await _LFAlertDialog().confirm(
      context,
      title: title,
      message: message,
      autoPop: autoPop,
      titleStyle: titleStyleValue,
      messageStyle: messageStyleValue,
      onCancel: onCancel,
      onOK: onOK,
      okTextStyle: okTextStyleValue,
      okTextBackgroundColor: okTextBackgroundColorValue,
      okTextBorderColor: okTextBorderColor,
      okTextPadding: buttonPadding,
      okText: okTextStr,
      cancelTextStyle: cancelTextStyleValue,
      cancelTextBackgroundColor: cancelTextBackgroundColorValue,
      cancelTextBorderColor: cancelTextBorderColor,
      cancelTextPadding: buttonPadding,
      cancelText: cancelTextStr,
    );
  }

  static Future<void> showErrorMessage(
    BuildContext context, {
    required String? errorMessage,
    VoidCallback? onOk,
  }) async {
    if (isEmpty(errorMessage)) return;

    final okTextStr = LFComponentConfigure.shared.alert?.okText ?? 'OK';
    final okTextStyle = LFComponentConfigure.shared.alert?.okTextStyle;
    final okTextBackgroundColor =
        LFComponentConfigure.shared.alert?.okTextBackgroundColor;
    final okTextBorderColor =
        LFComponentConfigure.shared.alert?.okTextBorderColor;
    final buttonPadding = LFComponentConfigure.shared.alert?.buttonPadding;

    final errorTitleStr =
        LFComponentConfigure.shared.alert?.errorMessageTitle ??
            'Oops! Error :(';

    String errorMessageStr = errorMessage!;

    await _LFAlertDialog().show(
      context,
      title: errorTitleStr,
      message: errorMessageStr,
      onOK: onOk,
      okText: okTextStr,
      okTextStyle: okTextStyle,
      okTextBackgroundColor: okTextBackgroundColor,
      okTextBorderColor: okTextBorderColor,
      okTextPadding: buttonPadding,
    );
  }

  static Future<void> showException(
    BuildContext context, {
    Object? exception,
    VoidCallback? onTap,
  }) async {
    if (exception == null) return;

    final okTextStr = LFComponentConfigure.shared.alert?.okText ?? 'Close';
    final okTextStyle = LFComponentConfigure.shared.alert?.okTextStyle;
    final okTextBackgroundColor =
        LFComponentConfigure.shared.alert?.okTextBackgroundColor;
    final okTextBorderColor =
        LFComponentConfigure.shared.alert?.okTextBorderColor;
    final buttonPadding = LFComponentConfigure.shared.alert?.buttonPadding;

    final errorTitleStr =
        LFComponentConfigure.shared.alert?.errorMessageTitle ??
            'Oops! Exception :(';

    String errorMessageStr = exception.toString();

    if (isNotEmpty(errorMessageStr)) {
      await _LFAlertDialog().show(
        context,
        title: errorTitleStr,
        message: errorMessageStr,
        onOK: onTap,
        okText: okTextStr,
        okTextStyle: okTextStyle,
        okTextBackgroundColor: okTextBackgroundColor,
        okTextBorderColor: okTextBorderColor,
        okTextPadding: buttonPadding,
      );
    }
  }
}

class _LFAlertDialog {
  Future<void> show(
    BuildContext context, {
    String? title,
    String? message,
    bool autoPop = true,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    String okText = 'OK',
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    VoidCallback? onOK,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isEmpty(title)
              ? null
              : _buildTitle(context, text: title, textStyle: titleStyle),
          content:
              _buildMessage(context, text: message, textStyle: messageStyle),
          actions: [
            _buildOKButton(
              context,
              autoPop: autoPop,
              text: okText,
              textStyle: okTextStyle,
              backgroundColor: okTextBackgroundColor,
              borderColor: okTextBorderColor,
              padding: okTextPadding,
              onPressed: onOK,
            ),
          ],
        );
      },
    );
  }

  Future<void> confirm(
    BuildContext context, {
    String? title,
    String? message,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    bool autoPop = true,
    String okText = 'OK',
    String cancelText = 'Cancel',
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    TextStyle? cancelTextStyle,
    Color? cancelTextBackgroundColor,
    Color? cancelTextBorderColor,
    EdgeInsets? cancelTextPadding,
    VoidCallback? onCancel,
    VoidCallback? onOK,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isEmpty(title)
              ? null
              : _buildTitle(context, text: title, textStyle: titleStyle),
          content:
              _buildMessage(context, text: message, textStyle: messageStyle),
          actions: [
            _buildCancelButton(
              context,
              autoPop: autoPop,
              text: cancelText,
              textStyle: cancelTextStyle,
              backgroundColor: cancelTextBackgroundColor,
              borderColor: cancelTextBorderColor,
              padding: cancelTextPadding,
              onPressed: onCancel,
            ),
            _buildOKButton(
              context,
              autoPop: autoPop,
              text: okText,
              textStyle: okTextStyle,
              backgroundColor: okTextBackgroundColor,
              padding: okTextPadding,
              onPressed: onOK,
            ),
          ],
        );
      },
    );
  }

  /// Title Widget
  Widget _buildTitle(
    BuildContext context, {
    String? text = 'Title',
    TextStyle? textStyle,
  }) {
    return LFText(
      text ?? '',
      style: textStyle ?? const TextStyle(fontSize: 18),
      maxLines: 2,
    );
  }

  /// Message Widget
  Widget _buildMessage(
    BuildContext context, {
    String? text = 'Message',
    TextStyle? textStyle,
  }) {
    return LFText(
      text ?? '',
      style: textStyle ?? const TextStyle(fontSize: 16),
      maxLines: 5,
    );
  }

  /// Cancel Button Widget
  Widget _buildCancelButton(
    BuildContext context, {
    bool autoPop = true,
    String text = 'Cancel',
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? borderColor,
    EdgeInsets? padding,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: () async {
        if (autoPop) {
          Navigator.maybePop(context, 'CANCEL');
          await Future.delayed(const Duration(milliseconds: 100));
        }
        onPressed?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: borderColor != null ? Border.all(color: borderColor) : null,
          color: backgroundColor ?? Colors.grey.withOpacity(0.5),
        ),
        margin: const EdgeInsets.all(8.0),
        padding: padding ??
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: LFText(
          text,
          style: textStyle ?? const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  /// OK Button Widget
  Widget _buildOKButton(
    BuildContext context, {
    bool autoPop = true,
    String text = 'OK',
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? borderColor,
    EdgeInsets? padding,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: () async {
        if (autoPop) {
          Navigator.maybePop(context, 'OK');
          await Future.delayed(const Duration(milliseconds: 100));
        }
        onPressed?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: borderColor != null ? Border.all(color: borderColor) : null,
          color: backgroundColor ?? Colors.blueAccent,
        ),
        margin: const EdgeInsets.all(8.0),
        padding: padding ??
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: LFText(
          text,
          style: textStyle ?? const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
