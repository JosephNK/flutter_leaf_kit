part of lf_dialog;

typedef LFCalendarDatePickerOnOK = Function(
    LFCalendarPickerSelect select, DateTime dateTime);

class LFCalendarDatePickerDialog {
  static Future show(
    BuildContext context, {
    required LFCalendarPickerSelect pickerSelect,
    bool isLunar = false,
    bool isAllDay = false,
    DateTime? startDate,
    DateTime? endDate,
    Color activeColor = Colors.purple,
    Color inactiveColor = Colors.grey,
    String startText = 'Start',
    String endText = 'End',
    String okText = 'OK',
    String validStartMessage = 'Please set the start date before the end date',
    String validEndMessage = 'Please set the end date after the start date',
    LFCalendarDatePickerOnOK? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _CalendarDatePickerContent(
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
          validStartMessage: validStartMessage,
          validEndMessage: validEndMessage,
          onOK: onOK,
        );
      },
    );
  }
}

class _CalendarDatePickerContent extends StatefulWidget {
  final LFCalendarPickerSelect pickerSelect;
  final bool isLunar;
  final bool isAllDay;
  final DateTime? startDate;
  final DateTime? endDate;
  final Color activeColor;
  final Color inactiveColor;
  final String startText;
  final String endText;
  final String okText;
  final String validStartMessage;
  final String validEndMessage;
  final LFCalendarDatePickerOnOK? onOK;

  const _CalendarDatePickerContent({
    Key? key,
    required this.pickerSelect,
    this.isLunar = false,
    this.isAllDay = false,
    this.startDate,
    this.endDate,
    this.activeColor = Colors.purple,
    this.inactiveColor = Colors.grey,
    this.startText = 'Start',
    this.endText = 'End',
    this.okText = 'OK',
    this.validStartMessage = 'Please set the start date before the end date',
    this.validEndMessage = 'Please set the end date after the start date',
    this.onOK,
  }) : super(key: key);

  @override
  State<_CalendarDatePickerContent> createState() =>
      _CalendarDatePickerContentState();
}

class _CalendarDatePickerContentState
    extends State<_CalendarDatePickerContent> {
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
    _startDate = widget.startDate ?? LFDateTime.today();
    _endDate = widget.endDate ?? LFDateTime.today();

    switch (pickerSelect) {
      case LFCalendarPickerSelect.none:
      case LFCalendarPickerSelect.start:
        _defaultDate = !isLunar
            ? _startDate
            : LFDateTime.parse(_startDate.toLunarDateString());
        break;
      case LFCalendarPickerSelect.end:
        _defaultDate = !isLunar
            ? _endDate
            : LFDateTime.parse(_endDate.toLunarDateString());
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
            /// Header
            Visibility(
              visible: (pickerSelect != LFCalendarPickerSelect.none),
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
                            LFText(
                              _startDate.toWeekDayDateString(
                                  short: true,
                                  isLunar: isLunar,
                                  visiblePrefix: isLunar),
                              style: TextStyle(
                                  fontSize: !isLunar ? 18.0 : 16.0,
                                  color: _getStartDateColor()),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                            ),
                            Visibility(
                              visible: isLunar,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: LFText(
                                  _startDate.toWeekDayDateString(
                                      short: true,
                                      isLunar: false,
                                      visiblePrefix: isLunar),
                                  style: TextStyle(
                                      fontSize: 14.0, color: inactiveColor),
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
                            LFText(
                              _endDate.toWeekDayDateString(
                                  short: true,
                                  isLunar: isLunar,
                                  visiblePrefix: isLunar),
                              style: TextStyle(
                                  fontSize: !isLunar ? 18.0 : 16.0,
                                  color: _getEndDateColor()),
                              textAlign: TextAlign.right,
                              maxLines: 2,
                            ),
                            Visibility(
                              visible: isLunar,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: LFText(
                                  _endDate.toWeekDayDateString(
                                      short: true,
                                      isLunar: isLunar,
                                      visiblePrefix: isLunar),
                                  style: TextStyle(
                                      fontSize: 14.0, color: inactiveColor),
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
                  const SizedBox(height: 25.0),
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
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _onCallBackOK(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: activeColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      child: LFText(
                        okText,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            )
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
        : LFDateTime.parse(selectedDate.toSolarDateString());
    switch (pickerSelect) {
      case LFCalendarPickerSelect.none:
      case LFCalendarPickerSelect.start:
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
      case LFCalendarPickerSelect.end:
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

    switch (pickerSelect) {
      case LFCalendarPickerSelect.none:
      case LFCalendarPickerSelect.start:
        fromDateTime = _startDate;
        toDateTime = _endDate;
        resultDateTime = _startDate;
        break;
      case LFCalendarPickerSelect.end:
        fromDateTime = _endDate;
        toDateTime = _startDate;
        resultDateTime = _endDate;
        break;
    }

    final f =
        LFDateTime.parse(fromDateTime.toDateTimeString(format: 'yyyy-MM-dd'));
    final t =
        LFDateTime.parse(toDateTime.toDateTimeString(format: 'yyyy-MM-dd'));

    String? validMessage;

    switch (pickerSelect) {
      case LFCalendarPickerSelect.none:
        break;
      case LFCalendarPickerSelect.start:
        if (f.isAfter(t) && !isAllDay) {
          validMessage = widget.validStartMessage;
        }
        break;
      case LFCalendarPickerSelect.end:
        if (f.isBefore(t) && !isAllDay) {
          validMessage = widget.validEndMessage;
        }
        break;
    }

    if (validMessage != null) {
      LFToast.show(context, message: validMessage);
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
      case LFCalendarPickerSelect.none:
        return widget.activeColor;
      case LFCalendarPickerSelect.start:
        return widget.activeColor;
      case LFCalendarPickerSelect.end:
        return widget.inactiveColor;
    }
  }

  Color _getEndDateColor() {
    final isAllDay = widget.isAllDay;
    final pickerSelect = widget.pickerSelect;

    if (isAllDay) return widget.activeColor;

    switch (pickerSelect) {
      case LFCalendarPickerSelect.none:
        return widget.activeColor;
      case LFCalendarPickerSelect.start:
        return widget.inactiveColor;
      case LFCalendarPickerSelect.end:
        return widget.activeColor;
    }
  }
}
