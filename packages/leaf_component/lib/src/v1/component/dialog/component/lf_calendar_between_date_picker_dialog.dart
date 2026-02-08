part of '../dialog.dart';

@Deprecated('Use LeafAlertDialog instead')
typedef LFCalendarBetweenDatePickerOnOK =
    Function(LFCalendarBetweenPickerSelect select, DateTime dateTime);

@Deprecated('Use LeafAlertDialog instead')
class LFCalendarBetweenDatePickerDialog {
  static Future show(
    BuildContext context, {
    required LFCalendarBetweenPickerSelect pickerSelect,
    bool isLunar = false,
    bool isAllDay = false,
    DateTime? startDate,
    DateTime? endDate,
    Color activeColor = Colors.blueAccent,
    Color inactiveColor = Colors.grey,
    String startText = 'Start',
    String endText = 'End',
    String? okText,
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    String validStartMessage = 'Please set the start date before the end date',
    String validEndMessage = 'Please set the end date after the start date',
    LFCalendarBetweenDatePickerOnOK? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _CalendarBetweenDatePickerContent(
          pickerSelect: pickerSelect,
          isLunar: isLunar,
          isAllDay: isAllDay,
          startDate: startDate,
          endDate: endDate,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          startText: startText,
          endText: endText,
          okText: okText,
          okTextStyle: okTextStyle,
          okTextBackgroundColor: okTextBackgroundColor,
          okTextBorderColor: okTextBorderColor,
          okTextPadding: okTextPadding,
          validStartMessage: validStartMessage,
          validEndMessage: validEndMessage,
          onOK: onOK,
        );
      },
    );
  }
}

class _CalendarBetweenDatePickerContent extends StatefulWidget {
  final LFCalendarBetweenPickerSelect pickerSelect;
  final bool isLunar;
  final bool isAllDay;
  final DateTime? startDate;
  final DateTime? endDate;
  final Color activeColor;
  final Color inactiveColor;
  final String startText;
  final String endText;
  final String? okText;
  final TextStyle? okTextStyle;
  final Color? okTextBackgroundColor;
  final Color? okTextBorderColor;
  final EdgeInsets? okTextPadding;
  final String validStartMessage;
  final String validEndMessage;
  final LFCalendarBetweenDatePickerOnOK? onOK;

  const _CalendarBetweenDatePickerContent({
    required this.pickerSelect,
    this.isLunar = false,
    this.isAllDay = false,
    this.startDate,
    this.endDate,
    this.activeColor = Colors.purple,
    this.inactiveColor = Colors.grey,
    this.startText = 'Start',
    this.endText = 'End',
    this.okText,
    this.okTextStyle,
    this.okTextBackgroundColor,
    this.okTextBorderColor,
    this.okTextPadding,
    this.validStartMessage = 'Please set the start date before the end date',
    this.validEndMessage = 'Please set the end date after the start date',
    this.onOK,
  });

  @override
  State<_CalendarBetweenDatePickerContent> createState() =>
      _CalendarBetweenDatePickerContentState();
}

class _CalendarBetweenDatePickerContentState
    extends State<_CalendarBetweenDatePickerContent> {
  late LFCalendarController _controller;
  late DateTime _defaultDate;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();

    final pickerSelect = widget.pickerSelect;
    final isLunar = widget.isLunar;

    _controller = LFCalendarController();
    _startDate = widget.startDate ?? LeafDate.now().dateTime;
    _endDate = widget.endDate ?? LeafDate.now().dateTime;

    switch (pickerSelect) {
      case LFCalendarBetweenPickerSelect.none:
      case LFCalendarBetweenPickerSelect.start:
        _defaultDate = !isLunar
            ? _startDate
            : LeafDate.parseFromString(
                _startDate.toCalLunarDateString(),
              ).dateTime;
        break;
      case LFCalendarBetweenPickerSelect.end:
        _defaultDate = !isLunar
            ? _endDate
            : LeafDate.parseFromString(
                _endDate.toCalLunarDateString(),
              ).dateTime;
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pickerSelect = widget.pickerSelect;
    final isLunar = widget.isLunar;
    final activeColor = widget.activeColor;
    final inactiveColor = widget.inactiveColor;
    final startText = widget.startText;
    final endText = widget.endText;
    final okText = widget.okText;
    final okTextStyle = widget.okTextStyle;
    final okTextBackgroundColor = widget.okTextBackgroundColor;
    final okTextBorderColor = widget.okTextBorderColor;
    final okTextPadding = widget.okTextPadding;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 80.0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 4.0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header
            Visibility(
              visible: (pickerSelect != LFCalendarBetweenPickerSelect.none),
              child: Column(
                children: [
                  /// Header Start & End String
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LFText(
                        startText,
                        style: TextStyle(fontSize: 14.0, color: inactiveColor),
                        textAlign: TextAlign.left,
                      ),
                      LFText(
                        endText,
                        style: TextStyle(fontSize: 14.0, color: inactiveColor),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),

                  /// Header Start & End Date
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LFAutoSizeText(
                              _startDate.toCalWeekDayDateString(
                                context,
                                short: true,
                                isLunar: isLunar,
                                visiblePrefix: isLunar,
                              ),
                              style: TextStyle(
                                fontSize: !isLunar ? 18.0 : 16.0,
                                color: _getStartDateColor(),
                              ),
                              textAlign: TextAlign.left,
                              minFontSize: 9,
                            ),
                            Visibility(
                              visible: isLunar,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: LFText(
                                  _startDate.toCalWeekDayDateString(
                                    context,
                                    short: true,
                                    isLunar: false,
                                    visiblePrefix: isLunar,
                                  ),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: inactiveColor,
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 19.0,
                        color: Colors.black54,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            LFAutoSizeText(
                              _endDate.toCalWeekDayDateString(
                                context,
                                short: true,
                                isLunar: isLunar,
                                visiblePrefix: isLunar,
                              ),
                              style: TextStyle(
                                fontSize: !isLunar ? 18.0 : 16.0,
                                color: _getEndDateColor(),
                              ),
                              textAlign: TextAlign.right,
                              minFontSize: 9,
                            ),
                            Visibility(
                              visible: isLunar,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: LFText(
                                  _endDate.toCalWeekDayDateString(
                                    context,
                                    short: true,
                                    isLunar: isLunar,
                                    visiblePrefix: isLunar,
                                  ),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: inactiveColor,
                                  ),
                                  textAlign: TextAlign.right,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),

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
            ),
          ],
        ),
      ),
    );
  }

  void _updateSelectDate(DateTime? selectedDate) {
    if (selectedDate == null) return;
    final isAllDay = widget.isAllDay;
    final isLunar = widget.isLunar;
    final pickerSelect = widget.pickerSelect;
    final dateTime = !isLunar
        ? selectedDate
        : LeafDate.parseFromString(
            selectedDate.toCalSolarDateString(),
          ).dateTime;
    switch (pickerSelect) {
      case LFCalendarBetweenPickerSelect.none:
      case LFCalendarBetweenPickerSelect.start:
        if (!isAllDay) {
          final isAfter = dateTime.isAfter(_endDate);
          if (isAfter) {
            setState(() {
              _startDate = dateTime;
              _endDate = dateTime;
            });
          } else {
            setState(() {
              _startDate = dateTime;
            });
          }
        } else {
          setState(() {
            _startDate = dateTime;
            _endDate = dateTime;
          });
        }
        break;
      case LFCalendarBetweenPickerSelect.end:
        if (!isAllDay) {
          setState(() {
            _endDate = dateTime;
          });
        } else {
          setState(() {
            _startDate = dateTime;
            _endDate = dateTime;
          });
        }
        break;
    }
  }

  void _onCallBackOK(BuildContext context) {
    final isAllDay = widget.isAllDay;
    final pickerSelect = widget.pickerSelect;

    late DateTime fromDateTime;
    late DateTime toDateTime;
    late DateTime resultDateTime;

    final startDate = _startDate.toCalYearMonthDayString();
    final startTime = _startDate.toCalHHmmString();
    final endDate = _endDate.toCalYearMonthDayString();
    final updateStartDateTime = LeafDate.parseFromString(
      '$startDate $startTime',
    ).dateTime;
    final updateEndDateTime = LeafDate.parseFromString(
      '$endDate $startTime',
    ).dateTime;

    if (updateStartDateTime.isSameDateTime(updateEndDateTime, onlyDate: true)) {
      _startDate = updateStartDateTime.toCalDayStartDateTime();
      _endDate = updateEndDateTime.toCalDayEndDateTime();
    }

    switch (pickerSelect) {
      case LFCalendarBetweenPickerSelect.none:
      case LFCalendarBetweenPickerSelect.start:
        fromDateTime = _startDate;
        toDateTime = _endDate;
        resultDateTime = _startDate;
        break;
      case LFCalendarBetweenPickerSelect.end:
        fromDateTime = _endDate;
        toDateTime = _startDate;
        resultDateTime = _endDate;
        break;
    }

    final f = LeafDate.parseFromString(
      fromDateTime.toCalYearMonthDayString(),
    ).dateTime;
    final t = LeafDate.parseFromString(
      toDateTime.toCalYearMonthDayString(),
    ).dateTime;

    String? validMessage;

    switch (pickerSelect) {
      case LFCalendarBetweenPickerSelect.none:
        break;
      case LFCalendarBetweenPickerSelect.start:
        if (f.isAfter(t) && !isAllDay) {
          validMessage = widget.validStartMessage;
        }
        break;
      case LFCalendarBetweenPickerSelect.end:
        if (f.isBefore(t) && !isAllDay) {
          validMessage = widget.validEndMessage;
        }
        break;
    }

    if (validMessage != null) {
      LFToast.showToast(context, message: validMessage);
      return;
    }

    widget.onOK?.call(pickerSelect, resultDateTime);

    Navigator.of(context).pop();
  }

  Color _getStartDateColor() {
    final isAllDay = widget.isAllDay;
    final pickerSelect = widget.pickerSelect;

    if (isAllDay) return widget.activeColor;

    switch (pickerSelect) {
      case LFCalendarBetweenPickerSelect.none:
        return widget.activeColor;
      case LFCalendarBetweenPickerSelect.start:
        return widget.activeColor;
      case LFCalendarBetweenPickerSelect.end:
        return widget.inactiveColor;
    }
  }

  Color _getEndDateColor() {
    final isAllDay = widget.isAllDay;
    final pickerSelect = widget.pickerSelect;

    if (isAllDay) return widget.activeColor;

    switch (pickerSelect) {
      case LFCalendarBetweenPickerSelect.none:
        return widget.activeColor;
      case LFCalendarBetweenPickerSelect.start:
        return widget.inactiveColor;
      case LFCalendarBetweenPickerSelect.end:
        return widget.activeColor;
    }
  }
}
