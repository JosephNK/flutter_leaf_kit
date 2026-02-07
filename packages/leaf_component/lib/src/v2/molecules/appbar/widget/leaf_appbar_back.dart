import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../../../shared/widget/leaf_inkwell.dart';

/// Back button for [LeafAppBar].
///
/// Resolves icon color from the theme instead of hardcoded values.
/// No dependency on [LFComponentConfigure].
@immutable
class LeafAppBarBack extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double? size;
  final VoidCallback? onPressed;

  const LeafAppBarBack({
    super.key,
    this.icon,
    this.color,
    this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final abTheme = theme.appBarTheme;

    final resolvedColor =
        color ?? abTheme?.backButtonColor ?? theme.colors.onSurface;

    return Semantics(
      button: true,
      label: 'Back',
      child: LeafInkWell(
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
