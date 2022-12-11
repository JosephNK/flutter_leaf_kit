part of leaf_alert_component;

class LeafAlertConfigure {
  final String messageOK;
  final String messageClose;

  LeafAlertConfigure({
    required this.messageOK,
    required this.messageClose,
  });
}

class LeafAlert {
  static final LeafAlert _instance = LeafAlert._internal();
  static LeafAlert get shared => _instance;
  LeafAlert._internal();

  static LeafAlertConfigure? get configure => LeafAlert.shared._configure;
  late LeafAlertConfigure _configure;

  void setup({required LeafAlertConfigure configure}) {
    _configure = configure;
  }

  static Future<void> show(
    BuildContext context, {
    String? title,
    String? message,
    VoidCallback? onCancel,
  }) async {
    await LeafBaseAlert.show(
      context,
      title: title,
      message: message,
      onCancel: onCancel,
      cancelText: configure?.messageClose ?? 'Close',
    );
  }

  static Future<void> confirm(
    BuildContext context, {
    String? title,
    String? message,
    Function? onCancel,
    Function? onOK,
  }) async {
    await LeafBaseAlert.confirm(
      context,
      title: title,
      message: message,
      onCancel: onCancel,
      onOK: onOK,
      cancelText: configure?.messageClose ?? 'Close',
      okText: configure?.messageOK ?? 'OK',
    );
  }

  static Future<void> showError(
    BuildContext context, {
    bool success = false,
    String? title,
    String? message,
    dynamic exception,
    VoidCallback? onTap,
  }) async {
    if (success) return;
    String? errorTitle = isNotEmpty(title)
        ? title
        : (exception is LeafHTTPException)
            ? exception.prefix
            : 'Oops!';
    String? errorMessage = isNotEmpty(message) ? message : null;
    errorMessage = errorMessage ?? exception?.toString();
    if (isNotEmpty(errorMessage)) {
      LeafAlert.show(
        context,
        title: errorTitle,
        message: errorMessage,
        onCancel: onTap,
      );
    }
  }
}
