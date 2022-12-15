part of lf_calendar_view;

class LFCalendarPageCell extends StatelessWidget {
  final DateTime dateTime;

  const LFCalendarPageCell({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isToday = dateTime.isToday();
    final day = dateTime.day.toString();

    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Util.randomColor(),
        child: Stack(
          children: [
            Positioned(
              top: 6,
              right: 6,
              child: Text(day),
            ),
          ],
        ),
      ),
    );
  }
}

class Util {
  static Color randomColor() {
    return Color(Random().nextInt(0xffffffff));
  }
}
