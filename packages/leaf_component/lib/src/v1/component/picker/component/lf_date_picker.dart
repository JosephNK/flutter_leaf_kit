part of '../picker.dart';

@Deprecated('Use LeafDatePicker instead')
class LFDatePicker extends StatefulWidget {
  final Widget? label;
  final Widget? icon;
  final TextStyle? timeTextStyle;
  final Color? borderColor;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final DateTime? initialDateTime;
  final bool visibleHeader;
  final ValueChanged<DateTime>? onChanged;

  const LFDatePicker({
    super.key,
    this.label,
    this.icon,
    this.timeTextStyle,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
    this.initialDateTime,
    this.visibleHeader = true,
    this.onChanged,
  });

  @override
  State<LFDatePicker> createState() => _LFDatePickerState();
}

class _LFDatePickerState extends State<LFDatePicker> {
  late DateTime _dateTime;
  bool _isExpanded = false;
  bool _isVisible = false;

  String get formattedDate {
    final int year = _dateTime.year;
    final int month = _dateTime.month;
    final int day = _dateTime.day;
    final String formattedMonth = month.toString().padLeft(2, '0');
    final String formattedDay = day.toString().padLeft(2, '0');
    return '$formattedMonth.$formattedDay $year';
  }

  @override
  void initState() {
    super.initState();

    final initialDateTime = widget.initialDateTime ?? LeafDate.now().dateTime;
    _dateTime = initialDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final value = !_isExpanded;
        setState(() {
          _isExpanded = value;
        });
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() {
            _isVisible = value;
          });
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _isExpanded
                ? widget.borderColor ?? Colors.black
                : Colors.transparent,
            width: 1.0,
          ),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12.0),
          color: widget.backgroundColor ?? Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            LFText(formattedDate, style: widget.timeTextStyle),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 1.0,
                            color: widget.borderColor ?? Colors.black,
                          ),
                          Expanded(
                            child: Visibility(
                              visible: _isVisible,
                              child: DateCalendarView(
                                selectedDateTime: _dateTime,
                                visibleHeader: widget.visibleHeader,
                                onDateTimeChanged: (time) {
                                  setState(() {
                                    _dateTime = time;
                                  });
                                  widget.onChanged?.call(time);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
