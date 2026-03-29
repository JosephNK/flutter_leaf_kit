import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../../../shared/widget/leaf_inkwell.dart';

/// Alignment of the checkbox icon relative to the label text.
enum LeafCheckBoxAlign { left, right }

/// A themed checkbox widget with icon and optional label.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LeafCheckBoxThemeData] from the nearest [LeafTheme]
///   3. Global tokens / hardcoded defaults
@immutable
class LeafCheckBox extends StatelessWidget {
  final Widget? leading;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final bool value;
  final String? text;
  final TextStyle? textStyle;
  final double? runSpacing;
  final LeafCheckBoxAlign align;
  final MainAxisAlignment mainAxisAlignment;
  final Color? activeColor;
  final Color? inactiveColor;
  final ValueChanged<bool>? onChanged;

  const LeafCheckBox({
    super.key,
    this.leading,
    this.activeIcon,
    this.inactiveIcon,
    this.value = false,
    this.text,
    this.textStyle,
    this.runSpacing,
    this.align = LeafCheckBoxAlign.left,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.activeColor,
    this.inactiveColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final cbTheme = theme.checkBoxTheme;

    final resolvedActiveColor =
        activeColor ?? cbTheme?.activeColor ?? colors.primary;
    final resolvedInactiveColor =
        inactiveColor ?? cbTheme?.inactiveColor ?? colors.inactive;
    final resolvedSpacing = runSpacing ?? cbTheme?.runSpacing ?? 4.0;

    final resolvedActiveIcon =
        activeIcon ?? Icon(Icons.check_box, color: resolvedActiveColor);
    final resolvedInactiveIcon =
        inactiveIcon ??
        Icon(Icons.check_box_outline_blank, color: resolvedInactiveColor);

    final children = [
      value ? resolvedActiveIcon : resolvedInactiveIcon,
      if (text != null && text!.isNotEmpty)
        Padding(
          padding: align == LeafCheckBoxAlign.left
              ? EdgeInsets.only(left: resolvedSpacing)
              : EdgeInsets.only(right: resolvedSpacing),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ?leading,
              Text(text!, style: textStyle),
            ],
          ),
        ),
    ];

    return Semantics(
      checked: value,
      label: text,
      child: LeafInkWell(
        onTap: () => onChanged?.call(!value),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: align == LeafCheckBoxAlign.left
              ? children
              : children.reversed.toList(),
        ),
      ),
    );
  }
}
