part of '../text.dart';

class LFAutoSizeText extends StatelessWidget implements LFBuildText {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? color;
  final TextOverflow? overflow;
  final double textScaleFactor;
  final double minFontSize;
  final int? maxLines;
  final LFTextSize? textSize;
  final double? height;

  const LFAutoSizeText(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.left,
    this.color,
    this.minFontSize = 12,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1.0,
    this.textSize,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: buildTextStyle(context),
      minFontSize: minFontSize,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
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
