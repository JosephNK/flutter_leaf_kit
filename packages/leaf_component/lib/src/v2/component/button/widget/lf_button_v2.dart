import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../../../shared/widget/lf_lock_gesture_detector_v2.dart';
import '../../text/widget/lf_text_v2.dart';

/// A themed button widget that resolves colors from the LF design token system.
///
/// Style resolution order:
///   1. Explicit widget parameters ([backgroundColor], [foregroundColor])
///   2. [LFButtonThemeData] from the nearest [LFTheme]
///   3. Global tokens ([LFColors.primary], [LFColors.onPrimary])
@immutable
class LFButtonV2 extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Widget? leading;
  final double? leadingSpacing;
  final Duration duration;
  final bool forceLock;
  final bool loading;
  final bool showLoading;
  final bool disabled;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BoxDecoration? decoration;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool enabledInkWell;
  final LFLockGestureDetectorOnLoaderBuilderV2? onLoaderBuilder;
  final VoidCallback? onTap;

  const LFButtonV2({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.leading,
    this.leadingSpacing,
    this.duration = const Duration(milliseconds: 250),
    this.forceLock = false,
    this.loading = false,
    this.showLoading = true,
    this.disabled = false,
    this.backgroundColor,
    this.foregroundColor,
    this.decoration,
    this.margin,
    this.padding = const EdgeInsets.all(10.0),
    this.enabledInkWell = true,
    this.onLoaderBuilder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final buttonTheme = theme.buttonTheme;

    final resolvedFg = foregroundColor ??
        textStyle?.color ??
        buttonTheme?.foregroundColor ??
        colors.onPrimary;
    final resolvedBg = backgroundColor ??
        buttonTheme?.backgroundColor ??
        colors.primary;
    final resolvedLeadingSpacing =
        leadingSpacing ?? buttonTheme?.leadingSpacing ?? 8.0;
    final resolvedPadding = padding ?? buttonTheme?.padding;
    final resolvedDecoration =
        decoration ?? BoxDecoration(color: resolvedBg);

    final textWidget = LFTextV2(
      text,
      style: textStyle?.copyWith(color: resolvedFg) ??
          TextStyle(color: resolvedFg),
      textAlign: textAlign,
    );

    final child = leading != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leading!,
              SizedBox(width: resolvedLeadingSpacing),
              textWidget,
            ],
          )
        : textWidget;

    return Semantics(
      button: true,
      label: text,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
        child: LFLockGestureDetectorV2(
          duration: duration,
          forceLock: forceLock,
          loading: loading,
          showLoading: showLoading,
          disabled: disabled,
          decoration: resolvedDecoration,
          margin: margin,
          padding: resolvedPadding,
          enabledInkWell: enabledInkWell,
          onLoaderBuilder: onLoaderBuilder,
          onTap: onTap,
          child: Center(child: child),
        ),
      ),
    );
  }
}
