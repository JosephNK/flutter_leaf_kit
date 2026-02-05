import 'package:flutter/material.dart';

import '../../shared/widget/lf_inkwell_v2.dart';

/// Action button widget for [LFAppBarV2].
///
/// Displays either a text label or an icon with ink well tap handling.
@immutable
class LFAppBarActionV2 extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;

  const LFAppBarActionV2({
    super.key,
    this.text,
    this.icon,
    this.textStyle,
    this.padding = const EdgeInsets.all(8.0),
    this.margin,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final child = (text != null && text!.isNotEmpty)
        ? Text(text!, style: textStyle)
        : icon ?? const SizedBox.shrink();

    return Semantics(
      button: true,
      label: text,
      child: Container(
        alignment: Alignment.center,
        margin: margin,
        child: LFInkWellV2(
          onTap: onPressed,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
