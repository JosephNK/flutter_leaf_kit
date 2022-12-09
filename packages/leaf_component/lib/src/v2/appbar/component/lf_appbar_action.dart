part of lf_appbar;

class LFAppBarAction extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Color? textColor;
  final Color? iconColor;
  final EdgeInsets padding;
  final VoidCallback? onPressed;

  const LFAppBarAction({
    Key? key,
    this.text,
    this.icon,
    this.textColor,
    this.iconColor,
    this.padding = const EdgeInsets.all(8.0),
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = this.text;
    final icon = this.icon;
    final textColor = this.textColor;
    final iconColor = this.iconColor;
    final padding = this.padding;
    final onPressed = this.onPressed;

    final child = isNotEmpty(text)
        ? LFText(text ?? '', color: textColor)
        : (icon != null)
            ? Icon(icon, color: iconColor)
            : Container();

    return Container(
      alignment: Alignment.center,
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
