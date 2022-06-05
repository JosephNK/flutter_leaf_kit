part of leaf_text_component;

class LeafRichText extends StatelessWidget {
  final InlineSpan text;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;

  const LeafRichText({
    Key? key,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: text,
      maxLines: maxLines,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      textAlign: textAlign,
      // textScaleFactor: textScaleFactor ?? MediaQuery.of(context).devicePixelRatio > 3 ? 0.8 : 1.0,
      // strutStyle: StrutStyle(
      //   fontSize: style.fontSize,
      //   height: 1.0,
      // ),
    );
  }
}
