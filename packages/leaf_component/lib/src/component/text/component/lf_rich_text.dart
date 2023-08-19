part of lf_text;

class LFRichText extends StatelessWidget implements LFBuildText {
  final InlineSpan text;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final LFTextSize? textSize;

  const LFRichText({
    Key? key,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: text,
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
    throw UnimplementedError();
  }
}

class LFTextSpan extends TextSpan {
  const LFTextSpan({
    String? text,
    List<InlineSpan>? children,
    TextStyle? style,
    GestureRecognizer? recognizer,
  }) : super(
          text: text,
          children: children,
          style: style,
          recognizer: recognizer,
        );
}
