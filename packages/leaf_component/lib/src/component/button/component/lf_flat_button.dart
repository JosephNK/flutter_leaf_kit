part of lf_button;

class LFFlatButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final TextAlign textAlign;
  final VoidCallback? onPressed;

  const LFFlatButton({
    Key? key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.textAlign = TextAlign.center,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LFInkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          color: backgroundColor ?? Colors.blueAccent,
        ),
        child: LFText(
          text,
          color: textColor ?? Colors.white,
          textAlign: textAlign,
        ),
      ),
    );
  }
}
