import 'package:flutter/material.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:flutter_leaf_component/leaf_component.dart';

class CalendarScreen extends ScreenStatefulWidget {
  final String title;

  const CalendarScreen({
    super.key,
    required this.title,
  });

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
                          child: const LFText(
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
                          child: const LFText(
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
            onMonthChanged: (month, startDateTime, endDateTime, selectedDate) {
              Logging.d('onMonthChanged: $startDateTime, $endDateTime');
            },
            onDateSelected: (dateTimes) {
              Logging.d('onDateSelected: $dateTimes');
            },
          ),
        ),
      ],
    );
  }
}
