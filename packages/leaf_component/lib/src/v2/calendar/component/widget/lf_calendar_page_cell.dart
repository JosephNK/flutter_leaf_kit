part of lf_calendar_view;

class LFCalendarPageCell extends StatelessWidget {
  final LFCalendarCellBuilder cellBuilder;
  final DateTime dateTime;
  final int weekday;
  final bool isDisabled;
  final TextStyle? dayTextStyle;
  final Color todayColor;
  final Color holidayColor;
  final ValueChanged<DateTime>? onSelected;

  const LFCalendarPageCell({
    Key? key,
    required this.cellBuilder,
    required this.dateTime,
    this.weekday = -1,
    this.isDisabled = false,
    this.dayTextStyle,
    this.todayColor = Colors.purple,
    this.holidayColor = Colors.red,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayTextStyle = this.dayTextStyle;
    final isDisabled = this.isDisabled;
    final todayColor = this.todayColor;
    final holidayColor = this.holidayColor;
    final onSelected = this.onSelected;

    final isToday = dateTime.isToday();
    final day = dateTime.day.toString();

    final dayTextColor = weekday == 7
        ? holidayColor
        : isToday
            ? Colors.white
            : Colors.black;

    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (isDisabled) return;
          onSelected?.call(dateTime);
        },
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 24.0,
                  height: 24.0,
                  // padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: isToday ? todayColor : Colors.transparent,
                  ),
                  child: Opacity(
                    opacity: isDisabled ? 0.3 : 1.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        day,
                        style: dayTextStyle?.copyWith(color: dayTextColor) ??
                            const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0,
                            ).copyWith(color: dayTextColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              cellBuilder.call(
                context,
                dateTime,
                Size(constraints.maxWidth, constraints.maxHeight - 24.0),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// class Util {
//   static Color randomColor() {
//     return Color(Random().nextInt(0xffffffff));
//   }
// }
