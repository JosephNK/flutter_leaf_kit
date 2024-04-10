part of '../lf_calendar_view.dart';

class LFCalendarMonthDatePicker {
  static Future<DateTime?> show(
    BuildContext context, {
    required DateTime date,
    DateTime? minDate,
    DateTime? maxDate,
    Color activeColor = Colors.purple,
    String okText = 'OK',
    ValueChanged<DateTime>? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _LFCalendarMonthContent(
          date: date,
          minDate: minDate,
          maxDate: maxDate,
          activeColor: activeColor,
          okText: okText,
          dialog: true,
          onOK: onOK,
        );
      },
    );
  }
}

class _LFCalendarMonthContent extends StatefulWidget {
  final DateTime date;
  final DateTime? minDate;
  final DateTime? maxDate;
  final Color activeColor;
  final String okText;
  final bool dialog;
  final ValueChanged<DateTime>? onOK;

  const _LFCalendarMonthContent({
    required this.date,
    this.minDate,
    this.maxDate,
    this.activeColor = Colors.purple,
    this.okText = 'OK',
    this.dialog = true,
    this.onOK,
  });

  @override
  State<_LFCalendarMonthContent> createState() =>
      _LFCalendarMonthContentState();
}

class _LFCalendarMonthContentState extends State<_LFCalendarMonthContent> {
  String? _selectedYear;
  String? _selectedMonth;

  late DateTime _date;
  late DateTime _minDate;
  late DateTime _maxDate;
  late List<int> _years;
  late int _yearIndex;
  late int _yearDif;

  final kItemExtent = 40.0;

  @override
  void initState() {
    super.initState();

    _date = widget.date;
    _minDate = widget.minDate ?? DateTime(1900);
    _maxDate = widget.maxDate ?? DateTime(2200);

    _yearDif = _maxDate.year - _minDate.year;
    _years = List<int>.generate(_yearDif, (i) => i + _minDate.year);
    _yearIndex = _years.indexWhere((y) => y == _date.year);

    _selectedYear = _date.year.toString();
    _selectedMonth = _date.month.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150.0,
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker.builder(
                    scrollController:
                        FixedExtentScrollController(initialItem: _yearIndex),
                    childCount: _yearDif,
                    itemExtent: kItemExtent,
                    onSelectedItemChanged: (index) {
                      final selectedYear = _years[index].toString();
                      _selectedYear = selectedYear;
                    },
                    itemBuilder: (context, index) {
                      final dateText =
                          (_minDate.year + index).toString().padLeft(4, '0');

                      return Center(
                        child: Text(
                          dateText,
                          textAlign: TextAlign.center,
                          style: CupertinoTheme.of(context)
                              .textTheme
                              .dateTimePickerTextStyle,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: CupertinoPicker.builder(
                    scrollController: FixedExtentScrollController(
                        initialItem: _date.month - 1),
                    childCount: 12,
                    itemExtent: kItemExtent,
                    onSelectedItemChanged: (index) {
                      final selectedMonth =
                          (index + 1).toString().padLeft(2, '0');
                      _selectedMonth = selectedMonth;
                    },
                    itemBuilder: (context, index) {
                      final dateText = (index + 1).toString().padLeft(2, '0');

                      return Center(
                        child: Text(
                          dateText,
                          textAlign: TextAlign.center,
                          style: CupertinoTheme.of(context)
                              .textTheme
                              .dateTimePickerTextStyle,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final dateTime =
                        LFDateTime.parse('$_selectedYear-$_selectedMonth-01');
                    widget.onOK?.call(dateTime);
                    Navigator.pop(context, dateTime);
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
    );

    if (!widget.dialog) {
      return child;
    }

    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4.0,
      backgroundColor: Colors.white,
      child: child,
    );
  }
}
