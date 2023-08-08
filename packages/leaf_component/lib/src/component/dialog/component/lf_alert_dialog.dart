part of lf_dialog;

class LFAlertDialog {
  static final LFAlertDialog _instance = LFAlertDialog._internal();
  static LFAlertDialog get shared => _instance;
  LFAlertDialog._internal();

  static Future<void> show(
    BuildContext context, {
    String? title,
    required String message,
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

    await _LFAlertDialog().show(
      context,
      title: title,
      message: message,
      titleStyle: titleStyleValue,
      messageStyle: messageStyleValue,
      onOK: onOK,
      okText: okTextStr,
      okTextStyle: okTextStyleValue,
      okTextBackgroundColor: okTextBackgroundColorValue,
    );
  }

  static Future<void> confirm(
    BuildContext context, {
    String? title,
    required String message,
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
    final cancelTextStyleValue =
        LFComponentConfigure.shared.alert?.cancelTextStyle;
    final cancelTextBackgroundColorValue =
        LFComponentConfigure.shared.alert?.cancelTextBackgroundColor;

    await _LFAlertDialog().confirm(
      context,
      title: title,
      message: message,
      titleStyle: titleStyleValue,
      messageStyle: messageStyleValue,
      onCancel: onCancel,
      onOK: onOK,
      okTextStyle: okTextStyleValue,
      okTextBackgroundColor: okTextBackgroundColorValue,
      okText: okTextStr,
      cancelTextStyle: cancelTextStyleValue,
      cancelTextBackgroundColor: cancelTextBackgroundColorValue,
      cancelText: cancelTextStr,
    );
  }

  static Future<void> showErrorMessage(
    BuildContext context, {
    required String? errorMessage,
    VoidCallback? onOk,
  }) async {
    if (errorMessage == null) return;

    final okTextStr = LFComponentConfigure.shared.alert?.okText ?? 'OK';
    final okTextStyle = LFComponentConfigure.shared.alert?.okTextStyle;
    final okTextBackgroundColor =
        LFComponentConfigure.shared.alert?.okTextBackgroundColor;
    final errorTitleStr =
        LFComponentConfigure.shared.alert?.errorMessageTitle ??
            'Oops! Error :(';

    String errorMessageStr = errorMessage;

    _LFAlertDialog().show(
      context,
      title: errorTitleStr,
      message: errorMessageStr,
      onOK: onOk,
      okText: okTextStr,
      okTextStyle: okTextStyle,
      okTextBackgroundColor: okTextBackgroundColor,
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

    String title = 'Oops! Exception :(';
    String message = exception.toString();

    if (isNotEmpty(message)) {
      _LFAlertDialog().show(
        context,
        title: title,
        message: message,
        onOK: onTap,
        okText: okTextStr,
        okTextStyle: okTextStyle,
        okTextBackgroundColor: okTextBackgroundColor,
      );
    }
  }
}

class _LFAlertDialog {
  Future<void> show(
    BuildContext context, {
    String? title,
    String? message,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    String okText = 'OK',
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
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
            _buildOKButton(context,
                autoPop: true,
                text: okText,
                textStyle: okTextStyle,
                backgroundColor: okTextBackgroundColor,
                onPressed: onOK),
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
    TextStyle? cancelTextStyle,
    Color? cancelTextBackgroundColor,
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
            _buildCancelButton(context,
                autoPop: autoPop,
                text: cancelText,
                textStyle: cancelTextStyle,
                backgroundColor: cancelTextBackgroundColor,
                onPressed: onCancel),
            _buildOKButton(context,
                autoPop: autoPop,
                text: okText,
                textStyle: okTextStyle,
                backgroundColor: okTextBackgroundColor,
                onPressed: onOK),
          ],
        );
      },
    );
  }

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

  Widget _buildCancelButton(
    BuildContext context, {
    bool autoPop = true,
    String text = 'Cancel',
    TextStyle? textStyle,
    Color? backgroundColor,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: () async {
        if (autoPop) {
          Navigator.maybePop(context);
          await Future.delayed(const Duration(milliseconds: 100));
        }
        onPressed?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor ?? Colors.grey.withOpacity(0.5),
        ),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: LFText(
          text,
          style: textStyle ?? const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildOKButton(
    BuildContext context, {
    bool autoPop = true,
    String text = 'OK',
    TextStyle? textStyle,
    Color? backgroundColor,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: () async {
        if (autoPop) {
          Navigator.maybePop(context);
          await Future.delayed(const Duration(milliseconds: 100));
        }
        onPressed?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor ?? Colors.blueAccent,
        ),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: LFText(
          text,
          style: textStyle ?? const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
