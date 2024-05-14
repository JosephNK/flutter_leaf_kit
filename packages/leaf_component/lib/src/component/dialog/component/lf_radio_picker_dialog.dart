part of '../dialog.dart';

/// CustomDialog
/// https://medium.com/@excogitatr/custom-dialog-in-flutter-d00e0441f1d5
///

class LFRadioPickerDialog {
  static Future confirm(
    BuildContext context, {
    required List<LFDataItem> items,
    required LFDataItem value,
    String? title,
    String? message,
    bool autoPop = true,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    String? okText,
    VoidCallback? onCancel,
    ValueChanged<LFDataItem>? onOK,
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

    return await showDialog(
      context: context,
      builder: (context) {
        return _RadioPickerContent(
          items: items,
          value: value,
          title: title,
          message: message,
          titleStyle: titleStyleValue,
          messageStyle: messageStyleValue,
          autoPop: autoPop,
          okTextStyle: okTextStyleValue,
          okTextBackgroundColor: okTextBackgroundColorValue,
          okText: okTextStr,
          cancelTextStyle: cancelTextStyleValue,
          cancelTextBackgroundColor: cancelTextBackgroundColorValue,
          cancelText: cancelTextStr,
          onCancel: onCancel,
          onOK: onOK,
        );
      },
    );
  }
}

class _RadioPickerContent extends StatefulWidget {
  final List<LFDataItem> items;
  final LFDataItem value;
  final String? title;
  final String? message;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final bool autoPop;
  final String okText;
  final String cancelText;
  final TextStyle? okTextStyle;
  final Color? okTextBackgroundColor;
  final TextStyle? cancelTextStyle;
  final Color? cancelTextBackgroundColor;
  final VoidCallback? onCancel;
  final ValueChanged<LFDataItem>? onOK;

  const _RadioPickerContent({
    required this.items,
    required this.value,
    this.title,
    this.message,
    this.titleStyle,
    this.messageStyle,
    this.autoPop = true,
    this.okText = 'OK',
    this.cancelText = 'Cancel',
    this.okTextStyle,
    this.okTextBackgroundColor,
    this.cancelTextStyle,
    this.cancelTextBackgroundColor,
    this.onCancel,
    this.onOK,
  });

  @override
  State<_RadioPickerContent> createState() => _RadioPickerContentState();
}

class _RadioPickerContentState extends State<_RadioPickerContent> {
  late LFDataItem _value;

  @override
  void initState() {
    super.initState();

    final value = widget.value;
    _value = value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _RadioPickerContent oldWidget) {
    if (oldWidget.value != widget.value) {
      final value = widget.value;
      setState(() {
        _value = value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title ?? '';
    final message = widget.message ?? '';
    final titleStyle = widget.titleStyle;
    final messageStyle = widget.messageStyle;
    final autoPop = widget.autoPop;
    final okText = widget.okText;
    final cancelText = widget.cancelText;
    final okTextStyle = widget.okTextStyle;
    final okTextBackgroundColor = widget.okTextBackgroundColor;
    final cancelTextStyle = widget.cancelTextStyle;
    final cancelTextBackgroundColor = widget.cancelTextBackgroundColor;
    final items = widget.items;
    final onCancel = widget.onCancel;
    final onOK = widget.onOK;

    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      elevation: 4.0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: isNotEmpty(title),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: LFText(
                  title,
                  style: titleStyle,
                ),
              ),
            ),
            Visibility(
              visible: isNotEmpty(message),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                child: LFText(
                  message,
                  style: messageStyle,
                ),
              ),
            ),
            const Divider(),
            Flexible(
              child: SingleChildScrollView(
                child: LFRadioGroups(
                  direction: Axis.horizontal,
                  align: LFRadioAlign.right,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  items: items,
                  value: _value,
                  runSpacing: 6.0,
                  onChanged: (item, checked) {
                    setState(() {
                      _value = item;
                    });
                  },
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildCancelButton(
                  context,
                  autoPop: autoPop,
                  text: cancelText,
                  textStyle: cancelTextStyle,
                  backgroundColor: cancelTextBackgroundColor,
                  onPressed: onCancel,
                ),
                const SizedBox(width: 8.0),
                _buildOKButton(context,
                    autoPop: autoPop,
                    text: okText,
                    textStyle: okTextStyle,
                    backgroundColor: okTextBackgroundColor,
                    onPressed: onOK),
              ],
            )
          ],
        ),
      ),
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
    ValueChanged<LFDataItem>? onPressed,
  }) {
    return GestureDetector(
      onTap: () async {
        if (autoPop) {
          Navigator.maybePop(context);
          await Future.delayed(const Duration(milliseconds: 100));
        }
        onPressed?.call(_value);
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
