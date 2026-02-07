import 'package:flutter/material.dart';

import '../../../../common/theme/leaf_theme.dart';

/// A themed single-value slider.
///
/// Wraps Flutter's [Slider] with 3-level cascade theming and auto-label.
class LeafSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final String? label;
  final int? divisions;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final ValueChanged<double>? onChanged;

  const LeafSlider({
    super.key,
    required this.value,
    this.min = 0,
    this.max = 1,
    this.label,
    this.divisions,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.onChanged,
  });

  @override
  State<LeafSlider> createState() => _LeafSliderState();
}

class _LeafSliderState extends State<LeafSlider> {
  String? _label;

  @override
  void initState() {
    super.initState();
    _label = widget.value.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final sliderTheme = theme.sliderTheme;

    final resolvedActive =
        widget.activeColor ?? sliderTheme?.activeTrackColor ?? colors.primary;
    final resolvedInactive = widget.inactiveColor ??
        sliderTheme?.inactiveTrackColor ??
        colors.inactive;
    final resolvedThumb =
        widget.thumbColor ?? sliderTheme?.thumbColor ?? colors.primary;

    return Semantics(
      label: 'Slider',
      value: widget.value.toStringAsFixed(1),
      child: SliderTheme(
        data: SliderThemeData(
          activeTrackColor: resolvedActive,
          inactiveTrackColor: resolvedInactive,
          thumbColor: resolvedThumb,
        ),
        child: Slider(
          value: widget.value,
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          label: widget.label ?? _label,
          onChanged: (newValue) {
            if (widget.label == null) {
              setState(() {
                _label = newValue.toInt().toString();
              });
            }
            widget.onChanged?.call(newValue);
          },
        ),
      ),
    );
  }
}
