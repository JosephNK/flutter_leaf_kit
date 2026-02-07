import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

/// A themed date picker card widget with expandable inline calendar.
///
/// Displays the selected date in a compact card. Tapping expands to show
/// a [CalendarDatePicker] inline.
///
/// Style resolution order:
///   1. Explicit widget parameters ([backgroundColor], [activeColor])
///   2. [LFPickerThemeData] from the nearest [LFTheme]
///   3. Global tokens
class LFDatePickerV2 extends StatefulWidget {
  final Widget? label;
  final Widget? icon;
  final TextStyle? dateTextStyle;
  final Color? activeColor;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onChanged;

  const LFDatePickerV2({
    super.key,
    this.label,
    this.icon,
    this.dateTextStyle,
    this.activeColor,
    this.backgroundColor,
    this.borderRadius,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
  });

  @override
  State<LFDatePickerV2> createState() => _LFDatePickerV2State();
}

class _LFDatePickerV2State extends State<LFDatePickerV2> {
  late DateTime _selectedDate;
  bool _isExpanded = false;

  String get _formattedDate {
    final month = _selectedDate.month.toString().padLeft(2, '0');
    final day = _selectedDate.day.toString().padLeft(2, '0');
    return '$month.$day ${_selectedDate.year}';
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
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
    final resolvedDateStyle = widget.dateTextStyle ??
        componentTheme?.headerTextStyle;

    final borderColor = _isExpanded ? resolvedActiveColor : Colors.transparent;

    return Semantics(
      label: 'Date picker, selected: $_formattedDate',
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          widget.label ?? const Text('Date'),
                          Text(_formattedDate, style: resolvedDateStyle),
                        ],
                      ),
                    ),
                    widget.icon ?? const Icon(Icons.calendar_today),
                  ],
                ),
              ),
              if (_isExpanded)
                SizedBox(
                  height: 320.0,
                  child: Column(
                    children: [
                      Divider(height: 1, color: borderColor),
                      Expanded(
                        child: CalendarDatePicker(
                          initialDate: _selectedDate,
                          firstDate: widget.firstDate ?? DateTime(1900),
                          lastDate: widget.lastDate ?? DateTime(2100),
                          onDateChanged: (date) {
                            setState(() => _selectedDate = date);
                            widget.onChanged?.call(date);
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
