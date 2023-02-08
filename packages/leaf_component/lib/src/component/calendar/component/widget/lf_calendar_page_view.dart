part of lf_calendar_view;

typedef LFCalendarPageViewOnSizeChanged = void Function(Size size);

class LFCalendarPageView extends StatefulWidget {
  final LFCalendarCellBuilder cellBuilder;
  final DateTime pageDateTime;
  final TextStyle? dayTextStyle;
  final Color todayColor;
  final Color holidayColor;
  final double childAspectRatio;
  final ValueChanged<DateTime>? onSelected;
  final LFCalendarPageViewOnSizeChanged? onChangeSized;

  const LFCalendarPageView({
    Key? key,
    required this.cellBuilder,
    required this.pageDateTime,
    this.dayTextStyle,
    this.todayColor = Colors.purple,
    this.holidayColor = Colors.red,
    this.childAspectRatio = 1.0,
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
    final cellBuilder = widget.cellBuilder;
    final dayTextStyle = widget.dayTextStyle;
    final todayColor = widget.todayColor;
    final holidayColor = widget.holidayColor;
    final childAspectRatio = widget.childAspectRatio;
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
        final isDisabled = (widget.pageDateTime.month != dateTime.month);

        return LFCalendarPageCell(
          cellBuilder: cellBuilder,
          dateTime: dateTime,
          weekday: weekday,
          isDisabled: isDisabled,
          dayTextStyle: dayTextStyle,
          todayColor: todayColor,
          holidayColor: holidayColor,
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
