import 'package:flutter/material.dart';

import '../../../../common/model/model.dart';
import 'leaf_radio.dart';

/// Callback for radio group selection changes.
typedef LeafRadioGroupOnChanged =
    void Function(LeafDataItem item, bool checked);

/// A group of themed radio buttons (single-select).
///
/// Uses [LeafDataItem] for item identity and display.
class LeafRadioGroup extends StatefulWidget {
  final List<LeafDataItem> items;
  final LeafDataItem? value;
  final Axis direction;
  final LeafRadioAlign align;
  final MainAxisAlignment mainAxisAlignment;
  final double runSpacing;
  final LeafRadioGroupOnChanged? onChanged;

  const LeafRadioGroup({
    super.key,
    required this.items,
    this.value,
    this.direction = Axis.vertical,
    this.align = LeafRadioAlign.left,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.runSpacing = 0.0,
    this.onChanged,
  });

  @override
  State<LeafRadioGroup> createState() => _LeafRadioGroupState();
}

class _LeafRadioGroupState extends State<LeafRadioGroup> {
  LeafDataItem? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant LeafRadioGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        _value = widget.value;
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
        final isChecked = _value?.id == item.id;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: widget.runSpacing),
          child: LeafRadio(
            leading: item.leading,
            text: item.text,
            value: isChecked,
            align: widget.align,
            mainAxisAlignment: widget.mainAxisAlignment,
            onChanged: (checked) {
              setState(() {
                _value = checked ? item : null;
              });
              widget.onChanged?.call(item, checked);
            },
          ),
        );
      }).toList(),
    );
  }
}
