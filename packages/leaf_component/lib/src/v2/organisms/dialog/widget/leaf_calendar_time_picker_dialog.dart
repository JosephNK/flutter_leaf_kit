import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import 'leaf_dialog_button.dart';

/// A dialog with [CupertinoDatePicker] in time mode for time selection.
///
/// No dependency on `leaf_datetime`. Uses [LeafDialogThemeData] for theming.
class LeafCalendarTimePickerDialog {
  const LeafCalendarTimePickerDialog._();

  static Future<void> show(
    BuildContext context, {
    DateTime? time,
    String? okText,
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    ValueChanged<DateTime>? onOK,
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return _CalendarTimePickerContentV2(
          time: time,
          okText: okText,
          okTextStyle: okTextStyle,
          okTextBackgroundColor: okTextBackgroundColor,
          okTextBorderColor: okTextBorderColor,
          okTextPadding: okTextPadding,
          onOK: onOK,
        );
      },
    );
  }
}

class _CalendarTimePickerContentV2 extends StatefulWidget {
  final DateTime? time;
  final String? okText;
  final TextStyle? okTextStyle;
  final Color? okTextBackgroundColor;
  final Color? okTextBorderColor;
  final EdgeInsets? okTextPadding;
  final ValueChanged<DateTime>? onOK;

  const _CalendarTimePickerContentV2({
    this.time,
    this.okText,
    this.okTextStyle,
    this.okTextBackgroundColor,
    this.okTextBorderColor,
    this.okTextPadding,
    this.onOK,
  });

  @override
  State<_CalendarTimePickerContentV2> createState() =>
      _CalendarTimePickerContentV2State();
}

class _CalendarTimePickerContentV2State
    extends State<_CalendarTimePickerContentV2> {
  late DateTime _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.time ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final dialogTheme = theme.dialogTheme;
    final resolvedBorderRadius =
        dialogTheme?.borderRadius ?? BorderRadius.circular(20.0);

    return Semantics(
      label: 'Time picker dialog',
      child: Dialog(
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
        shape: RoundedRectangleBorder(borderRadius: resolvedBorderRadius),
        elevation: 4.0,
        backgroundColor: colors.surface,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 180,
                child: CupertinoDatePicker(
                  initialDateTime: _selectedTime,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (value) {
                    setState(() {
                      _selectedTime = value;
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: LeafDialogOKButton(
                      autoPop: false,
                      text: widget.okText,
                      textStyle: widget.okTextStyle,
                      backgroundColor: widget.okTextBackgroundColor,
                      borderColor: widget.okTextBorderColor,
                      padding: widget.okTextPadding,
                      onPressed: () {
                        widget.onOK?.call(_selectedTime);
                        Navigator.of(context).pop();
                      },
                    ),
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
