import 'package:flutter/material.dart';

import '../../../../common/model/model.dart';
import 'leaf_checkbox.dart';

/// Callback for checkbox group selection changes.
typedef LeafCheckBoxGroupOnChanged = void Function(
  List<LeafDataItem> items,
  LeafDataItem changedItem,
);

/// A group of themed checkboxes (multi-select).
///
/// Uses [LeafDataItem] for item identity and display.
class LeafCheckBoxGroup extends StatefulWidget {
  final List<LeafDataItem> items;
  final List<LeafDataItem>? values;
  final Axis direction;
  final LeafCheckBoxAlign align;
  final MainAxisAlignment mainAxisAlignment;
  final double runSpacing;
  final LeafCheckBoxGroupOnChanged? onChanged;

  const LeafCheckBoxGroup({
    super.key,
    required this.items,
    this.values,
    this.direction = Axis.vertical,
    this.align = LeafCheckBoxAlign.left,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.runSpacing = 0.0,
    this.onChanged,
  });

  @override
  State<LeafCheckBoxGroup> createState() => _LeafCheckBoxGroupState();
}

class _LeafCheckBoxGroupState extends State<LeafCheckBoxGroup> {
  List<LeafDataItem> _values = [];

  @override
  void initState() {
    super.initState();
    _values = List.of(widget.values ?? []);
  }

  @override
  void didUpdateWidget(covariant LeafCheckBoxGroup oldWidget) {
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
      spacing: 4.0,
      runSpacing: 0.0,
      children: widget.items.map((item) {
        final isChecked = _values.contains(item);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: widget.runSpacing),
          child: LeafCheckBox(
            leading: item.leading,
            text: item.text,
            value: isChecked,
            align: widget.align,
            mainAxisAlignment: widget.mainAxisAlignment,
            onChanged: (checked) {
              setState(() {
                if (checked) {
                  _values.add(item);
                } else {
                  _values.remove(item);
                }
              });
              widget.onChanged?.call(_values, item);
            },
          ),
        );
      }).toList(),
    );
  }
}
