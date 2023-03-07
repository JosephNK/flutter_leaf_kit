part of lf_dialog;

enum LFCalendarPickerSelect { start, end }

typedef LFCalendarPickerOnOK = Function(
    LFCalendarPickerSelect select, DateTime dateTime);

class LFCalendarPickerDialog {
  static Future show(
    BuildContext context, {
    required LFCalendarPickerSelect pickerSelect,
    DateTime? startDate,
    DateTime? endDate,
    Color activeColor = Colors.purple,
    Color inactiveColor = Colors.grey,
    String startText = 'Start',
    String endText = 'End',
    String okText = 'OK',
    LFCalendarPickerOnOK? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _CalendarPickerContent(
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

class _CalendarPickerContent extends StatefulWidget {
  final LFCalendarPickerSelect pickerSelect;
  final DateTime? startDate;
  final DateTime? endDate;
  final Color activeColor;
  final Color inactiveColor;
  final String startText;
  final String endText;
  final String okText;
  final LFCalendarPickerOnOK? onOK;

  const _CalendarPickerContent({
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
  State<_CalendarPickerContent> createState() => _CalendarPickerContentState();
}

class _CalendarPickerContentState extends State<_CalendarPickerContent> {
  late LFCalendarController _controller;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();

    _controller = LFCalendarController();
    _startDate = widget.startDate ?? LFDateTime.today();
    _endDate = widget.endDate ?? LFDateTime.today();
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
                        _startDate.toShortDateTimeString(),
                        style: TextStyle(
                            fontSize: 20.0, color: _getStartDateColor()),
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
                        _endDate.toShortDateTimeString(),
                        style: TextStyle(
                            fontSize: 20.0, color: _getEndDateColor()),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            LFCalendarView(
              controller: _controller,
              childAspectRatio: 1.0,
              todayColor: widget.activeColor,
              selectedColor: widget.activeColor,
              weekDays: const ['일', '월', '화', '수', '목', '금', '토'],
              yearUnit: '년',
              monthUnit: '월',
              showToday: false,
              cellBuilder: (context, dateTime, size) {
                return Column();
              },
              onMonthChanged:
                  (month, startDateTime, endDateTime, selectedDate) {},
              onMonthOnTap: (month) {
                print('onMonthOnTap: $month');
              },
              onDateSelected: (dateTimes) {
                final pickerSelect = widget.pickerSelect;
                switch (pickerSelect) {
                  case LFCalendarPickerSelect.start:
                    setState(() {
                      _startDate = dateTimes.first;
                    });
                    break;
                  case LFCalendarPickerSelect.end:
                    setState(() {
                      _endDate = dateTimes.first;
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
                        case LFCalendarPickerSelect.start:
                          widget.onOK?.call(pickerSelect, _startDate);
                          break;
                        case LFCalendarPickerSelect.end:
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
      case LFCalendarPickerSelect.start:
        return widget.activeColor;
      case LFCalendarPickerSelect.end:
        return widget.inactiveColor;
    }
  }

  Color _getEndDateColor() {
    final pickerSelect = widget.pickerSelect;
    switch (pickerSelect) {
      case LFCalendarPickerSelect.start:
        return widget.inactiveColor;
      case LFCalendarPickerSelect.end:
        return widget.activeColor;
    }
  }
}
