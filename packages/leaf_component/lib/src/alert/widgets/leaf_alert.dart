part of leaf_alert_component;

class LeafAlert {
  static Future<void> show(
    BuildContext context, {
    String? title,
    String? message,
    bool autoPop = true,
    required String cancelText,
    VoidCallback? onCancel,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isEmpty(title)
              ? null
              : LeafText(
                  title ?? '',
                  style: const TextStyle(fontSize: 18),
                  maxLines: 2,
                ),
          content: LeafText(
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
              child: LeafText(cancelText),
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
              : LeafText(
                  title ?? '',
                  style: const TextStyle(fontSize: 18),
                  maxLines: 2,
                ),
          content: LeafText(
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
              child: LeafText(cancelText),
            ),
            TextButton(
              onPressed: () async {
                if (autoPop) {
                  Navigator.maybePop(context);
                  await Future.delayed(const Duration(milliseconds: 100));
                }
                onOK?.call();
              },
              child: LeafText(okText),
            ),
          ],
        );
      },
    );
  }
}
