import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import 'leaf_dialog_button.dart';

/// A dialog with Flutter's built-in [CalendarDatePicker] for date selection.
///
/// No dependency on `leaf_datetime`. Uses [LeafDialogThemeData] for theming.
class LeafCalendarDatePickerDialog {
  const LeafCalendarDatePickerDialog._();

  static Future<void> show(
    BuildContext context, {
    DateTime? date,
    DateTime? firstDate,
    DateTime? lastDate,
    Color? activeColor,
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
        return _CalendarDatePickerContentV2(
          date: date,
          firstDate: firstDate,
          lastDate: lastDate,
          activeColor: activeColor,
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

class _CalendarDatePickerContentV2 extends StatefulWidget {
  final DateTime? date;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color? activeColor;
  final String? okText;
  final TextStyle? okTextStyle;
  final Color? okTextBackgroundColor;
  final Color? okTextBorderColor;
  final EdgeInsets? okTextPadding;
  final ValueChanged<DateTime>? onOK;

  const _CalendarDatePickerContentV2({
    this.date,
    this.firstDate,
    this.lastDate,
    this.activeColor,
    this.okText,
    this.okTextStyle,
    this.okTextBackgroundColor,
    this.okTextBorderColor,
    this.okTextPadding,
    this.onOK,
  });

  @override
  State<_CalendarDatePickerContentV2> createState() =>
      _CalendarDatePickerContentV2State();
}

class _CalendarDatePickerContentV2State
    extends State<_CalendarDatePickerContentV2> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final dialogTheme = theme.dialogTheme;

    final resolvedActiveColor = widget.activeColor ?? colors.primary;
    final resolvedBorderRadius =
        dialogTheme?.borderRadius ?? BorderRadius.circular(20.0);

    final firstDate =
        widget.firstDate ?? DateTime(_selectedDate.year - 10);
    final lastDate =
        widget.lastDate ?? DateTime(_selectedDate.year + 10);

    return Semantics(
      label: 'Calendar date picker dialog',
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
              Flexible(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: resolvedActiveColor,
                        ),
                  ),
                  child: CalendarDatePicker(
                    initialDate: _selectedDate,
                    firstDate: firstDate,
                    lastDate: lastDate,
                    onDateChanged: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
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
                          widget.onOK?.call(_selectedDate);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
