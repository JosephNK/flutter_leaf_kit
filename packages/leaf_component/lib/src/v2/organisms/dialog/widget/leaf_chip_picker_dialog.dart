import 'package:flutter/material.dart';

import '../../../../common/model/model.dart';
import '../../../../common/theme/theme.dart';
import '../../../atoms/chip/widget/leaf_chips.dart';
import 'leaf_dialog_button.dart';
import 'leaf_dialog_title.dart';

/// A picker dialog with chip selection (single or multi-select).
///
/// Uses [LeafChips] internally. All strings are parameters with defaults.
class LeafChipPickerDialog {
  const LeafChipPickerDialog._();

  static Future<void> show(
    BuildContext context, {
    required List<LeafDataItem> items,
    List<LeafDataItem>? values,
    bool multiple = true,
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
        return _ChipPickerContent(
          items: items,
          values: values,
          multiple: multiple,
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

class _ChipPickerContent extends StatefulWidget {
  final List<LeafDataItem> items;
  final List<LeafDataItem>? values;
  final bool multiple;
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

  const _ChipPickerContent({
    required this.items,
    this.values,
    this.multiple = true,
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
  State<_ChipPickerContent> createState() => _ChipPickerContentState();
}

class _ChipPickerContentState extends State<_ChipPickerContent> {
  late List<LeafDataItem> _values;

  @override
  void initState() {
    super.initState();
    _values = List.of(widget.values ?? []);
  }

  @override
  void didUpdateWidget(covariant _ChipPickerContent oldWidget) {
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
      label: 'Chip picker dialog',
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: LeafChips(
                      direction: Axis.horizontal,
                      items: widget.items,
                      values: _values,
                      multiple: widget.multiple,
                      onChanged: (values, _) {
                        setState(() {
                          _values = values;
                        });
                      },
                    ),
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
