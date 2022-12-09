part of ds_slider;

class DSRangeSlider extends StatefulWidget {
  final RangeValues values;
  final double min;
  final double max;
  final RangeLabels? labels;
  final int? divisions;
  final ValueChanged<RangeValues>? onChanged;

  const DSRangeSlider({
    Key? key,
    required this.values,
    this.min = 0,
    this.max = 1,
    this.labels,
    this.divisions,
    this.onChanged,
  }) : super(key: key);

  @override
  State<DSRangeSlider> createState() => _DSRangeSliderState();
}

class _DSRangeSliderState extends State<DSRangeSlider> {
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
