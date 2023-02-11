part of lf_dialog;

class LFAlertDialog {
  static final LFAlertDialog _instance = LFAlertDialog._internal();
  static LFAlertDialog get shared => _instance;
  LFAlertDialog._internal();

  static Future<void> show(
    BuildContext context, {
    String? title,
    required String message,
    VoidCallback? onCancel,
  }) async {
    final cancelText = LFComponentConfigure.shared.alert?.cancelText ?? 'Close';

    await _LFAlertDialog.show(
      context,
      title: title,
      message: message,
      onCancel: onCancel,
      cancelText: cancelText,
    );
  }

  static Future<void> confirm(
    BuildContext context, {
    String? title,
    required String message,
    Function? onCancel,
    Function? onOK,
  }) async {
    final cancelText = LFComponentConfigure.shared.alert?.cancelText ?? 'Close';
    final okText = LFComponentConfigure.shared.alert?.okText ?? 'OK';

    await _LFAlertDialog.confirm(
      context,
      title: title,
      message: message,
      onCancel: onCancel,
      onOK: onOK,
      cancelText: cancelText,
      okText: okText,
    );
  }

  static Future<void> showException(
    BuildContext context, {
    bool success = false,
    String? title,
    String? message,
    dynamic exception,
    VoidCallback? onTap,
  }) async {
    if (success) return;
    final cancelText = LFComponentConfigure.shared.alert?.cancelText ?? 'Close';
    String? errorTitle = isNotEmpty(title)
        ? title
        : (exception is HTTPException)
            ? exception.message
            : 'Oops!';
    String? errorMessage = isNotEmpty(message) ? message : null;
    errorMessage = errorMessage ?? exception?.toString();
    if (isNotEmpty(errorMessage)) {
      _LFAlertDialog.show(
        context,
        title: errorTitle,
        message: errorMessage,
        onCancel: onTap,
        cancelText: cancelText,
      );
    }
  }
}

class _LFAlertDialog {
  static Future<void> show(
    BuildContext context, {
    String? title,
    String? message,
    required String cancelText,
    VoidCallback? onCancel,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isEmpty(title)
              ? null
              : LFText(
                  title ?? '',
                  style: const TextStyle(fontSize: 18),
                  maxLines: 2,
                ),
          content: LFText(
            message ?? '',
            style: const TextStyle(fontSize: 16),
            maxLines: 5,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.maybePop(context);
                await Future.delayed(const Duration(milliseconds: 100));
                onCancel?.call();
              },
              child: LFText(cancelText),
            ),
          ],
        );
      },
    );
  }

  static Future<void> confirm(
    BuildContext context, {
    String? title,
    String? message,
    bool autoPop = true,
    required String okText,
    required String cancelText,
    Function? onCancel,
    Function? onOK,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isEmpty(title)
              ? null
              : LFText(
                  title ?? '',
                  style: const TextStyle(fontSize: 18),
                  maxLines: 2,
                ),
          content: LFText(
            message ?? '',
            style: const TextStyle(fontSize: 16),
            maxLines: 5,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (autoPop) {
                  Navigator.maybePop(context);
                  await Future.delayed(const Duration(milliseconds: 100));
                }
                onCancel?.call();
              },
              child: LFText(cancelText),
            ),
            TextButton(
              onPressed: () async {
                if (autoPop) {
                  Navigator.maybePop(context);
                  await Future.delayed(const Duration(milliseconds: 100));
                }
                onOK?.call();
              },
              child: LFText(okText),
            ),
          ],
        );
      },
    );
  }
}
