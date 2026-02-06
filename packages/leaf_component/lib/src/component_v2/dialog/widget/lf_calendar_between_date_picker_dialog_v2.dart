import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'lf_dialog_button_v2.dart';

/// Selection mode for between-date/time pickers.
enum LFCalendarBetweenPickerSelectV2 { none, start, end }

/// A dialog for selecting a date within a start/end range using
/// Flutter's built-in [CalendarDatePicker].
///
/// No dependency on `leaf_datetime`.
class LFCalendarBetweenDatePickerDialogV2 {
  const LFCalendarBetweenDatePickerDialogV2._();

  static Future<void> show(
    BuildContext context, {
    required LFCalendarBetweenPickerSelectV2 pickerSelect,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? firstDate,
    DateTime? lastDate,
    Color? activeColor,
    Color? inactiveColor,
    String startText = 'Start',
    String endText = 'End',
    String? okText,
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    String validStartMessage =
        'Please set the start date before the end date',
    String validEndMessage =
        'Please set the end date after the start date',
    void Function(LFCalendarBetweenPickerSelectV2 select, DateTime dateTime)?
        onOK,
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return _BetweenDatePickerContentV2(
          pickerSelect: pickerSelect,
          startDate: startDate,
          endDate: endDate,
          firstDate: firstDate,
          lastDate: lastDate,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          startText: startText,
          endText: endText,
          okText: okText,
          okTextStyle: okTextStyle,
          okTextBackgroundColor: okTextBackgroundColor,
          okTextBorderColor: okTextBorderColor,
          okTextPadding: okTextPadding,
          validStartMessage: validStartMessage,
          validEndMessage: validEndMessage,
          onOK: onOK,
        );
      },
    );
  }
}

class _BetweenDatePickerContentV2 extends StatefulWidget {
  final LFCalendarBetweenPickerSelectV2 pickerSelect;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color? activeColor;
  final Color? inactiveColor;
  final String startText;
  final String endText;
  final String? okText;
  final TextStyle? okTextStyle;
  final Color? okTextBackgroundColor;
  final Color? okTextBorderColor;
  final EdgeInsets? okTextPadding;
  final String validStartMessage;
  final String validEndMessage;
  final void Function(
      LFCalendarBetweenPickerSelectV2 select, DateTime dateTime)? onOK;

  const _BetweenDatePickerContentV2({
    required this.pickerSelect,
    this.startDate,
    this.endDate,
    this.firstDate,
    this.lastDate,
    this.activeColor,
    this.inactiveColor,
    this.startText = 'Start',
    this.endText = 'End',
    this.okText,
    this.okTextStyle,
    this.okTextBackgroundColor,
    this.okTextBorderColor,
    this.okTextPadding,
    this.validStartMessage =
        'Please set the start date before the end date',
    this.validEndMessage =
        'Please set the end date after the start date',
    this.onOK,
  });

  @override
  State<_BetweenDatePickerContentV2> createState() =>
      _BetweenDatePickerContentV2State();
}

class _BetweenDatePickerContentV2State
    extends State<_BetweenDatePickerContentV2> {
  late DateTime _startDate;
  late DateTime _endDate;
  late DateTime _initialDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate ?? DateTime.now();
    _endDate = widget.endDate ?? DateTime.now();

    switch (widget.pickerSelect) {
      case LFCalendarBetweenPickerSelectV2.none:
      case LFCalendarBetweenPickerSelectV2.start:
        _initialDate = _startDate;
      case LFCalendarBetweenPickerSelectV2.end:
        _initialDate = _endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final dialogTheme = theme.dialogTheme;

    final resolvedActiveColor = widget.activeColor ?? colors.primary;
    final resolvedInactiveColor =
        widget.inactiveColor ?? colors.inactive;
    final resolvedBorderRadius =
        dialogTheme?.borderRadius ?? BorderRadius.circular(20.0);

    final firstDate =
        widget.firstDate ?? DateTime(_initialDate.year - 10);
    final lastDate =
        widget.lastDate ?? DateTime(_initialDate.year + 10);

    final showHeader =
        widget.pickerSelect != LFCalendarBetweenPickerSelectV2.none;

    return Semantics(
      label: 'Between date picker dialog',
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
              if (showHeader) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.startText,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: resolvedInactiveColor,
                      ),
                    ),
                    Text(
                      widget.endText,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: resolvedInactiveColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _formatDate(_startDate),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: _getStartDateColor(
                            resolvedActiveColor,
                            resolvedInactiveColor,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 19.0,
                      color: colors.onSurface.withValues(alpha: 0.54),
                    ),
                    Expanded(
                      child: Text(
                        _formatDate(_endDate),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: _getEndDateColor(
                            resolvedActiveColor,
                            resolvedInactiveColor,
                          ),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
              ],
              Flexible(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: resolvedActiveColor,
                        ),
                  ),
                  child: CalendarDatePicker(
                    initialDate: _initialDate,
                    firstDate: firstDate,
                    lastDate: lastDate,
                    onDateChanged: _updateSelectDate,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: LFDialogOKButtonV2(
                        autoPop: false,
                        text: widget.okText,
                        textStyle: widget.okTextStyle,
                        backgroundColor: widget.okTextBackgroundColor,
                        borderColor: widget.okTextBorderColor,
                        padding: widget.okTextPadding,
                        onPressed: () => _onCallBackOK(context),
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

  String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  void _updateSelectDate(DateTime date) {
    switch (widget.pickerSelect) {
      case LFCalendarBetweenPickerSelectV2.none:
      case LFCalendarBetweenPickerSelectV2.start:
        setState(() {
          _startDate = date;
          if (date.isAfter(_endDate)) {
            _endDate = date;
          }
        });
      case LFCalendarBetweenPickerSelectV2.end:
        setState(() {
          _endDate = date;
        });
    }
  }

  void _onCallBackOK(BuildContext context) {
    final pickerSelect = widget.pickerSelect;
    late DateTime resultDate;

    switch (pickerSelect) {
      case LFCalendarBetweenPickerSelectV2.none:
      case LFCalendarBetweenPickerSelectV2.start:
        if (_startDate.isAfter(_endDate)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(widget.validStartMessage)),
          );
          return;
        }
        resultDate = _startDate;
      case LFCalendarBetweenPickerSelectV2.end:
        if (_endDate.isBefore(_startDate)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(widget.validEndMessage)),
          );
          return;
        }
        resultDate = _endDate;
    }

    widget.onOK?.call(pickerSelect, resultDate);
    Navigator.of(context).pop();
  }

  Color _getStartDateColor(Color active, Color inactive) {
    switch (widget.pickerSelect) {
      case LFCalendarBetweenPickerSelectV2.none:
      case LFCalendarBetweenPickerSelectV2.start:
        return active;
      case LFCalendarBetweenPickerSelectV2.end:
        return inactive;
    }
  }

  Color _getEndDateColor(Color active, Color inactive) {
    switch (widget.pickerSelect) {
      case LFCalendarBetweenPickerSelectV2.none:
      case LFCalendarBetweenPickerSelectV2.end:
        return active;
      case LFCalendarBetweenPickerSelectV2.start:
        return inactive;
    }
  }
}
