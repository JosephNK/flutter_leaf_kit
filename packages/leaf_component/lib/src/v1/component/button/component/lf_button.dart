part of '../button.dart';

@Deprecated('Use LeafButton instead')
class LFButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Widget? leading;
  final double leadingSpacing;
  final Duration duration;
  final bool forceLock;
  final bool loading;
  final bool showLoading;
  final bool disabled;
  final BoxDecoration? decoration;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool enabledInkWell;
  final LFLockGestureDetectorOnLoaderBuilder? onLoaderBuilder;
  final VoidCallback? onTap;

  const LFButton({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.leading,
    this.leadingSpacing = 8.0,
    this.duration = const Duration(milliseconds: 250),
    this.forceLock = false,
    this.loading = false,
    this.showLoading = true,
    this.disabled = false,
    this.decoration,
    this.margin,
    this.padding = const EdgeInsets.all(10.0),
    this.enabledInkWell = true,
    this.onLoaderBuilder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = LFText(
      text,
      style: textStyle ?? TextStyle(color: Colors.white),
      textAlign: textAlign,
    );

    final child = leading != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leading!,
              SizedBox(width: leadingSpacing),
              textWidget,
            ],
          )
        : textWidget;

    return LFLockGestureDetector(
      duration: duration,
      forceLock: forceLock,
      loading: loading,
      showLoading: showLoading,
      disabled: disabled,
      decoration: decoration ?? BoxDecoration(color: Colors.blueAccent),
      margin: margin,
      padding: padding,
      enabledInkWell: enabledInkWell,
      onLoaderBuilder: onLoaderBuilder,
      onTap: onTap,
      child: Center(child: child),
    );
  }
}
