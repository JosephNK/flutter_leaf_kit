import 'package:flutter/material.dart';

import '../../../model/model.dart';
import 'lf_chip_v2.dart';

/// Callback for chip group selection changes.
typedef LFChipsOnChangedV2 = void Function(
  List<LFDataItem> items,
  LFDataItem changedItem,
);

/// A group of themed chips with single or multi-select support.
///
/// Uses [LFDataItem] for item identity, display, and optional per-item colors.
class LFChipsV2 extends StatefulWidget {
  final List<LFDataItem> items;
  final List<LFDataItem>? values;
  final Axis direction;
  final bool multiple;
  final LFChipsOnChangedV2? onChanged;

  const LFChipsV2({
    super.key,
    required this.items,
    this.values,
    this.direction = Axis.horizontal,
    this.multiple = true,
    this.onChanged,
  });

  @override
  State<LFChipsV2> createState() => _LFChipsV2State();
}

class _LFChipsV2State extends State<LFChipsV2> {
  List<LFDataItem> _values = [];

  @override
  void initState() {
    super.initState();
    _values = List.of(widget.values ?? []);
  }

  @override
  void didUpdateWidget(covariant LFChipsV2 oldWidget) {
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
        return LFChipV2(
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
