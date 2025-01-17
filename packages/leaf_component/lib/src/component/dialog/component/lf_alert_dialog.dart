part of '../dialog.dart';

class LFAlertDialog {
  static final LFAlertDialog _instance = LFAlertDialog._internal();
  static LFAlertDialog get shared => _instance;
  LFAlertDialog._internal();

  static Future<dynamic> show(
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
    return await _LFAlertDialog().show(
      context,
      title: title,
      message: message,
      autoPop: autoPop,
      barrierDismissible: barrierDismissible,
      visibleCloseButton: visibleCloseButton,
      expandableButton: expandableButton,
      titleStyle: titleStyle,
      messageStyle: messageStyle,
      okText: okText,
      okTextStyle: okTextStyle,
      okTextBackgroundColor: okTextBackgroundColor,
      okTextBorderColor: okTextBorderColor,
      okTextPadding: okTextPadding,
      onOK: onOK,
    );
  }

  static Future<dynamic> confirm(
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
    return await _LFAlertDialog().confirm(
      context,
      title: title,
      message: message,
      autoPop: autoPop,
      barrierDismissible: barrierDismissible,
      titleStyle: titleStyle,
      messageStyle: messageStyle,
      okText: okText,
      okTextStyle: okTextStyle,
      okTextBackgroundColor: okTextBackgroundColor,
      okTextBorderColor: okTextBorderColor,
      okTextPadding: okTextPadding,
      cancelText: cancelText,
      cancelTextStyle: cancelTextStyle,
      cancelTextBackgroundColor: cancelTextBackgroundColor,
      cancelTextBorderColor: cancelTextBorderColor,
      cancelTextPadding: cancelTextPadding,
      onCancel: onCancel,
      onOK: onOK,
    );
  }

  static Future<dynamic> showErrorMessage(
    BuildContext context, {
    required String? errorMessage,
    bool barrierDismissible = true,
    String? okText,
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    VoidCallback? onOk,
  }) async {
    if (isEmpty(errorMessage)) return;

    final errorTitleStr =
        LFComponentConfigure.shared.alert?.errorMessageTitle ??
            'Oops! Error :(';

    String? errorMessageStr = errorMessage;

    if (isNotEmpty(errorMessageStr) && errorMessageStr != null) {
      return await _LFAlertDialog().show(
        context,
        title: errorTitleStr,
        message: errorMessageStr,
        barrierDismissible: barrierDismissible,
        onOK: onOk,
        okText: okText,
        okTextStyle: okTextStyle,
        okTextBackgroundColor: okTextBackgroundColor,
        okTextBorderColor: okTextBorderColor,
        okTextPadding: okTextPadding,
      );
    }

    return null;
  }

  static Future<dynamic> showException(
    BuildContext context, {
    Object? exception,
    bool barrierDismissible = true,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    String? okText,
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    VoidCallback? onTap,
  }) async {
    if (exception == null) return;

    final errorTitleStr =
        LFComponentConfigure.shared.alert?.errorMessageTitle ??
            'Oops! Exception :(';

    String errorMessageStr = exception.toString();

    if (isNotEmpty(errorMessageStr)) {
      return await _LFAlertDialog().show(
        context,
        title: errorTitleStr,
        message: errorMessageStr,
        barrierDismissible: barrierDismissible,
        titleStyle: titleStyle,
        messageStyle: messageStyle,
        okText: okText,
        okTextStyle: okTextStyle,
        okTextBackgroundColor: okTextBackgroundColor,
        okTextBorderColor: okTextBorderColor,
        okTextPadding: okTextPadding,
        onOK: onTap,
      );
    }

    return null;
  }
}

class _LFAlertDialog {
  Future<dynamic> show(
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
    return await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        late Widget titleWidget, messageWidget;

        if (visibleCloseButton) {
          titleWidget = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24.0),
                    LFDialogTitle(
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
                    Navigator.of(context).pop();
                  }
                },
                child: const Icon(LucideIcons.x, size: 24.0),
              ),
            ],
          );
        } else {
          titleWidget = LFDialogTitle(
            text: title,
            textStyle: titleStyle,
          );
        }

        messageWidget = LFDialogMessage(
          text: message,
          textStyle: messageStyle,
        );

        final borderRadius = LFComponentConfigure.shared.alert?.borderRadius;

        return AlertDialog(
          title: isEmpty(title) ? null : titleWidget,
          content: messageWidget,
          actionsPadding:
              const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          shape: (borderRadius != null)
              ? RoundedRectangleBorder(borderRadius: borderRadius)
              : null,
          actions: [
            if (expandableButton) ...[
              Row(
                children: [
                  Expanded(
                    child: LFDialogOKButton(
                      autoPop: autoPop,
                      text: okText,
                      textStyle: okTextStyle,
                      backgroundColor: okTextBackgroundColor,
                      borderColor: okTextBorderColor,
                      padding: okTextPadding,
                      onPressed: onOK,
                    ),
                  ),
                ],
              )
            ] else ...[
              LFDialogOKButton(
                autoPop: autoPop,
                text: okText,
                textStyle: okTextStyle,
                backgroundColor: okTextBackgroundColor,
                borderColor: okTextBorderColor,
                padding: okTextPadding,
                onPressed: onOK,
              ),
            ],
          ],
        );
      },
    );
  }

  Future<dynamic> confirm(
    BuildContext context, {
    String? title,
    required String message,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    bool autoPop = true,
    bool barrierDismissible = true,
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
    late Widget titleWidget, messageWidget;

    titleWidget = LFDialogTitle(
      text: title,
      textStyle: titleStyle,
    );

    messageWidget = LFDialogMessage(
      text: message,
      textStyle: messageStyle,
    );

    final borderRadius = LFComponentConfigure.shared.alert?.borderRadius;

    return await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isEmpty(title) ? null : titleWidget,
          content: messageWidget,
          actionsPadding:
              const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          shape: (borderRadius != null)
              ? RoundedRectangleBorder(borderRadius: borderRadius)
              : null,
          actions: [
            LFDialogCancelButton(
              autoPop: autoPop,
              text: cancelText,
              textStyle: cancelTextStyle,
              backgroundColor: cancelTextBackgroundColor,
              borderColor: cancelTextBorderColor,
              padding: cancelTextPadding,
              onPressed: onCancel,
            ),
            LFDialogOKButton(
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
}
