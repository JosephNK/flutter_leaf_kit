import 'package:flutter/material.dart';

import '../../../../common/model/model.dart';
import '../../../../common/theme/theme.dart';
import '../../chip/widget/lf_chips_v2.dart';
import 'lf_dialog_button_v2.dart';
import 'lf_dialog_title_v2.dart';

/// A picker dialog with chip selection (single or multi-select).
///
/// Uses [LFChipsV2] internally. All strings are parameters with defaults.
class LFChipPickerDialogV2 {
  const LFChipPickerDialogV2._();

  static Future<void> show(
    BuildContext context, {
    required List<LFDataItem> items,
    List<LFDataItem>? values,
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
    ValueChanged<List<LFDataItem>>? onOK,
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return _ChipPickerContentV2(
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

class _ChipPickerContentV2 extends StatefulWidget {
  final List<LFDataItem> items;
  final List<LFDataItem>? values;
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
  final ValueChanged<List<LFDataItem>>? onOK;

  const _ChipPickerContentV2({
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
  State<_ChipPickerContentV2> createState() => _ChipPickerContentV2State();
}

class _ChipPickerContentV2State extends State<_ChipPickerContentV2> {
  late List<LFDataItem> _values;

  @override
  void initState() {
    super.initState();
    _values = List.of(widget.values ?? []);
  }

  @override
  void didUpdateWidget(covariant _ChipPickerContentV2 oldWidget) {
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
      label: 'Chip picker dialog',
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: LFChipsV2(
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
