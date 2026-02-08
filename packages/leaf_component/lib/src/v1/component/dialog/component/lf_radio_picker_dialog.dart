part of '../dialog.dart';

/// CustomDialog
/// https://medium.com/@excogitatr/custom-dialog-in-flutter-d00e0441f1d5
///

@Deprecated('Use LeafAlertDialog instead')
class LFRadioPickerDialog {
  static Future confirm(
    BuildContext context, {
    required List<LeafDataItem> items,
    required LeafDataItem value,
    String? title,
    String? message,
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
    ValueChanged<LeafDataItem>? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _RadioPickerContent(
          items: items,
          value: value,
          title: title,
          message: message,
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
      },
    );
  }
}

class _RadioPickerContent extends StatefulWidget {
  final List<LeafDataItem> items;
  final LeafDataItem value;
  final String? title;
  final String? message;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final String? okText;
  final TextStyle? okTextStyle;
  final Color? okTextBackgroundColor;
  final Color? okTextBorderColor;
  final EdgeInsets? okTextPadding;
  final String? cancelText;
  final TextStyle? cancelTextStyle;
  final Color? cancelTextBackgroundColor;
  final Color? cancelTextBorderColor;
  final EdgeInsets? cancelTextPadding;
  final VoidCallback? onCancel;
  final ValueChanged<LeafDataItem>? onOK;

  const _RadioPickerContent({
    required this.items,
    required this.value,
    this.title,
    this.message,
    this.titleStyle,
    this.messageStyle,
    this.okText,
    this.okTextStyle,
    this.okTextBackgroundColor,
    this.okTextBorderColor,
    this.okTextPadding,
    this.cancelText,
    this.cancelTextStyle,
    this.cancelTextBackgroundColor,
    this.cancelTextBorderColor,
    this.cancelTextPadding,
    this.onCancel,
    this.onOK,
  });

  @override
  State<_RadioPickerContent> createState() => _RadioPickerContentState();
}

class _RadioPickerContentState extends State<_RadioPickerContent> {
  late LeafDataItem _value;

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
    final title = widget.title;
    final message = widget.message;
    final titleStyle = widget.titleStyle;
    final messageStyle = widget.messageStyle;
    final okText = widget.okText;
    final cancelText = widget.cancelText;
    final okTextStyle = widget.okTextStyle;
    final okTextBackgroundColor = widget.okTextBackgroundColor;
    final okTextBorderColor = widget.okTextBorderColor;
    final okTextPadding = widget.okTextPadding;
    final cancelTextStyle = widget.cancelTextStyle;
    final cancelTextBackgroundColor = widget.cancelTextBackgroundColor;
    final cancelTextBorderColor = widget.cancelTextBorderColor;
    final cancelTextPadding = widget.cancelTextPadding;
    final items = widget.items;
    final onCancel = widget.onCancel;
    final onOK = widget.onOK;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 80.0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
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
                padding: const EdgeInsets.all(8.0),
                child: LFDialogTitle(text: title, textStyle: titleStyle),
              ),
            ),
            Visibility(
              visible: isNotEmpty(message),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LFDialogMessage(text: message, textStyle: messageStyle),
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
                LFDialogCancelButton(
                  autoPop: false,
                  text: cancelText,
                  textStyle: cancelTextStyle,
                  backgroundColor: cancelTextBackgroundColor,
                  borderColor: cancelTextBorderColor,
                  padding: cancelTextPadding,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onCancel?.call();
                  },
                ),
                LFDialogOKButton(
                  autoPop: false,
                  text: okText,
                  textStyle: okTextStyle,
                  backgroundColor: okTextBackgroundColor,
                  borderColor: okTextBorderColor,
                  padding: okTextPadding,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onOK?.call(_value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
