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

  static Future<void> showErrorMessage(
    BuildContext context, {
    required String? errorMessage,
    VoidCallback? onTap,
  }) async {
    if (errorMessage == null) return;
    final cancelText = LFComponentConfigure.shared.alert?.cancelText ?? 'Close';
    String? errorTitle = 'Oops! Error :(';
    _LFAlertDialog.show(
      context,
      title: errorTitle,
      message: errorMessage,
      onCancel: onTap,
      cancelText: cancelText,
    );
  }

  static Future<void> showException(
    BuildContext context, {
    Object? exception,
    VoidCallback? onTap,
  }) async {
    if (exception == null) return;
    final cancelText = LFComponentConfigure.shared.alert?.cancelText ?? 'Close';
    String? errorTitle = 'Oops! Exception Error :(';
    String? errorMessage = exception.toString();
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
              child: LFText(
                cancelText,
                style: const TextStyle(fontSize: 18),
              ),
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
              child: LFText(
                cancelText,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (autoPop) {
                  Navigator.maybePop(context);
                  await Future.delayed(const Duration(milliseconds: 100));
                }
                onOK?.call();
              },
              child: LFText(
                okText,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
