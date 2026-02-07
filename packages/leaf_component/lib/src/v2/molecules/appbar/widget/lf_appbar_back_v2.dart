import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../../../shared/widget/lf_inkwell_v2.dart';

/// Back button for [LFAppBarV2].
///
/// Resolves icon color from the theme instead of hardcoded values.
/// No dependency on [LFComponentConfigure].
@immutable
class LFAppBarBackV2 extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double? size;
  final VoidCallback? onPressed;

  const LFAppBarBackV2({
    super.key,
    this.icon,
    this.color,
    this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final abTheme = theme.appBarTheme;

    final resolvedColor =
        color ?? abTheme?.backButtonColor ?? theme.colors.onSurface;

    return Semantics(
      button: true,
      label: 'Back',
      child: LFInkWellV2(
        onTap: onPressed,
        child: Icon(
          icon ?? Icons.arrow_back_ios_new,
          color: resolvedColor,
          size: size,
        ),
      ),
    );
  }
}
