part of '../lf_text.dart';

class LFRichText extends StatelessWidget implements LFBuildText {
  final InlineSpan text;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final LFTextSize? textSize;

  const LFRichText({
    super.key,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textScaler: TextScaler.linear(buildTextScaleFactor(context)),
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
    throw UnimplementedError();
  }
}

class LFTextSpan extends TextSpan {
  const LFTextSpan({
    super.text,
    super.children,
    super.style,
    super.recognizer,
  });
}
