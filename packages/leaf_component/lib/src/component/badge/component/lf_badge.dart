part of lf_badge;

class LFBadge extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final double size;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? iconColor;
  final EdgeInsets padding;

  const LFBadge({
    Key? key,
    this.text,
    this.icon,
    this.size = 18.0,
    this.textStyle,
    this.backgroundColor = Colors.red,
    this.iconColor = Colors.white,
    this.padding = const EdgeInsets.all(2.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: size,
        minWidth: size,
      ),
      child: Material(
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(size / 2.0)),
        ),
        elevation: 2.0,
        color: backgroundColor,
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: (text != null),
                child: _buildText(),
              ),
              Visibility(
                visible: (icon != null),
                child: _buildIcon(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    final text = this.text;
    final textStyle = this.textStyle;
    return LFText(
      text ?? '',
      style: textStyle,
    );
  }

  Widget _buildIcon() {
    final icon = this.icon;
    final size = this.size;
    final iconColor = this.iconColor;
    return Icon(
      icon,
      color: iconColor,
      size: size * 0.4,
    );
  }
}
