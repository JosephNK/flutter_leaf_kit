import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

/// A themed time picker card widget with expandable inline time wheel.
///
/// Displays the selected time in a compact card. Tapping expands to show
/// a [CupertinoDatePicker] in time mode.
///
/// Style resolution order:
///   1. Explicit widget parameters ([backgroundColor], [activeColor])
///   2. [LFPickerThemeData] from the nearest [LFTheme]
///   3. Global tokens
class LFTimePickerV2 extends StatefulWidget {
  final Widget? label;
  final Widget? icon;
  final TextStyle? timeTextStyle;
  final Color? activeColor;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final DateTime? initialTime;
  final int minuteInterval;
  final bool use24hFormat;
  final ValueChanged<DateTime>? onChanged;

  const LFTimePickerV2({
    super.key,
    this.label,
    this.icon,
    this.timeTextStyle,
    this.activeColor,
    this.backgroundColor,
    this.borderRadius,
    this.initialTime,
    this.minuteInterval = 5,
    this.use24hFormat = false,
    this.onChanged,
  });

  @override
  State<LFTimePickerV2> createState() => _LFTimePickerV2State();
}

class _LFTimePickerV2State extends State<LFTimePickerV2> {
  late DateTime _dateTime;
  bool _isExpanded = false;

  String get _formattedTime {
    final hour24 = _dateTime.hour;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final formattedHour = hour12.toString().padLeft(2, '0');
    final formattedMinute = _dateTime.minute.toString().padLeft(2, '0');
    final period = hour24 < 12 ? 'AM' : 'PM';

    if (widget.use24hFormat) {
      return '${hour24.toString().padLeft(2, '0')}:$formattedMinute';
    }
    return '$formattedHour:$formattedMinute $period';
  }

  @override
  void initState() {
    super.initState();
    final initial = widget.initialTime ?? DateTime.now();
    _dateTime = initial.copyWith(
      minute: (initial.minute ~/ widget.minuteInterval) * widget.minuteInterval,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final componentTheme = theme.pickerTheme;

    final resolvedActiveColor =
        widget.activeColor ?? componentTheme?.activeColor ?? colors.primary;
    final resolvedBg =
        widget.backgroundColor ?? componentTheme?.backgroundColor ?? colors.surface;
    final resolvedBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(12.0);
    final resolvedTimeStyle = widget.timeTextStyle ??
        componentTheme?.headerTextStyle;

    final borderColor = _isExpanded ? resolvedActiveColor : Colors.transparent;

    return Semantics(
      label: 'Time picker, selected: $_formattedTime',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() => _isExpanded = !_isExpanded);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.0),
            borderRadius: resolvedBorderRadius,
            color: resolvedBg,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 7.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.label ?? const Text('Time'),
                          Text(_formattedTime, style: resolvedTimeStyle),
                        ],
                      ),
                    ),
                    widget.icon ?? const Icon(Icons.access_time),
                  ],
                ),
              ),
              if (_isExpanded)
                SizedBox(
                  height: 201.0,
                  child: Column(
                    children: [
                      Divider(height: 1, color: borderColor),
                      Expanded(
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          minuteInterval: widget.minuteInterval,
                          initialDateTime: _dateTime,
                          use24hFormat: widget.use24hFormat,
                          onDateTimeChanged: (time) {
                            setState(() => _dateTime = time);
                            widget.onChanged?.call(time);
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
