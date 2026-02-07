import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';

/// A themed dialog message widget.
///
/// Style resolution order:
///   1. Explicit [textStyle] parameter
///   2. [LFDialogThemeData.messageStyle] from the nearest [LFTheme]
///   3. Fallback [TextStyle] with fontSize 16
class LFDialogMessageV2 extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final int maxLines;

  const LFDialogMessageV2({
    super.key,
    required this.text,
    this.textStyle,
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final dialogTheme = theme.dialogTheme;

    final resolvedStyle = textStyle ??
        dialogTheme?.messageStyle ??
        const TextStyle(fontSize: 16);

    return Text(
      text,
      style: resolvedStyle,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
