import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';

/// A themed dialog message widget.
///
/// Style resolution order:
///   1. Explicit [textStyle] parameter
///   2. [LeafDialogThemeData.messageStyle] from the nearest [LeafTheme]
///   3. Fallback [TextStyle] with fontSize 16
class LeafDialogMessage extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final int maxLines;

  const LeafDialogMessage({
    super.key,
    required this.text,
    this.textStyle,
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final dialogTheme = theme.dialogTheme;

    final resolvedStyle =
        textStyle ?? dialogTheme?.messageStyle ?? const TextStyle(fontSize: 16);

    return Text(
      text,
      style: resolvedStyle,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
