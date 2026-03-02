import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';

const _kDefaultButtonTextStyle = TextStyle(fontSize: 16);
const _kDefaultButtonPadding = EdgeInsets.symmetric(
  vertical: 10.0,
  horizontal: 12.0,
);

/// A themed OK button for dialogs.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LeafDialogThemeData] from the nearest [LeafTheme]
///   3. Hardcoded defaults (blueAccent background, 'OK' text)
class LeafDialogOKButton extends StatelessWidget {
  final bool autoPop;
  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const LeafDialogOKButton({
    super.key,
    this.autoPop = true,
    this.text,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final dialogTheme = theme.dialogTheme;

    final resolvedText = text ?? dialogTheme?.okText ?? 'OK';
    final resolvedTextStyle =
        textStyle ??
        dialogTheme?.okTextStyle ??
        _kDefaultButtonTextStyle.copyWith(color: colors.onPrimary);
    final resolvedBgColor =
        backgroundColor ?? dialogTheme?.okTextBackgroundColor ?? colors.primary;
    final resolvedBorderColor = borderColor ?? dialogTheme?.okTextBorderColor;
    final resolvedPadding =
        padding ?? dialogTheme?.okTextPadding ?? _kDefaultButtonPadding;
    final resolvedBorderRadius =
        dialogTheme?.borderRadius ?? BorderRadius.circular(10.0);

    return Semantics(
      button: true,
      label: resolvedText,
      child: GestureDetector(
        onTap: () async {
          if (autoPop) {
            Navigator.maybePop(context, 'OK');
            await Future.delayed(const Duration(milliseconds: 100));
          }
          onPressed?.call();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: resolvedBorderRadius,
            border: resolvedBorderColor != null
                ? Border.all(color: resolvedBorderColor)
                : null,
            color: resolvedBgColor,
          ),
          margin: const EdgeInsets.all(8.0),
          padding: resolvedPadding,
          child: Text(
            resolvedText,
            style: resolvedTextStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

/// A themed Cancel button for dialogs.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LeafDialogThemeData] from the nearest [LeafTheme]
///   3. Hardcoded defaults (grey background, 'Cancel' text)
class LeafDialogCancelButton extends StatelessWidget {
  final bool autoPop;
  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const LeafDialogCancelButton({
    super.key,
    this.autoPop = true,
    this.text,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final dialogTheme = theme.dialogTheme;

    final resolvedText = text ?? dialogTheme?.cancelText ?? 'Cancel';
    final resolvedTextStyle =
        textStyle ??
        dialogTheme?.cancelTextStyle ??
        _kDefaultButtonTextStyle.copyWith(color: colors.onSurface);
    final resolvedBgColor =
        backgroundColor ??
        dialogTheme?.cancelTextBackgroundColor ??
        Colors.grey.withValues(alpha: 0.5);
    final resolvedBorderColor =
        borderColor ?? dialogTheme?.cancelTextBorderColor;
    final resolvedPadding =
        padding ?? dialogTheme?.cancelTextPadding ?? _kDefaultButtonPadding;
    final resolvedBorderRadius =
        dialogTheme?.borderRadius ?? BorderRadius.circular(10.0);

    return Semantics(
      button: true,
      label: resolvedText,
      child: GestureDetector(
        onTap: () async {
          if (autoPop) {
            Navigator.maybePop(context, 'Cancel');
            await Future.delayed(const Duration(milliseconds: 100));
          }
          onPressed?.call();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: resolvedBorderRadius,
            border: resolvedBorderColor != null
                ? Border.all(color: resolvedBorderColor)
                : null,
            color: resolvedBgColor,
          ),
          margin: const EdgeInsets.all(8.0),
          padding: resolvedPadding,
          child: Text(
            resolvedText,
            style: resolvedTextStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
