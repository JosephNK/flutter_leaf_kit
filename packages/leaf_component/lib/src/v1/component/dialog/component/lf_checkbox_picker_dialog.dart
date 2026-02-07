part of '../dialog.dart';

/// CustomDialog
/// https://medium.com/@excogitatr/custom-dialog-in-flutter-d00e0441f1d5
///

@Deprecated('Use LeafAlertDialog instead')
class LFCheckboxPickerDialog {
  static Future show(
    BuildContext context, {
    required List<LeafDataItem> items,
    List<LeafDataItem>? values,
    String? title,
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
    ValueChanged<List<LeafDataItem>>? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _CheckBoxPickerContent(
          items: items,
          values: values,
          title: title,
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
          onOK: onOK,
        );
      },
    );
  }
}

class _CheckBoxPickerContent extends StatefulWidget {
  final List<LeafDataItem> items;
  final List<LeafDataItem>? values;
  final String? title;
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
  final ValueChanged<List<LeafDataItem>>? onOK;

  const _CheckBoxPickerContent({
    required this.items,
    this.values,
    this.title,
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
    this.onOK,
  });

  @override
  State<_CheckBoxPickerContent> createState() => _CheckBoxPickerContentState();
}

class _CheckBoxPickerContentState extends State<_CheckBoxPickerContent> {
  List<LeafDataItem>? _values;

  @override
  void initState() {
    super.initState();

    _values = List<LeafDataItem>.from(widget.values ?? []);
  }

  @override
  void dispose() {
    _values = null;

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _CheckBoxPickerContent oldWidget) {
    if (oldWidget.values != widget.values) {
      final values = List<LeafDataItem>.from(widget.values ?? []);
      setState(() {
        _values = values;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    final titleStyle = widget.titleStyle;
    final items = widget.items;
    final okText = widget.okText;
    final okTextStyle = widget.okTextStyle;
    final okTextBackgroundColor = widget.okTextBackgroundColor;
    final okTextBorderColor = widget.okTextBorderColor;
    final okTextPadding = widget.okTextPadding;
    final cancelText = widget.cancelText;
    final cancelTextStyle = widget.cancelTextStyle;
    final cancelTextBackgroundColor = widget.cancelTextBackgroundColor;
    final cancelTextBorderColor = widget.cancelTextBorderColor;
    final cancelTextPadding = widget.cancelTextPadding;
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
                padding: const EdgeInsets.all(8.0),
                child: LFDialogTitle(
                  text: title,
                  textStyle: titleStyle,
                ),
              ),
            ),
            const Divider(),
            Flexible(
              child: SingleChildScrollView(
                child: LFCheckboxGroups(
                  direction: Axis.horizontal,
                  align: LFCheckBoxAlign.right,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  items: items,
                  values: _values,
                  runSpacing: 6.0,
                  onChanged: (items, item) {
                    setState(() {
                      _values = items;
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
                    onOK?.call(_values ?? []);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
