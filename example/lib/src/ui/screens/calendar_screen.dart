import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class CalendarScreen extends ScreenStatefulWidget {
  final String title;

  const CalendarScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ScreenState<CalendarScreen> {
  @override
  Color? get backgroundColor => Colors.white;

  @override
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return LFAppBar(
      title: LFAppBarTitle(text: widget.title),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: LFCalendarView(
            defaultDate: DateTime.now(),
            minDate: DateTime(1900),
            maxDate: DateTime(2200),
            childAspectRatio: 0.9,
            // physics: const NeverScrollableScrollPhysics(),
            weekDays: const ['일', '월', '화', '수', '목', '금', '토'],
            yearUnit: '년',
            monthUnit: '월',
            cellBuilder: (context, dateTime, size) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: const Color.fromRGBO(234, 225, 255, 1),
                          ),
                          child: LFText(
                            'Hello',
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 1.0),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: const Color.fromRGBO(241, 241, 241, 1),
                          ),
                          child: LFText(
                            'World',
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            onMonthChanged: (startDateTime, endDateTime) {
              print('onMonthChanged: $startDateTime, $endDateTime');
            },
            onDateSelected: (dateTimes) {
              print('onDateSelected: $dateTimes');
            },
          ),
        ),
      ],
    );
  }
}
