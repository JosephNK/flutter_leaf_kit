part of lf_text;

class LFText extends StatelessWidget implements LFBuildText {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? color;
  final TextOverflow? overflow;
  final double textScaleFactor;
  final int? maxLines;
  final LFTextSize? textSize;
  final double? height;

  const LFText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign = TextAlign.left,
    this.color,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1.0,
    this.textSize,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: buildTextStyle(context),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textScaleFactor: buildTextScaleFactor(context),
    );
  }

  @override
  double buildTextScaleFactor(BuildContext context) {
    final textSize = this.textSize;
    double textScaleFactor = this.textScaleFactor;
    if (textSize != null) {
      textScaleFactor = textSize.textScaleFactor;
    }
    return textScaleFactor;
  }

  @override
  TextStyle? buildTextStyle(BuildContext context) {
    TextStyle style = this.style ?? DefaultTextStyle.of(context).style;
    style = style.copyWith(
      color: color,
      height: height,
    );
    return style;
  }
}
