import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'lf_calendar_between_date_picker_dialog_v2.dart';
import 'lf_dialog_button_v2.dart';

/// A dialog for selecting a time within a start/end range using
/// [CupertinoDatePicker] in time mode.
///
/// No dependency on `leaf_datetime`.
class LFCalendarBetweenTimePickerDialogV2 {
  const LFCalendarBetweenTimePickerDialogV2._();

  static Future<void> show(
    BuildContext context, {
    required LFCalendarBetweenPickerSelectV2 pickerSelect,
    DateTime? startTime,
    DateTime? endTime,
    Color? activeColor,
    Color? inactiveColor,
    String startText = 'Start',
    String endText = 'End',
    String? okText,
    String validStartMessage =
        'Please set the start time before the end time',
    String validEndMessage =
        'Please set the end time after the start time',
    void Function(LFCalendarBetweenPickerSelectV2 select, DateTime dateTime)?
        onOK,
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return _BetweenTimePickerContentV2(
          pickerSelect: pickerSelect,
          startTime: startTime,
          endTime: endTime,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          startText: startText,
          endText: endText,
          okText: okText,
          validStartMessage: validStartMessage,
          validEndMessage: validEndMessage,
          onOK: onOK,
        );
      },
    );
  }
}

class _BetweenTimePickerContentV2 extends StatefulWidget {
  final LFCalendarBetweenPickerSelectV2 pickerSelect;
  final DateTime? startTime;
  final DateTime? endTime;
  final Color? activeColor;
  final Color? inactiveColor;
  final String startText;
  final String endText;
  final String? okText;
  final String validStartMessage;
  final String validEndMessage;
  final void Function(
      LFCalendarBetweenPickerSelectV2 select, DateTime dateTime)? onOK;

  const _BetweenTimePickerContentV2({
    required this.pickerSelect,
    this.startTime,
    this.endTime,
    this.activeColor,
    this.inactiveColor,
    this.startText = 'Start',
    this.endText = 'End',
    this.okText,
    this.validStartMessage =
        'Please set the start time before the end time',
    this.validEndMessage =
        'Please set the end time after the start time',
    this.onOK,
  });

  @override
  State<_BetweenTimePickerContentV2> createState() =>
      _BetweenTimePickerContentV2State();
}

class _BetweenTimePickerContentV2State
    extends State<_BetweenTimePickerContentV2> {
  late DateTime _startTime;
  late DateTime _endTime;
  late DateTime _defaultTime;

  @override
  void initState() {
    super.initState();
    _startTime = widget.startTime ?? DateTime.now();
    _endTime = widget.endTime ?? DateTime.now();

    switch (widget.pickerSelect) {
      case LFCalendarBetweenPickerSelectV2.none:
      case LFCalendarBetweenPickerSelectV2.start:
        _defaultTime = _startTime;
      case LFCalendarBetweenPickerSelectV2.end:
        _defaultTime = _endTime;
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

    final showHeader =
        widget.pickerSelect != LFCalendarBetweenPickerSelectV2.none;

    return Semantics(
      label: 'Between time picker dialog',
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
                        _formatTime(_startTime),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: _getStartTimeColor(
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
                        _formatTime(_endTime),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: _getEndTimeColor(
                            resolvedActiveColor,
                            resolvedInactiveColor,
                          ),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25.0),
              ],
              SizedBox(
                height: 180,
                child: CupertinoDatePicker(
                  initialDateTime: _defaultTime,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: _updateSelectTime,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: LFDialogOKButtonV2(
                      autoPop: false,
                      text: widget.okText,
                      onPressed: () => _onCallBackOK(context),
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

  String _formatTime(DateTime dt) {
    final hour = dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '$displayHour:$minute $period';
  }

  void _updateSelectTime(DateTime time) {
    switch (widget.pickerSelect) {
      case LFCalendarBetweenPickerSelectV2.none:
      case LFCalendarBetweenPickerSelectV2.start:
        setState(() {
          _startTime = time;
        });
      case LFCalendarBetweenPickerSelectV2.end:
        setState(() {
          _endTime = time;
        });
    }
  }

  void _onCallBackOK(BuildContext context) {
    final pickerSelect = widget.pickerSelect;

    late DateTime resultTime;

    switch (pickerSelect) {
      case LFCalendarBetweenPickerSelectV2.none:
      case LFCalendarBetweenPickerSelectV2.start:
        resultTime = _startTime;
        if (_isSameDay(_startTime, _endTime) &&
            _startTime.isAfter(_endTime)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(widget.validStartMessage)),
          );
          return;
        }
      case LFCalendarBetweenPickerSelectV2.end:
        resultTime = _endTime;
        if (_isSameDay(_startTime, _endTime) &&
            _endTime.isBefore(_startTime)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(widget.validEndMessage)),
          );
          return;
        }
    }

    widget.onOK?.call(pickerSelect, resultTime);
    Navigator.of(context).pop();
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Color _getStartTimeColor(Color active, Color inactive) {
    switch (widget.pickerSelect) {
      case LFCalendarBetweenPickerSelectV2.none:
      case LFCalendarBetweenPickerSelectV2.start:
        return active;
      case LFCalendarBetweenPickerSelectV2.end:
        return inactive;
    }
  }

  Color _getEndTimeColor(Color active, Color inactive) {
    switch (widget.pickerSelect) {
      case LFCalendarBetweenPickerSelectV2.none:
      case LFCalendarBetweenPickerSelectV2.end:
        return active;
      case LFCalendarBetweenPickerSelectV2.start:
        return inactive;
    }
  }
}
