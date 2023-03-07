part of lf_calendar_view;

typedef LFCalendarPageViewOnSizeChanged = void Function(Size size);

class LFCalendarPageView extends StatefulWidget {
  final DateTime pageDateTime;
  final List<DateTime> selectedDateTimes;
  final LFCalendarCellBuilder? cellBuilder;
  final TextStyle? dayTextStyle;
  final Color todayColor;
  final Color selectedColor;
  final Color holidayColor;
  final double childAspectRatio;
  final bool showToday;
  final ValueChanged<DateTime>? onSelected;
  final LFCalendarPageViewOnSizeChanged? onChangeSized;

  const LFCalendarPageView({
    Key? key,
    required this.pageDateTime,
    required this.selectedDateTimes,
    this.cellBuilder,
    this.dayTextStyle,
    this.todayColor = Colors.purple,
    this.selectedColor = Colors.purpleAccent,
    this.holidayColor = Colors.red,
    this.childAspectRatio = 1.0,
    this.showToday = true,
    this.onSelected,
    this.onChangeSized,
  }) : super(key: key);

  @override
  State<LFCalendarPageView> createState() => _LFCalendarPageViewState();
}

class _LFCalendarPageViewState extends State<LFCalendarPageView> {
  final GlobalKey _gridKey = GlobalKey();
  List<DateTime> _dateTimes = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBoxRed =
          _gridKey.currentContext!.findRenderObject() as RenderBox;
      final size = renderBoxRed.size;
      widget.onChangeSized?.call(size);
    });

    setState(() {
      _dateTimes = widget.pageDateTime.daysInMonth();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageDateTime = widget.pageDateTime;
    final selectedDateTimes = widget.selectedDateTimes;
    final cellBuilder = widget.cellBuilder;
    final dayTextStyle = widget.dayTextStyle;
    final todayColor = widget.todayColor;
    final selectedColor = widget.selectedColor;
    final holidayColor = widget.holidayColor;
    final childAspectRatio = widget.childAspectRatio;
    final showToday = widget.showToday;
    final onSelected = widget.onSelected;

    return GridView.builder(
      key: _gridKey,
      itemCount: _dateTimes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: childAspectRatio,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final dateTime = _dateTimes[index];
        final weekday = dateTime.weekday;
        // final isDisabled =
        //     ((widget.firstDateTime.month ?? -1) != dateTime.month) ||
        //         (weekday == 6) ||
        //         (weekday == 7) ||
        //         (dateTime.isBefore(DateTime.now()));
        final isDisabled = (pageDateTime.month != dateTime.month);

        return LFCalendarPageCell(
          dateTime: dateTime,
          selectedDateTimes: selectedDateTimes,
          cellBuilder: cellBuilder,
          weekday: weekday,
          isDisabled: isDisabled,
          dayTextStyle: dayTextStyle,
          todayColor: todayColor,
          selectedColor: selectedColor,
          holidayColor: holidayColor,
          showToday: showToday,
          onSelected: onSelected,
        );
        // final date = _dateTimes[index];
        // final weekday = date.weekday;
        //
        // final isDisabled =
        //     ((widget.firstDateTime?.month ?? -1) != date.month) ||
        //         (weekday == 6) ||
        //         (weekday == 7) ||
        //         (date.isBefore(DateTime.now()));
        //
        // final isSelected = (widget.selectedDateTimes ?? []).contains(date);
        //
        // var cellType = NanoCalendarCellType.none;
        // if (isDisabled) {
        //   cellType = NanoCalendarCellType.disabled;
        // }
        //
        // final filtered = widget.items
        //     .where((element) {
        //   return element.date.isSameDate(date);
        // })
        //     .where((element) => element != null)
        //     .toList();
        //
        // NanoCalendarItem item;
        // if (filtered.isNotEmpty) {
        //   item = filtered.first;
        //   cellType = item.type;
        // }
        //
        // return NanoCalendarCell(
        //   builder: widget.builder,
        //   cellType: cellType,
        //   date: date,
        //   item: item,
        //   isSelected: isSelected,
        //   onTap: (date, item, cellType) {
        //     widget.onCellSeleted?.call(date, item, cellType);
        //   },
        // );
      },
    );
  }
}
