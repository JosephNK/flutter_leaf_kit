part of ds_slider;

class DSSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final String? label;
  final int? divisions;
  final ValueChanged<double>? onChanged;

  const DSSlider({
    Key? key,
    required this.value,
    this.min = 0,
    this.max = 1,
    this.label,
    this.divisions,
    this.onChanged,
  }) : super(key: key);

  @override
  State<DSSlider> createState() => _DSSliderState();
}

class _DSSliderState extends State<DSSlider> {
  String? _label;

  @override
  void initState() {
    super.initState();

    _label = widget.value.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
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
    );
  }
}
