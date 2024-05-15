part of '../button.dart';

class LFFlatButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final TextAlign textAlign;
  final VoidCallback? onTap;

  const LFFlatButton({
    super.key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.textAlign = TextAlign.center,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LFInkWell(
      onTap: onTap,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(0)),
        color: backgroundColor ?? Colors.blueAccent,
      ),
      padding: const EdgeInsets.all(10.0),
      child: LFText(
        text,
        color: textColor ?? Colors.white,
        textAlign: textAlign,
      ),
    );
  }
}
