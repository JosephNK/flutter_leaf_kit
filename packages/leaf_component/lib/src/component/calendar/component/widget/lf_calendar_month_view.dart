part of '../lf_calendar_view.dart';

class LFCalendarMonthView extends StatelessWidget {
  final DateTime dateTime;
  final DateTime? minDate;
  final DateTime? maxDate;
  final Color pickerActiveColor;
  final String pickerOKText;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final ValueChanged<DateTime>? onPickerSelectTap;

  const LFCalendarMonthView({
    super.key,
    required this.dateTime,
    this.minDate,
    this.maxDate,
    this.pickerActiveColor = Colors.purple,
    this.pickerOKText = 'OK',
    this.onPrev,
    this.onNext,
    this.onPickerSelectTap,
  });

  @override
  Widget build(BuildContext context) {
    final year = dateTime.toCalYearString();
    final month = dateTime.toCalMonthString();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: (onPrev != null),
              child: GestureDetector(
                onTap: () {
                  onPrev?.call();
                },
                child: Container(
                  width: 25.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: const Color.fromRGBO(186, 186, 186, 0.3),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 14.0,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (onPickerSelectTap == null) return;
                final date =
                    LFDate.parseFromString(dateTime.toCalYearMonthDayString())
                        .dateTime;
                final _ = await LFCalendarMonthDatePicker.show(
                  context,
                  date: date,
                  minDate: minDate,
                  maxDate: maxDate,
                  activeColor: pickerActiveColor,
                  okText: pickerOKText,
                  onOK: (dateTime) {
                    onPickerSelectTap?.call(dateTime);
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  '$year.$month',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
              visible: (onNext != null),
              child: GestureDetector(
                onTap: () {
                  onNext?.call();
                },
                child: Container(
                  width: 25.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: const Color.fromRGBO(186, 186, 186, 0.3),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14.0,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
