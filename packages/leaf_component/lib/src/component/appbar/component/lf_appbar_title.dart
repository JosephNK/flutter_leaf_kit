part of lf_appbar;

class LFAppBarTitle extends StatelessWidget {
  final String? text;
  final Widget? leading;
  final Image? image;
  final Color? textColor;
  final double? textHeight;
  final TextStyle? textStyle;

  const LFAppBarTitle({
    Key? key,
    this.text,
    this.leading,
    this.image,
    this.textColor,
    this.textHeight,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textIconWidget = _buildTextIcon(context);
    final imageWidget = _buildImage(context);

    if (imageWidget != null) {
      return imageWidget;
    }

    if (textIconWidget != null) {
      return textIconWidget;
    }

    return Container();
  }

  Widget? _buildImage(BuildContext context) {
    final image = this.image;

    if (image != null) {
      return Container(
        child: image,
      );
    }

    return null;
  }

  Widget? _buildTextIcon(BuildContext context) {
    final text = this.text;
    final leading = this.leading;
    final textStyle =
        this.textStyle ?? LFComponentConfigure.shared.appBar?.titleStyle;
    final textColor = this.textColor ?? textStyle?.color ?? Colors.black;

    if (text != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          (leading != null) ? leading : Container(),
          Flexible(
            child: LFText(
              text,
              style: textStyle,
              color: textColor,
              height: textHeight,
            ),
          ),
        ],
      );
    }

    return null;
  }
}
