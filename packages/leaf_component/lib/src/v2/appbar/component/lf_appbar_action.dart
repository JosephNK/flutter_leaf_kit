part of lf_appbar;

class LFAppBarAction extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final Color? textColor;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;

  const LFAppBarAction({
    Key? key,
    this.text,
    this.icon,
    this.textColor,
    this.padding = const EdgeInsets.all(8.0),
    this.margin,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = this.text;
    final icon = this.icon;
    final textColor = this.textColor;
    final padding = this.padding;
    final onPressed = this.onPressed;

    final child = isNotEmpty(text)
        ? LFText(text ?? '', color: textColor)
        : (icon != null)
            ? icon
            : Container();

    return Container(
      alignment: Alignment.center,
      margin: margin,
      child: LFInkWell(
        onTap: onPressed,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
