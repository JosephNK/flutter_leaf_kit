import 'package:flutter/material.dart';

import '../../../model/model.dart';
import 'lf_checkbox_v2.dart';

/// Callback for checkbox group selection changes.
typedef LFCheckBoxGroupOnChangedV2 = void Function(
  List<LFDataItem> items,
  LFDataItem changedItem,
);

/// A group of themed checkboxes (multi-select).
///
/// Uses [LFDataItem] for item identity and display.
class LFCheckBoxGroupV2 extends StatefulWidget {
  final List<LFDataItem> items;
  final List<LFDataItem>? values;
  final Axis direction;
  final LFCheckBoxAlignV2 align;
  final MainAxisAlignment mainAxisAlignment;
  final double runSpacing;
  final LFCheckBoxGroupOnChangedV2? onChanged;

  const LFCheckBoxGroupV2({
    super.key,
    required this.items,
    this.values,
    this.direction = Axis.vertical,
    this.align = LFCheckBoxAlignV2.left,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.runSpacing = 0.0,
    this.onChanged,
  });

  @override
  State<LFCheckBoxGroupV2> createState() => _LFCheckBoxGroupV2State();
}

class _LFCheckBoxGroupV2State extends State<LFCheckBoxGroupV2> {
  List<LFDataItem> _values = [];

  @override
  void initState() {
    super.initState();
    _values = List.of(widget.values ?? []);
  }

  @override
  void didUpdateWidget(covariant LFCheckBoxGroupV2 oldWidget) {
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
          child: LFCheckBoxV2(
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
