part of '../lf_calendar_view.dart';

class LFCalendarPageCell extends StatelessWidget {
  final DateTime dateTime;
  final List<DateTime> selectedDateTimes;
  final LFCalendarCellBuilder? cellBuilder;
  final int weekday;
  final bool isDisabled;
  final TextStyle? dayTextStyle;
  final Color todayColor;
  final Color selectedColor;
  final Color holidayColor;
  final bool showToday;
  final ValueChanged<DateTime>? onSelected;

  const LFCalendarPageCell({
    super.key,
    required this.dateTime,
    required this.selectedDateTimes,
    this.cellBuilder,
    this.weekday = -1,
    this.isDisabled = false,
    this.dayTextStyle,
    this.todayColor = Colors.purple,
    this.selectedColor = Colors.purpleAccent,
    this.holidayColor = Colors.red,
    this.showToday = true,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final selectedDateTimes = this.selectedDateTimes;
    final dayTextStyle = this.dayTextStyle;
    final isDisabled = this.isDisabled;
    final todayColor = this.todayColor;
    final selectedColor = this.selectedColor;
    final holidayColor = this.holidayColor;
    final showToday = this.showToday;
    final onSelected = this.onSelected;

    final isSelected = (onSelected == null)
        ? false
        : selectedDateTimes
            .where((selectedDateTime) => dateTime.isSameDate(selectedDateTime))
            .toList()
            .isNotEmpty;
    final isToday = dateTime.isToday();
    final day = dateTime.day.toString();

    final dayBackgroundColor = isToday
        ? showToday
            ? todayColor
            : Colors.transparent
        : Colors.transparent;

    final dayTextColor = weekday == 7
        ? holidayColor
        : isToday
            ? showToday
                ? Colors.white
                : Colors.black
            : Colors.black;

    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (isDisabled) return;
          onSelected?.call(dateTime);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 26.0,
                      height: 26.0,
                      // padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.0),
                        color: dayBackgroundColor,
                        border: Border.all(
                          color:
                              isSelected ? selectedColor : Colors.transparent,
                        ),
                      ),
                      child: Opacity(
                        opacity: isDisabled ? 0.3 : 1.0,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            day,
                            style:
                                dayTextStyle?.copyWith(color: dayTextColor) ??
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
                  Expanded(
                    child: LayoutBuilder(
                      builder: (_, constraints) {
                        return cellBuilder?.call(
                              context,
                              dateTime,
                              Size(constraints.maxWidth, constraints.maxHeight),
                            ) ??
                            Container();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// class Util {
//   static Color randomColor() {
//     return Color(Random().nextInt(0xffffffff));
//   }
// }
