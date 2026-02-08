import 'package:flutter/material.dart';

import '../../../../common/model/model.dart';
import '../../../../common/theme/theme.dart';
import '../../../atoms/checkbox/widget/leaf_checkbox_group.dart';
import '../../../atoms/checkbox/widget/leaf_checkbox.dart';
import 'leaf_dialog_button.dart';
import 'leaf_dialog_title.dart';

/// A picker dialog with checkbox selection (multi-select).
///
/// Uses [LeafCheckBoxGroup] internally. All strings are parameters with defaults.
class LeafCheckboxPickerDialog {
  const LeafCheckboxPickerDialog._();

  static Future<void> show(
    BuildContext context, {
    required List<LeafDataItem> items,
    List<LeafDataItem>? values,
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
    ValueChanged<List<LeafDataItem>>? onOK,
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return _CheckboxPickerContent(
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

class _CheckboxPickerContent extends StatefulWidget {
  final List<LeafDataItem> items;
  final List<LeafDataItem>? values;
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
  final ValueChanged<List<LeafDataItem>>? onOK;

  const _CheckboxPickerContent({
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
  State<_CheckboxPickerContent> createState() => _CheckboxPickerContentState();
}

class _CheckboxPickerContentState extends State<_CheckboxPickerContent> {
  late List<LeafDataItem> _values;

  @override
  void initState() {
    super.initState();
    _values = List.of(widget.values ?? []);
  }

  @override
  void didUpdateWidget(covariant _CheckboxPickerContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.values != widget.values) {
      setState(() {
        _values = List.of(widget.values ?? []);
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
      label: 'Checkbox picker dialog',
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
              const Divider(),
              Flexible(
                child: SingleChildScrollView(
                  child: LeafCheckBoxGroup(
                    direction: Axis.horizontal,
                    align: LeafCheckBoxAlign.right,
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
                  LeafDialogCancelButton(
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
                  LeafDialogOKButton(
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
