import 'package:flutter/material.dart';

import '../../../shared/widget/leaf_inkwell.dart';

/// Action button widget for [LeafAppBar].
///
/// Displays either a text label or an icon with ink well tap handling.
@immutable
class LeafAppBarAction extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;

  const LeafAppBarAction({
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
        child: LeafInkWell(
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
