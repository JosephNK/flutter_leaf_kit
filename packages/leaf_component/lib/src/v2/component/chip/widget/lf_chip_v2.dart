import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../shared/widget/lf_inkwell_v2.dart';

/// A themed chip widget with toggle state.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LFChipThemeData] from the nearest [LFTheme]
///   3. Global tokens / hardcoded defaults
class LFChipV2 extends StatefulWidget {
  final String text;
  final bool selected;
  final Color? defaultColor;
  final Color? selectedColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final ValueChanged<bool>? onPressed;

  const LFChipV2({
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
  State<LFChipV2> createState() => _LFChipV2State();
}

class _LFChipV2State extends State<LFChipV2> {
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  void didUpdateWidget(covariant LFChipV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      setState(() {
        _selected = widget.selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final chipTheme = theme.chipTheme;

    final resolvedDefault =
        widget.defaultColor ?? chipTheme?.defaultColor ?? colors.onSurface;
    final resolvedSelected =
        widget.selectedColor ?? chipTheme?.selectedColor ?? colors.primary;
    final resolvedPadding = widget.padding ??
        chipTheme?.padding ??
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);
    final resolvedRadius = widget.borderRadius ?? chipTheme?.borderRadius ?? 50.0;

    final backgroundColor = !_selected
        ? resolvedDefault.withValues(alpha: 0.4)
        : resolvedSelected.withValues(alpha: 0.5);
    final textColor = !_selected
        ? resolvedDefault
        : resolvedSelected.withValues(alpha: 1.0);

    return Semantics(
      label: widget.text,
      selected: _selected,
      child: LFInkWellV2(
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
