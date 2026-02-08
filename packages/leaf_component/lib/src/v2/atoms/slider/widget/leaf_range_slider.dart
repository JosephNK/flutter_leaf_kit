import 'package:flutter/material.dart';

import '../../../../common/theme/leaf_theme.dart';

/// A themed range slider with two thumbs.
///
/// Wraps Flutter's [RangeSlider] with 3-level cascade theming and auto-labels.
class LeafRangeSlider extends StatefulWidget {
  final RangeValues values;
  final double min;
  final double max;
  final RangeLabels? labels;
  final int? divisions;
  final Color? activeColor;
  final Color? inactiveColor;
  final ValueChanged<RangeValues>? onChanged;

  const LeafRangeSlider({
    super.key,
    required this.values,
    this.min = 0,
    this.max = 1,
    this.labels,
    this.divisions,
    this.activeColor,
    this.inactiveColor,
    this.onChanged,
  });

  @override
  State<LeafRangeSlider> createState() => _LeafRangeSliderState();
}

class _LeafRangeSliderState extends State<LeafRangeSlider> {
  RangeLabels? _labels;

  @override
  void initState() {
    super.initState();
    _labels = RangeLabels(
      widget.values.start.toInt().toString(),
      widget.values.end.toInt().toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final sliderTheme = theme.sliderTheme;

    final resolvedActive =
        widget.activeColor ?? sliderTheme?.activeTrackColor ?? colors.primary;
    final resolvedInactive =
        widget.inactiveColor ??
        sliderTheme?.inactiveTrackColor ??
        colors.inactive;

    return Semantics(
      label: 'Range slider',
      value:
          '${widget.values.start.toStringAsFixed(1)} to ${widget.values.end.toStringAsFixed(1)}',
      child: SliderTheme(
        data: SliderThemeData(
          activeTrackColor: resolvedActive,
          inactiveTrackColor: resolvedInactive,
        ),
        child: RangeSlider(
          values: widget.values,
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          labels: widget.labels ?? _labels,
          onChanged: (newValues) {
            if (widget.labels == null) {
              setState(() {
                _labels = RangeLabels(
                  newValues.start.toInt().toString(),
                  newValues.end.toInt().toString(),
                );
              });
            }
            widget.onChanged?.call(newValues);
          },
        ),
      ),
    );
  }
}
