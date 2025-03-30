import 'package:flutter/material.dart';
import 'package:flutter_leaf_datetime/leaf_datetime.dart';

import '../../text/text.dart';

class DateCalendarCell extends StatelessWidget {
  final DateTime dateTime;
  final bool isDisabled;
  final double width;
  final double height;

  const DateCalendarCell({
    super.key,
    required this.dateTime,
    required this.isDisabled,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = dateTime.isToday();
    final day = dateTime.day.toString();

    final dayBackgroundColor = isToday ? Colors.black : Colors.transparent;
    final dayTextColor = isToday ? Colors.white : Colors.black;

    return SizedBox(
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
    );
  }
}
