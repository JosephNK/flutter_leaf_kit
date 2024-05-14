part of '../text.dart';

class LFEasyRichText extends StatelessWidget implements LFBuildText {
  final String text;
  final TextStyle? style;
  final List<LFEasyRichTextPattern>? patternList;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final LFTextSize? textSize;

  const LFEasyRichText(
    this.text, {
    super.key,
    this.style,
    this.patternList,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return EasyRichText(
      text,
      patternList: patternList
              ?.map((pattern) => EasyRichTextPattern(
                    targetString: pattern.targetString,
                    style: pattern.style,
                  ))
              .toList() ??
          [],
      defaultStyle: style,
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

class LFEasyRichTextPattern {
  ///target string that you want to format
  final dynamic targetString;

  ///Style of target text
  final TextStyle? style;

  LFEasyRichTextPattern({
    Key? key,
    required this.targetString,
    this.style,
  });
}
