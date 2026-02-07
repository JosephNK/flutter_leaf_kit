import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';

/// Title widget for [LeafAppBar].
///
/// Supports text, leading icon, and image modes.
/// Resolves text color from the theme instead of hardcoded [Colors.black].
@immutable
class LeafAppBarTitle extends StatelessWidget {
  final String? text;
  final Widget? leading;
  final Image? image;
  final Color? textColor;
  final double? textHeight;
  final TextStyle? textStyle;

  const LeafAppBarTitle({
    super.key,
    this.text,
    this.leading,
    this.image,
    this.textColor,
    this.textHeight,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return image!;
    }

    final textValue = text;
    if (textValue == null) {
      return const SizedBox.shrink();
    }

    final theme = LeafTheme.of(context);
    final abTheme = theme.appBarTheme;
    final resolvedStyle = textStyle ?? abTheme?.titleStyle;
    final resolvedColor =
        textColor ?? resolvedStyle?.color ?? theme.colors.onSurface;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) leading!,
        Flexible(
          child: Text(
            textValue,
            style: (resolvedStyle ?? theme.typography.titleLarge).copyWith(
              color: resolvedColor,
              height: textHeight,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
