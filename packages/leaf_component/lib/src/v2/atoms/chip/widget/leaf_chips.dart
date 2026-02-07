import 'package:flutter/material.dart';

import '../../../../common/model/model.dart';
import 'leaf_chip.dart';

/// Callback for chip group selection changes.
typedef LeafChipsOnChanged = void Function(
  List<LeafDataItem> items,
  LeafDataItem changedItem,
);

/// A group of themed chips with single or multi-select support.
///
/// Uses [LeafDataItem] for item identity, display, and optional per-item colors.
class LeafChips extends StatefulWidget {
  final List<LeafDataItem> items;
  final List<LeafDataItem>? values;
  final Axis direction;
  final bool multiple;
  final LeafChipsOnChanged? onChanged;

  const LeafChips({
    super.key,
    required this.items,
    this.values,
    this.direction = Axis.horizontal,
    this.multiple = true,
    this.onChanged,
  });

  @override
  State<LeafChips> createState() => _LeafChipsState();
}

class _LeafChipsState extends State<LeafChips> {
  List<LeafDataItem> _values = [];

  @override
  void initState() {
    super.initState();
    _values = List.of(widget.values ?? []);
  }

  @override
  void didUpdateWidget(covariant LeafChips oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.values != widget.values) {
      setState(() {
        _values = List.of(widget.values ?? []);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: widget.direction,
      spacing: 10.0,
      runSpacing: 6.0,
      children: widget.items.map((item) {
        final selected = _values.contains(item);
        return LeafChip(
          text: item.text,
          defaultColor: item.color?.normal,
          selectedColor: item.color?.selected,
          selected: selected,
          onPressed: (selected) {
            setState(() {
              if (widget.multiple) {
                selected ? _values.add(item) : _values.remove(item);
              } else {
                _values = selected ? [item] : [];
              }
            });
            widget.onChanged?.call(_values, item);
          },
        );
      }).toList(),
    );
  }
}
