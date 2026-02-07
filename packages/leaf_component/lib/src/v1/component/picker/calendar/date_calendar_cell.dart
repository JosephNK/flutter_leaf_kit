import 'package:flutter/material.dart';

import '../../text/text.dart';

@Deprecated('Use LFDatePickerV2 instead')
class DateCalendarCell extends StatelessWidget {
  final DateTime dateTime;
  final DateTime selectedDateTime;
  final bool isDisabled;
  final double width;
  final double height;
  final ValueChanged<DateTime>? onSelected;

  const DateCalendarCell({
    super.key,
    required this.dateTime,
    required this.selectedDateTime,
    required this.isDisabled,
    required this.width,
    required this.height,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedDateTime.day == dateTime.day &&
        selectedDateTime.month == dateTime.month &&
        selectedDateTime.year == dateTime.year;
    final day = dateTime.day.toString();

    final dayBackgroundColor = isSelected ? Colors.black : Colors.transparent;
    final dayTextColor = isSelected ? Colors.white : Colors.black;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (isDisabled) return;
        onSelected?.call(dateTime);
      },
      child: SizedBox(
        width: width,
        height: height,
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
                  // border: Border.all(
                  //   color:
                  //   isSelected ? selectedColor : Colors.transparent,
                  // ),
                ),
                child: Opacity(
                  opacity: isDisabled ? 0.3 : 1.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: LFText(
                      day,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                      ).copyWith(
                        color: dayTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
