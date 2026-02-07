import 'package:flutter/material.dart';

import '../../../../common/model/model.dart';
import 'lf_radio_v2.dart';

/// Callback for radio group selection changes.
typedef LFRadioGroupOnChangedV2 = void Function(
  LFDataItem item,
  bool checked,
);

/// A group of themed radio buttons (single-select).
///
/// Uses [LFDataItem] for item identity and display.
class LFRadioGroupV2 extends StatefulWidget {
  final List<LFDataItem> items;
  final LFDataItem? value;
  final Axis direction;
  final LFRadioAlignV2 align;
  final MainAxisAlignment mainAxisAlignment;
  final double runSpacing;
  final LFRadioGroupOnChangedV2? onChanged;

  const LFRadioGroupV2({
    super.key,
    required this.items,
    this.value,
    this.direction = Axis.vertical,
    this.align = LFRadioAlignV2.left,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.runSpacing = 0.0,
    this.onChanged,
  });

  @override
  State<LFRadioGroupV2> createState() => _LFRadioGroupV2State();
}

class _LFRadioGroupV2State extends State<LFRadioGroupV2> {
  LFDataItem? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant LFRadioGroupV2 oldWidget) {
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
          child: LFRadioV2(
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
