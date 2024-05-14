part of '../chip.dart';

class LFChip extends StatefulWidget {
  final String text;
  final bool selected;
  final Color? defaultColor;
  final Color? selectedColor;
  final ValueChanged<bool>? onPressed;

  const LFChip({
    super.key,
    required this.text,
    this.selected = false,
    this.defaultColor,
    this.selectedColor,
    this.onPressed,
  });

  @override
  State<LFChip> createState() => _LFChipState();
}

class _LFChipState extends State<LFChip> {
  bool _selected = false;

  @override
  void initState() {
    super.initState();

    _selected = widget.selected;
  }

  @override
  void didUpdateWidget(covariant LFChip oldWidget) {
    if (oldWidget.selected != widget.selected) {
      setState(() {
        _selected = widget.selected;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selected;
    final defaultColor = widget.defaultColor ?? Colors.black;
    final selectedColor = widget.selectedColor ?? Colors.blueAccent;
    final onPressed = widget.onPressed;

    final backgroundColor = !selected
        ? defaultColor.withOpacity(0.4)
        : selectedColor.withOpacity(0.5);
    final textColor = !selected ? defaultColor : selectedColor.withOpacity(1.0);

    return LFInkWell(
      onTap: () {
        onPressed?.call(!_selected);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(50.0),
          ),
          color: backgroundColor,
        ),
        child: LFText(
          widget.text,
          color: textColor,
        ),
      ),
    );
  }
}
