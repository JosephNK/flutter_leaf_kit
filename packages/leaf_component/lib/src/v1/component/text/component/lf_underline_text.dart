part of '../text.dart';

//
// https://github.com/flutter/flutter/issues/42833
//
@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFUnderlineText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const LFUnderlineText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: LFUnderlineSpans().textWidgetSpan(text, style: style),
      ),
    );
  }
}

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFUnderlineSpans {
  List<WidgetSpan> textWidgetSpan(
    String text, {
    TextStyle? style,
    VoidCallback? onTap,
  }) {
    TextStyle textStyle = style ?? const TextStyle(fontSize: 21);
    Color color = textStyle.color ?? Colors.black;
    double fontSize = textStyle.fontSize ?? 21;
    double lineHeight = textStyle.height ?? 1.13;
    double height = fontSize * lineHeight;
    double marginBottom = lineHeight > 1.13
        ? (lineHeight - 1.13) * fontSize
        : 0;
    textStyle = textStyle.copyWith(height: 1);
    List<WidgetSpan> spans = [];
    for (int t = 0; t < text.length; t++) {
      String char = text.substring(t, t + 1);
      spans.add(
        WidgetSpan(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: height,
              margin: EdgeInsets.only(
                top: marginBottom / 2,
                bottom: marginBottom / 2,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: color)),
                ),
                child: Text(char, style: textStyle),
              ),
            ),
          ),
        ),
      );
    }
    return spans;
  }
}
