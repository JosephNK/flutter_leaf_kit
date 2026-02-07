import 'package:flutter/material.dart';

import '../../../../common/model/model.dart';
import '../../../../common/theme/theme.dart';
import '../../checkbox/widget/lf_checkbox_group_v2.dart';
import '../../checkbox/widget/lf_checkbox_v2.dart';
import 'lf_dialog_button_v2.dart';
import 'lf_dialog_title_v2.dart';

/// A picker dialog with checkbox selection (multi-select).
///
/// Uses [LFCheckBoxGroupV2] internally. All strings are parameters with defaults.
class LFCheckboxPickerDialogV2 {
  const LFCheckboxPickerDialogV2._();

  static Future<void> show(
    BuildContext context, {
    required List<LFDataItem> items,
    List<LFDataItem>? values,
    String? title,
    TextStyle? titleStyle,
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
    ValueChanged<List<LFDataItem>>? onOK,
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return _CheckboxPickerContentV2(
          items: items,
          values: values,
          title: title,
          titleStyle: titleStyle,
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

class _CheckboxPickerContentV2 extends StatefulWidget {
  final List<LFDataItem> items;
  final List<LFDataItem>? values;
  final String? title;
  final TextStyle? titleStyle;
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
  final ValueChanged<List<LFDataItem>>? onOK;

  const _CheckboxPickerContentV2({
    required this.items,
    this.values,
    this.title,
    this.titleStyle,
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
  State<_CheckboxPickerContentV2> createState() =>
      _CheckboxPickerContentV2State();
}

class _CheckboxPickerContentV2State extends State<_CheckboxPickerContentV2> {
  late List<LFDataItem> _values;

  @override
  void initState() {
    super.initState();
    _values = List.of(widget.values ?? []);
  }

  @override
  void didUpdateWidget(covariant _CheckboxPickerContentV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.values != widget.values) {
      setState(() {
        _values = List.of(widget.values ?? []);
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
      label: 'Checkbox picker dialog',
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
              const Divider(),
              Flexible(
                child: SingleChildScrollView(
                  child: LFCheckBoxGroupV2(
                    direction: Axis.horizontal,
                    align: LFCheckBoxAlignV2.right,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    items: widget.items,
                    values: _values,
                    runSpacing: 6.0,
                    onChanged: (items, _) {
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
                  LFDialogCancelButtonV2(
                    autoPop: false,
                    text: widget.cancelText,
                    textStyle: widget.cancelTextStyle,
                    backgroundColor: widget.cancelTextBackgroundColor,
                    borderColor: widget.cancelTextBorderColor,
                    padding: widget.cancelTextPadding,
                    onPressed: () {
                      Navigator.of(context).pop();
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
                      widget.onOK?.call(_values);
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
