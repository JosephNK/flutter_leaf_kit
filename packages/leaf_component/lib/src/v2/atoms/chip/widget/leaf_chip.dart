import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../../../_shared/widget/leaf_inkwell.dart';

/// A themed chip widget with toggle state.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LeafChipThemeData] from the nearest [LeafTheme]
///   3. Global tokens / hardcoded defaults
class LeafChip extends StatefulWidget {
  final String text;
  final bool selected;
  final Color? defaultColor;
  final Color? selectedColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final ValueChanged<bool>? onPressed;

  const LeafChip({
    super.key,
    required this.text,
    this.selected = false,
    this.defaultColor,
    this.selectedColor,
    this.padding,
    this.borderRadius,
    this.onPressed,
  });

  @override
  State<LeafChip> createState() => _LeafChipState();
}

class _LeafChipState extends State<LeafChip> {
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  void didUpdateWidget(covariant LeafChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      setState(() {
        _selected = widget.selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final chipTheme = theme.chipTheme;

    final resolvedDefault =
        widget.defaultColor ?? chipTheme?.defaultColor ?? colors.onSurface;
    final resolvedSelected =
        widget.selectedColor ?? chipTheme?.selectedColor ?? colors.primary;
    final resolvedPadding =
        widget.padding ??
        chipTheme?.padding ??
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);
    final resolvedRadius =
        widget.borderRadius ?? chipTheme?.borderRadius ?? 50.0;

    final backgroundColor = !_selected
        ? resolvedDefault.withValues(alpha: 0.4)
        : resolvedSelected.withValues(alpha: 0.5);
    final textColor = !_selected
        ? resolvedDefault
        : resolvedSelected.withValues(alpha: 1.0);

    return Semantics(
      label: widget.text,
      selected: _selected,
      child: LeafInkWell(
        onTap: () => widget.onPressed?.call(!_selected),
        child: Container(
          padding: resolvedPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(resolvedRadius)),
            color: backgroundColor,
          ),
          child: Text(widget.text, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }
}
