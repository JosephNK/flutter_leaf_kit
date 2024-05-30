part of '../button.dart';

class LFButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final TextAlign textAlign;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const LFButton({
    super.key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.textAlign = TextAlign.center,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.padding = const EdgeInsets.all(10.0),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LFLockGestureDetector(
      onTap: onTap,
      showLoading: false,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor ?? Colors.blueAccent,
      ),
      padding: padding,
      child: LFText(
        text,
        color: textColor ?? Colors.white,
        textAlign: textAlign,
      ),
    );
  }
}
