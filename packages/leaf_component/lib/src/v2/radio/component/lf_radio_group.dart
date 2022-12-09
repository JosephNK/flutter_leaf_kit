part of lf_radio;

typedef LFRadioGroupsOnChanged = Function(
  LFDataItem item,
  bool checked,
);

class LFRadioGroups extends StatefulWidget {
  final List<LFDataItem> items;
  final LFDataItem? value;
  final Axis direction;
  final LFRadioAlign align;
  final MainAxisAlignment mainAxisAlignment;
  final double runSpacing;
  final LFRadioGroupsOnChanged? onChanged;

  const LFRadioGroups({
    Key? key,
    required this.items,
    this.value,
    this.direction = Axis.vertical,
    this.align = LFRadioAlign.left,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.runSpacing = 0.0,
    this.onChanged,
  }) : super(key: key);

  @override
  State<LFRadioGroups> createState() => _LFRadioGroupsState();
}

class _LFRadioGroupsState extends State<LFRadioGroups> {
  LFDataItem? _value;

  @override
  void initState() {
    super.initState();

    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant LFRadioGroups oldWidget) {
    if (oldWidget.value != widget.value) {
      setState(() {
        _value = widget.value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final direction = widget.direction;
    final align = widget.align;
    final mainAxisAlignment = widget.mainAxisAlignment;
    final runSpacing = widget.runSpacing;
    final onChanged = widget.onChanged;

    final itemWidgets = [
      ...items.map((item) {
        final id = item.id;
        final text = item.text;
        final leading = item.leading;
        final isChecked = (_value?.id == id);

        return Padding(
          padding: EdgeInsets.symmetric(vertical: runSpacing),
          child: LFRadio(
            leading: leading,
            text: text,
            value: isChecked,
            align: align,
            mainAxisAlignment: mainAxisAlignment,
            onChanged: (checked) {
              onChanged?.call(item, checked);
            },
          ),
        );
      }).toList(),
    ];

    return Wrap(
      direction: direction,
      spacing: 4.0,
      runSpacing: 0.0,
      children: itemWidgets,
    );
  }
}
