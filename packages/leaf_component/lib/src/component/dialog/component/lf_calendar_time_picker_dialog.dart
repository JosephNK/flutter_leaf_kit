part of lf_dialog;

enum LFCalendarTimePickerSelect { start, end }

typedef LFCalendarTimePickerOnOK = Function(
    LFCalendarTimePickerSelect select, DateTime dateTime);

class LFCalendarTimePickerDialog {
  static Future show(
    BuildContext context, {
    required LFCalendarTimePickerSelect pickerSelect,
    DateTime? startTime,
    DateTime? endTime,
    Color activeColor = Colors.purple,
    Color inactiveColor = Colors.grey,
    String startText = 'Start',
    String endText = 'End',
    String okText = 'OK',
    LFCalendarTimePickerOnOK? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _CalendarTimePickerContent(
          pickerSelect: pickerSelect,
          startTime: startTime,
          endTime: endTime,
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

class _CalendarTimePickerContent extends StatefulWidget {
  final LFCalendarTimePickerSelect pickerSelect;
  final DateTime? startTime;
  final DateTime? endTime;
  final Color activeColor;
  final Color inactiveColor;
  final String startText;
  final String endText;
  final String okText;
  final LFCalendarTimePickerOnOK? onOK;

  const _CalendarTimePickerContent({
    Key? key,
    required this.pickerSelect,
    this.startTime,
    this.endTime,
    this.activeColor = Colors.purple,
    this.inactiveColor = Colors.grey,
    this.startText = 'Start',
    this.endText = 'End',
    this.okText = 'OK',
    this.onOK,
  }) : super(key: key);

  @override
  State<_CalendarTimePickerContent> createState() =>
      _CalendarTimePickerContentState();
}

class _CalendarTimePickerContentState
    extends State<_CalendarTimePickerContent> {
  late DateTime _startTime;
  late DateTime _endTime;
  late DateTime _defaultTime;

  @override
  void initState() {
    super.initState();

    _startTime = widget.startTime ?? LFDateTime.today();
    _endTime = widget.endTime ?? LFDateTime.today();
    final pickerSelect = widget.pickerSelect;
    switch (pickerSelect) {
      case LFCalendarTimePickerSelect.start:
        _defaultTime = _startTime;
        break;
      case LFCalendarTimePickerSelect.end:
        _defaultTime = _endTime;
        break;
    }
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
                        _startTime.toMeridiemTimeString(context),
                        style: TextStyle(
                            fontSize: 18.0, color: _getStartTimeColor()),
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
                        _endTime.toMeridiemTimeString(context),
                        style: TextStyle(
                            fontSize: 18.0, color: _getEndTimeColor()),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                initialDateTime: _defaultTime,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (value) {
                  final pickerSelect = widget.pickerSelect;
                  switch (pickerSelect) {
                    case LFCalendarTimePickerSelect.start:
                      setState(() {
                        _startTime = value;
                      });
                      break;
                    case LFCalendarTimePickerSelect.end:
                      setState(() {
                        _endTime = value;
                      });
                      break;
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final pickerSelect = widget.pickerSelect;
                      switch (pickerSelect) {
                        case LFCalendarTimePickerSelect.start:
                          widget.onOK?.call(pickerSelect, _startTime);
                          break;
                        case LFCalendarTimePickerSelect.end:
                          widget.onOK?.call(pickerSelect, _endTime);
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

  Color _getStartTimeColor() {
    final pickerSelect = widget.pickerSelect;
    switch (pickerSelect) {
      case LFCalendarTimePickerSelect.start:
        return widget.activeColor;
      case LFCalendarTimePickerSelect.end:
        return widget.inactiveColor;
    }
  }

  Color _getEndTimeColor() {
    final pickerSelect = widget.pickerSelect;
    switch (pickerSelect) {
      case LFCalendarTimePickerSelect.start:
        return widget.inactiveColor;
      case LFCalendarTimePickerSelect.end:
        return widget.activeColor;
    }
  }
}
