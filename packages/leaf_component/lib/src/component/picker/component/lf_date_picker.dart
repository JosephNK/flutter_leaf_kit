part of '../picker.dart';

class LFDatePicker extends StatefulWidget {
  final Widget? label;
  final Widget? icon;
  final TextStyle? timeTextStyle;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final DateTime? initialDateTime;
  final ValueChanged<DateTime>? onChanged;

  const LFDatePicker({
    super.key,
    this.label,
    this.icon,
    this.timeTextStyle,
    this.borderColor,
    this.borderRadius,
    this.initialDateTime,
    this.onChanged,
  });

  @override
  State<LFDatePicker> createState() => _LFDatePickerState();
}

class _LFDatePickerState extends State<LFDatePicker> {
  late DateTime _dateTime;
  bool _isExpanded = false;

  String get formattedDate {
    final int hour24 = _dateTime.hour;
    final int hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final String formattedHour12 = hour12.toString().padLeft(2, '0');
    final int minute = _dateTime.minute;
    final String period = hour24 < 12 ? 'AM' : 'PM';
    return '$formattedHour12:$minute $period';
  }

  @override
  void initState() {
    super.initState();

    final initialDateTime = widget.initialDateTime ?? DateTime.now();
    _dateTime = initialDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.borderColor ?? Colors.black,
            width: 1.0,
          ),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 7.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.label ?? const LFText('Date'),
                            LFText(
                              formattedDate,
                              style: widget.timeTextStyle,
                            ),
                          ],
                        ),
                      ),
                      widget.icon ?? const Icon(LucideIcons.calendar),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _isExpanded ? 400.0 + 1.0 : 0,
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: !_isExpanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: const SizedBox.shrink(),
                    secondChild: SizedBox(
                      height: 400.0 + 1.0,
                      child: Column(
                        children: [
                          Container(
                            height: 1.0,
                            color: widget.borderColor ?? Colors.black,
                          ),
                          Expanded(
                            child: Visibility(
                              visible: _isExpanded,
                              child: DateCalendarView(
                                  // mode: CupertinoDatePickerMode.time,
                                  // minuteInterval: widget.minuteInterval,
                                  // initialDateTime: _dateTime,
                                  // use24hFormat: false,
                                  // onDateTimeChanged: (time) {
                                  //   setState(() {
                                  //     _dateTime = time;
                                  //   });
                                  //   widget.onChanged?.call(time);
                                  // },
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
