part of '../text.dart';

//
// https://github.com/flutter/flutter/issues/42833
//
class LFUnderlineText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const LFUnderlineText(
    this.text, {
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _textWidgetSpan(text),
      ),
    );
  }

  List<WidgetSpan> _textWidgetSpan(String text) {
    TextStyle textStyle =
        style != null ? style! : const TextStyle(fontSize: 21);
    Color color = textStyle.color ?? Colors.black;
    double fontSize = textStyle.fontSize ?? 21;
    double lineHeight = textStyle.height ?? 1.13;
    double height = fontSize * 1.13;
    double marginBottom =
        lineHeight > 1.13 ? (lineHeight - 1.13) * fontSize : 0;
    textStyle = textStyle.copyWith(height: 1);
    List<WidgetSpan> spans = [];
    for (int t = 0; t < text.length; t++) {
      String char = text.substring(t, t + 1);
      spans.add(
        WidgetSpan(
          child: Container(
            height: height,
            margin: EdgeInsets.only(
                top: marginBottom / 2, bottom: marginBottom / 2),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: color)),
              ),
              child: Text(
                char,
                style: textStyle,
              ),
            ),
          ),
        ),
      );
    }
    return spans;
  }
}
