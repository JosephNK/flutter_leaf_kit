part of '../lf_chip.dart';

typedef LFChipsOnChanged = Function(
  List<LFDataItem> items,
  LFDataItem changeItem,
);

class LFChips extends StatefulWidget {
  final List<LFDataItem> items;
  final List<LFDataItem>? values;
  final Axis direction;
  final bool multiple;
  final LFChipsOnChanged? onChanged;

  const LFChips({
    super.key,
    required this.items,
    this.values,
    this.direction = Axis.horizontal,
    this.multiple = true,
    this.onChanged,
  });

  @override
  State<LFChips> createState() => _LFChipsState();
}

class _LFChipsState extends State<LFChips> {
  List<LFDataItem> _values = [];

  @override
  void initState() {
    super.initState();

    _values = widget.values ?? [];
  }

  @override
  void didUpdateWidget(covariant LFChips oldWidget) {
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
    final multiple = widget.multiple;
    final onChanged = widget.onChanged;

    final itemWidgets = items.map((item) {
      final text = item.text;
      final color = item.color;
      final normalColor = color?.normal;
      final selectedColor = color?.selected;
      final selected = _values.contains(item);
      return LFChip(
        text: text,
        defaultColor: normalColor,
        selectedColor: selectedColor,
        selected: selected,
        onPressed: (selected) {
          if (multiple) {
            selected ? _values.add(item) : _values.remove(item);
          } else {
            selected ? _values = [item] : _values = [];
          }
          onChanged?.call(_values, item);
        },
      );
    }).toList();

    return Wrap(
      direction: widget.direction,
      spacing: 10.0,
      runSpacing: 6.0,
      children: itemWidgets,
    );
  }
}
