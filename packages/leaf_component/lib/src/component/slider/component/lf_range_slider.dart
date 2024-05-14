part of '../slider.dart';

class LFRangeSlider extends StatefulWidget {
  final RangeValues values;
  final double min;
  final double max;
  final RangeLabels? labels;
  final int? divisions;
  final ValueChanged<RangeValues>? onChanged;

  const LFRangeSlider({
    super.key,
    required this.values,
    this.min = 0,
    this.max = 1,
    this.labels,
    this.divisions,
    this.onChanged,
  });

  @override
  State<LFRangeSlider> createState() => _LFRangeSliderState();
}

class _LFRangeSliderState extends State<LFRangeSlider> {
  RangeLabels? _labels;

  @override
  void initState() {
    super.initState();

    _labels = RangeLabels(widget.values.start.toInt().toString(),
        widget.values.end.toInt().toString());
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: widget.values,
      min: widget.min,
      max: widget.max,
      divisions: widget.divisions,
      labels: widget.labels ?? _labels,
      onChanged: (newValue) {
        if (widget.labels == null) {
          setState(() {
            _labels = RangeLabels(newValue.start.toInt().toString(),
                newValue.end.toInt().toString());
          });
        }
        widget.onChanged?.call(newValue);
      },
    );
  }
}
