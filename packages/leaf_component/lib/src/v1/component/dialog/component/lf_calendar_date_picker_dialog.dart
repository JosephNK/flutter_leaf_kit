part of '../dialog.dart';

@Deprecated('Use LFAlertDialogV2 instead')
typedef LFCalendarDatePickerOnOK = Function(DateTime dateTime);

@Deprecated('Use LFAlertDialogV2 instead')
class LFCalendarDatePickerDialog {
  static Future show(
    BuildContext context, {
    DateTime? date,
    Color? activeColor,
    String? okText,
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    LFCalendarDatePickerOnOK? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _CalendarDatePickerContent(
          date: date,
          activeColor: activeColor,
          okText: okText,
          okTextStyle: okTextStyle,
          okTextBackgroundColor: okTextBackgroundColor,
          okTextBorderColor: okTextBorderColor,
          okTextPadding: okTextPadding,
          onOK: onOK,
        );
      },
    );
  }
}

class _CalendarDatePickerContent extends StatefulWidget {
  final DateTime? date;
  final Color? activeColor;
  final String? okText;
  final TextStyle? okTextStyle;
  final Color? okTextBackgroundColor;
  final Color? okTextBorderColor;
  final EdgeInsets? okTextPadding;
  final LFCalendarDatePickerOnOK? onOK;

  const _CalendarDatePickerContent({
    this.date,
    this.activeColor,
    this.okText,
    this.okTextStyle,
    this.okTextBackgroundColor,
    this.okTextBorderColor,
    this.okTextPadding,
    this.onOK,
  });

  @override
  State<_CalendarDatePickerContent> createState() =>
      _CalendarDatePickerContentState();
}

class _CalendarDatePickerContentState
    extends State<_CalendarDatePickerContent> {
  late LFCalendarController _controller;
  late DateTime _defaultDate;
  late DateTime _date;

  @override
  void initState() {
    super.initState();

    _controller = LFCalendarController();
    _date = widget.date ?? LFDate.now().dateTime;
    _defaultDate = _date;
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.activeColor ??
        LFComponentConfigure.shared.pickerCalendar?.activeColor ??
        Colors.blueAccent;
    final okText = widget.okText;
    final okTextStyle = widget.okTextStyle;
    final okTextBackgroundColor = widget.okTextBackgroundColor;
    final okTextBorderColor = widget.okTextBorderColor;
    final okTextPadding = widget.okTextPadding;

    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4.0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Calendar
            LFCalendarView(
              defaultDate: _defaultDate,
              controller: _controller,
              childAspectRatio: 1.0,
              todayColor: activeColor,
              selectedColor: activeColor,
              showToday: false,
              onMonthOnTap: (month) {},
              onMonthChanged:
                  (startDateTime, endDateTime, monthDate, selectedDate) {
                _updateSelectDate(selectedDate);
              },
              onDateSelected: (selectedDate) {
                _updateSelectDate(selectedDate);
              },
              cellBuilder: (context, dateTime, size) {
                return const Column();
              },
            ),

            /// OK Button
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: LFDialogOKButton(
                      autoPop: false,
                      text: okText,
                      textStyle: okTextStyle,
                      backgroundColor: okTextBackgroundColor,
                      borderColor: okTextBorderColor,
                      padding: okTextPadding,
                      onPressed: () {
                        _onCallBackOK(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateSelectDate(DateTime? selectedDate) {
    if (selectedDate == null) return;
    final dateTime = selectedDate;
    setState(() {
      _date = dateTime;
    });
  }

  void _onCallBackOK(BuildContext context) {
    final date = _date.toCalYearMonthDayString();
    final time = _date.toCalHHmmString();
    final updateDateTime = LFDate.parseFromString('$date $time').dateTime;

    widget.onOK?.call(updateDateTime);

    Navigator.of(context).pop();
  }
}
