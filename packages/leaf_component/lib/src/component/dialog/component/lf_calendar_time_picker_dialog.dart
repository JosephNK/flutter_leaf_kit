part of lf_dialog;

typedef LFCalendarTimePickerOnOK = Function(
    LFCalendarPickerSelect select, DateTime dateTime);

class LFCalendarTimePickerDialog {
  static Future show(
    BuildContext context, {
    required LFCalendarPickerSelect pickerSelect,
    DateTime? startTime,
    DateTime? endTime,
    Color activeColor = Colors.purple,
    Color inactiveColor = Colors.grey,
    String startText = 'Start',
    String endText = 'End',
    String okText = 'OK',
    String validStartMessage = 'Please set the start time before the end time',
    String validEndMessage = 'Please set the end time after the start time',
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
          validStartMessage: validStartMessage,
          validEndMessage: validEndMessage,
          onOK: onOK,
        );
      },
    );
  }
}

class _CalendarTimePickerContent extends StatefulWidget {
  final LFCalendarPickerSelect pickerSelect;
  final DateTime? startTime;
  final DateTime? endTime;
  final Color activeColor;
  final Color inactiveColor;
  final String startText;
  final String endText;
  final String okText;
  final String validStartMessage;
  final String validEndMessage;
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
    this.validStartMessage = 'Please set the start time before the end time',
    this.validEndMessage = 'Please set the start time before the end time',
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
      case LFCalendarPickerSelect.none:
      case LFCalendarPickerSelect.start:
        _defaultTime = _startTime;
        break;
      case LFCalendarPickerSelect.end:
        _defaultTime = _endTime;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pickerSelect = widget.pickerSelect;
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
                        child: LFText(
                          _startTime.toMeridiemTimeString(),
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
                          _endTime.toMeridiemTimeString(),
                          style: TextStyle(
                              fontSize: 18.0, color: _getEndTimeColor()),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                ],
              ),
            ),

            /// DatePicker
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                initialDateTime: _defaultTime,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (value) {
                  _updateSelectTime(value);
                },
              ),
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

  void _updateSelectTime(DateTime? selectedTime) {
    if (selectedTime == null) return;
    final pickerSelect = widget.pickerSelect;
    final time = selectedTime;
    switch (pickerSelect) {
      case LFCalendarPickerSelect.none:
      case LFCalendarPickerSelect.start:
        setState(() {
          _startTime = time;
        });
        break;
      case LFCalendarPickerSelect.end:
        setState(() {
          _endTime = time;
        });
        break;
    }
  }

  void _onCallBackOK(BuildContext context) {
    final pickerSelect = widget.pickerSelect;

    late DateTime fromTime;
    late DateTime toTime;
    late DateTime resultTime;

    switch (pickerSelect) {
      case LFCalendarPickerSelect.none:
      case LFCalendarPickerSelect.start:
        fromTime = _startTime;
        toTime = _endTime;
        resultTime = _startTime;
        break;
      case LFCalendarPickerSelect.end:
        fromTime = _endTime;
        toTime = _startTime;
        resultTime = _endTime;
        break;
    }

    final fDay =
        LFDateTime.parse(fromTime.toDateTimeString(format: 'yyyy-MM-dd'));
    final tDay =
        LFDateTime.parse(toTime.toDateTimeString(format: 'yyyy-MM-dd'));

    if (fDay.isSameDate(tDay)) {
      final f = LFDateTime.parse(fromTime.toDateTimeString());
      final t = LFDateTime.parse(toTime.toDateTimeString());

      String? validMessage;

      switch (pickerSelect) {
        case LFCalendarPickerSelect.none:
          break;
        case LFCalendarPickerSelect.start:
          if (f.isAfter(t)) {
            validMessage = widget.validStartMessage;
          }
          break;
        case LFCalendarPickerSelect.end:
          if (f.isBefore(t)) {
            validMessage = widget.validEndMessage;
          }
          break;
      }

      if (validMessage != null) {
        LFToast.show(context, message: validMessage);
        return;
      }
    }

    widget.onOK?.call(pickerSelect, resultTime);

    Navigator.of(context).pop();
  }

  Color _getStartTimeColor() {
    final pickerSelect = widget.pickerSelect;
    switch (pickerSelect) {
      case LFCalendarPickerSelect.none:
        return widget.activeColor;
      case LFCalendarPickerSelect.start:
        return widget.activeColor;
      case LFCalendarPickerSelect.end:
        return widget.inactiveColor;
    }
  }

  Color _getEndTimeColor() {
    final pickerSelect = widget.pickerSelect;
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
