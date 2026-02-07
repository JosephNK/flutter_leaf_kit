import 'package:flutter/material.dart';

import '../../../model/model.dart';
import '../../../theme/theme.dart';
import '../../radio/widget/lf_radio_group_v2.dart';
import '../../radio/widget/lf_radio_v2.dart';
import 'lf_dialog_button_v2.dart';
import 'lf_dialog_message_v2.dart';
import 'lf_dialog_title_v2.dart';

/// A picker dialog with radio selection (single-select).
///
/// Uses [LFRadioGroupV2] internally. All strings are parameters with defaults.
class LFRadioPickerDialogV2 {
  const LFRadioPickerDialogV2._();

  static Future<void> show(
    BuildContext context, {
    required List<LFDataItem> items,
    required LFDataItem value,
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
    ValueChanged<LFDataItem>? onOK,
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return _RadioPickerContentV2(
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

class _RadioPickerContentV2 extends StatefulWidget {
  final List<LFDataItem> items;
  final LFDataItem value;
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
  final ValueChanged<LFDataItem>? onOK;

  const _RadioPickerContentV2({
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
  State<_RadioPickerContentV2> createState() => _RadioPickerContentV2State();
}

class _RadioPickerContentV2State extends State<_RadioPickerContentV2> {
  late LFDataItem _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant _RadioPickerContentV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        _value = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final dialogTheme = theme.dialogTheme;
    final resolvedBorderRadius =
        dialogTheme?.borderRadius ?? BorderRadius.circular(4.0);

    return Semantics(
      label: 'Radio picker dialog',
      child: Dialog(
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
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
                  child: LFDialogTitleV2(
                    text: widget.title!,
                    textStyle: widget.titleStyle,
                  ),
                ),
              if (widget.message != null && widget.message!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LFDialogMessageV2(
                    text: widget.message!,
                    textStyle: widget.messageStyle,
                  ),
                ),
              const Divider(),
              Flexible(
                child: SingleChildScrollView(
                  child: LFRadioGroupV2(
                    direction: Axis.horizontal,
                    align: LFRadioAlignV2.right,
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
                  LFDialogCancelButtonV2(
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
                  LFDialogOKButtonV2(
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
