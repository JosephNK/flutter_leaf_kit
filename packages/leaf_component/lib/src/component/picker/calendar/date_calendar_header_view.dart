import 'package:flutter/material.dart';
import 'package:flutter_leaf_datetime/leaf_datetime.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../text/text.dart';

@Deprecated('Use LFDatePickerV2 instead')
class DateCalendarHeaderView extends StatelessWidget {
  final DateTime date;
  final bool visible;
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;

  const DateCalendarHeaderView({
    super.key,
    required this.date,
    this.visible = true,
    this.onLeftTap,
    this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    final weekDays = LFLocalizations.shared.localization.shortWeekdays;
    final monthYear = LFDate.parseFromDateTime(date).format('MMMM yyyy');

    return Visibility(
      visible: visible,
      child: Column(
        children: [
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Row(
                  children: [
                    LFText(
                      monthYear,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    // const Icon(LucideIcons.chevronRight, size: 18.0),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        onLeftTap?.call();
                      },
                      child: const Icon(LucideIcons.chevronLeft),
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        onRightTap?.call();
                      },
                      child: const Icon(LucideIcons.chevronRight),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < weekDays.length; i++)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: LFAutoSizeText(
                      weekDays[i],
                      style: TextStyle(
                        fontSize: 13.0,
                        color: (i == 0)
                            ? Colors.red
                            : const Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
