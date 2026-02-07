import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';

/// A themed dialog title widget.
///
/// Style resolution order:
///   1. Explicit [textStyle] parameter
///   2. [LFDialogThemeData.titleStyle] from the nearest [LFTheme]
///   3. Fallback [TextStyle] with fontSize 18
class LFDialogTitleV2 extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final int maxLines;

  const LFDialogTitleV2({
    super.key,
    required this.text,
    this.textStyle,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final dialogTheme = theme.dialogTheme;

    final resolvedStyle = textStyle ??
        dialogTheme?.titleStyle ??
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

    return Semantics(
      header: true,
      child: Text(
        text,
        style: resolvedStyle,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
