part of '../lf_checkbox.dart';

typedef LFCheckboxGroupsOnChanged = Function(
  List<LFDataItem> items,
  LFDataItem changeItem,
);

class LFCheckboxGroups extends StatefulWidget {
  final List<LFDataItem> items;
  final List<LFDataItem>? values;
  final Axis direction;
  final LFCheckBoxAlign align;
  final MainAxisAlignment mainAxisAlignment;
  final double runSpacing;
  final LFCheckboxGroupsOnChanged? onChanged;

  const LFCheckboxGroups({
    super.key,
    required this.items,
    this.values,
    this.direction = Axis.vertical,
    this.align = LFCheckBoxAlign.left,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.runSpacing = 0.0,
    this.onChanged,
  });

  @override
  State<LFCheckboxGroups> createState() => _LFCheckboxGroupsState();
}

class _LFCheckboxGroupsState extends State<LFCheckboxGroups> {
  List<LFDataItem> _values = [];

  @override
  void initState() {
    super.initState();

    _values = widget.values ?? [];
  }

  @override
  void didUpdateWidget(covariant LFCheckboxGroups oldWidget) {
    if (oldWidget.values != widget.values) {
      setState(() {
        _values = widget.values ?? [];
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
        final text = item.text;
        final leading = item.leading;
        final isChecked = _values.contains(item);

        return Padding(
          padding: EdgeInsets.symmetric(vertical: runSpacing),
          child: LFCheckBox(
            leading: leading,
            text: text,
            value: isChecked,
            align: align,
            mainAxisAlignment: mainAxisAlignment,
            onChanged: (checked) {
              checked ? _values.add(item) : _values.remove(item);
              onChanged?.call(_values, item);
            },
          ),
        );
      }),
    ];

    return Wrap(
      direction: direction,
      spacing: 4.0,
      runSpacing: 0.0,
      children: itemWidgets,
    );
  }
}
