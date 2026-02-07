import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../shared/widget/lf_inkwell_v2.dart';

/// Alignment of the radio icon relative to the label text.
enum LFRadioAlignV2 { left, right }

/// A themed radio button widget with icon and optional label.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LFRadioThemeData] from the nearest [LFTheme]
///   3. Global tokens / hardcoded defaults
@immutable
class LFRadioV2 extends StatelessWidget {
  final Widget? leading;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final bool value;
  final String? text;
  final TextStyle? textStyle;
  final LFRadioAlignV2 align;
  final MainAxisAlignment mainAxisAlignment;
  final Color? activeColor;
  final Color? inactiveColor;
  final ValueChanged<bool>? onChanged;

  const LFRadioV2({
    super.key,
    this.leading,
    this.activeIcon,
    this.inactiveIcon,
    this.value = false,
    this.text,
    this.textStyle,
    this.align = LFRadioAlignV2.left,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.activeColor,
    this.inactiveColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final radioTheme = theme.radioTheme;

    final resolvedActiveColor =
        activeColor ?? radioTheme?.activeColor ?? colors.primary;
    final resolvedInactiveColor =
        inactiveColor ?? radioTheme?.inactiveColor ?? colors.inactive;

    final resolvedActiveIcon = activeIcon ??
        Icon(Icons.radio_button_checked, color: resolvedActiveColor);
    final resolvedInactiveIcon = inactiveIcon ??
        Icon(Icons.radio_button_off, color: resolvedInactiveColor);

    final children = [
      value ? resolvedActiveIcon : resolvedInactiveIcon,
      if (text != null && text!.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) leading!,
              Text(text!, style: textStyle),
            ],
          ),
        ),
    ];

    return Semantics(
      checked: value,
      label: text,
      child: LFInkWellV2(
        onTap: () => onChanged?.call(!value),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: align == LFRadioAlignV2.left
              ? children
              : children.reversed.toList(),
        ),
      ),
    );
  }
}
