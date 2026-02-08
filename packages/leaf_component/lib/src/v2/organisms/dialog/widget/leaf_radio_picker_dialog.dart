import 'package:flutter/material.dart';

import '../../../../common/model/model.dart';
import '../../../../common/theme/theme.dart';
import '../../../atoms/radio/widget/leaf_radio_group.dart';
import '../../../atoms/radio/widget/leaf_radio.dart';
import 'leaf_dialog_button.dart';
import 'leaf_dialog_message.dart';
import 'leaf_dialog_title.dart';

/// A picker dialog with radio selection (single-select).
///
/// Uses [LeafRadioGroup] internally. All strings are parameters with defaults.
class LeafRadioPickerDialog {
  const LeafRadioPickerDialog._();

  static Future<void> show(
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
    return showDialog(
      context: context,
      builder: (ctx) {
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
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant _RadioPickerContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        _value = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final dialogTheme = theme.dialogTheme;
    final resolvedBorderRadius =
        dialogTheme?.borderRadius ?? BorderRadius.circular(4.0);

    return Semantics(
      label: 'Radio picker dialog',
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 80.0,
        ),
        shape: RoundedRectangleBorder(borderRadius: resolvedBorderRadius),
        elevation: 4.0,
        backgroundColor: colors.surface,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null && widget.title!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LeafDialogTitle(
                    text: widget.title!,
                    textStyle: widget.titleStyle,
                  ),
                ),
              if (widget.message != null && widget.message!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LeafDialogMessage(
                    text: widget.message!,
                    textStyle: widget.messageStyle,
                  ),
                ),
              const Divider(),
              Flexible(
                child: SingleChildScrollView(
                  child: LeafRadioGroup(
                    direction: Axis.horizontal,
                    align: LeafRadioAlign.right,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    items: widget.items,
                    value: _value,
                    runSpacing: 6.0,
                    onChanged: (item, _) {
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
                  LeafDialogCancelButton(
                    autoPop: false,
                    text: widget.cancelText,
                    textStyle: widget.cancelTextStyle,
                    backgroundColor: widget.cancelTextBackgroundColor,
                    borderColor: widget.cancelTextBorderColor,
                    padding: widget.cancelTextPadding,
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onCancel?.call();
                    },
                  ),
                  LeafDialogOKButton(
                    autoPop: false,
                    text: widget.okText,
                    textStyle: widget.okTextStyle,
                    backgroundColor: widget.okTextBackgroundColor,
                    borderColor: widget.okTextBorderColor,
                    padding: widget.okTextPadding,
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onOK?.call(_value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
