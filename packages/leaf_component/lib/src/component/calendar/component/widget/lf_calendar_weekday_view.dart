part of lf_calendar_view;

class LFCalendarWeekDayView extends StatelessWidget {
  final Color holidayColor;

  const LFCalendarWeekDayView({
    Key? key,
    required this.holidayColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weekDays = LFLocalizations.shared.localization.shortWeekdays;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < weekDays.length; i++)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                weekDays[i],
                style: TextStyle(
                  fontSize: 13.0,
                  color: (i == 0)
                      ? holidayColor
                      : const Color.fromRGBO(0, 0, 0, 0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
