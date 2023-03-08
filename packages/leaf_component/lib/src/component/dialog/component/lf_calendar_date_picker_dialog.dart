part of lf_dialog;

enum LFCalendarDatePickerSelect { start, end }

typedef LFCalendarDatePickerOnOK = Function(
    LFCalendarDatePickerSelect select, DateTime dateTime);

class LFCalendarDatePickerDialog {
  static Future show(
    BuildContext context, {
    required LFCalendarDatePickerSelect pickerSelect,
    DateTime? startDate,
    DateTime? endDate,
    Color activeColor = Colors.purple,
    Color inactiveColor = Colors.grey,
    String startText = 'Start',
    String endText = 'End',
    String okText = 'OK',
    LFCalendarDatePickerOnOK? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _CalendarDatePickerContent(
          pickerSelect: pickerSelect,
          startDate: startDate,
          endDate: endDate,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          startText: startText,
          endText: endText,
          okText: okText,
          onOK: onOK,
        );
      },
    );
  }
}

class _CalendarDatePickerContent extends StatefulWidget {
  final LFCalendarDatePickerSelect pickerSelect;
  final DateTime? startDate;
  final DateTime? endDate;
  final Color activeColor;
  final Color inactiveColor;
  final String startText;
  final String endText;
  final String okText;
  final LFCalendarDatePickerOnOK? onOK;

  const _CalendarDatePickerContent({
    Key? key,
    required this.pickerSelect,
    this.startDate,
    this.endDate,
    this.activeColor = Colors.purple,
    this.inactiveColor = Colors.grey,
    this.startText = 'Start',
    this.endText = 'End',
    this.okText = 'OK',
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

    _controller = LFCalendarController();
    _startDate = widget.startDate ?? LFDateTime.today();
    _endDate = widget.endDate ?? LFDateTime.today();
    final pickerSelect = widget.pickerSelect;
    switch (pickerSelect) {
      case LFCalendarDatePickerSelect.start:
        _defaultDate = _startDate;
        break;
      case LFCalendarDatePickerSelect.end:
        _defaultDate = _endDate;
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LFText(
                      widget.startText,
                      style: TextStyle(
                          fontSize: 14.0, color: widget.inactiveColor),
                      textAlign: TextAlign.left,
                    ),
                    LFText(
                      widget.endText,
                      style: TextStyle(
                          fontSize: 14.0, color: widget.inactiveColor),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Expanded(
                      child: LFText(
                        _startDate.toWeekDayDateString(context, short: true),
                        style: TextStyle(
                            fontSize: 18.0, color: _getStartDateColor()),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 19.0,
                      color: Colors.black54,
                    ),
                    Expanded(
                      child: LFText(
                        _endDate.toWeekDayDateString(context, short: true),
                        style: TextStyle(
                            fontSize: 18.0, color: _getEndDateColor()),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            LFCalendarView(
              defaultDate: _defaultDate,
              controller: _controller,
              childAspectRatio: 1.0,
              todayColor: widget.activeColor,
              selectedColor: widget.activeColor,
              showToday: false,
              cellBuilder: (context, dateTime, size) {
                return Column();
              },
              onMonthChanged:
                  (startDateTime, endDateTime, monthDate, selectedDate) {},
              onMonthOnTap: (month) {},
              onDateSelected: (selectedDate) {
                if (selectedDate == null) return;
                final pickerSelect = widget.pickerSelect;
                switch (pickerSelect) {
                  case LFCalendarDatePickerSelect.start:
                    setState(() {
                      _startDate = selectedDate;
                    });
                    break;
                  case LFCalendarDatePickerSelect.end:
                    setState(() {
                      _endDate = selectedDate;
                    });
                    break;
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final pickerSelect = widget.pickerSelect;
                      switch (pickerSelect) {
                        case LFCalendarDatePickerSelect.start:
                          widget.onOK?.call(pickerSelect, _startDate);
                          break;
                        case LFCalendarDatePickerSelect.end:
                          widget.onOK?.call(pickerSelect, _endDate);
                          break;
                      }
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: widget.activeColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      child: LFText(
                        widget.okText,
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

  Color _getStartDateColor() {
    final pickerSelect = widget.pickerSelect;
    switch (pickerSelect) {
      case LFCalendarDatePickerSelect.start:
        return widget.activeColor;
      case LFCalendarDatePickerSelect.end:
        return widget.inactiveColor;
    }
  }

  Color _getEndDateColor() {
    final pickerSelect = widget.pickerSelect;
    switch (pickerSelect) {
      case LFCalendarDatePickerSelect.start:
        return widget.inactiveColor;
      case LFCalendarDatePickerSelect.end:
        return widget.activeColor;
    }
  }
}
