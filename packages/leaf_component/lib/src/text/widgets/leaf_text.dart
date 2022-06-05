part of leaf_text_component;

class LeafText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;

  const LeafText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      // textScaleFactor: textScaleFactor ?? MediaQuery.of(context).devicePixelRatio > 3 ? 0.8 : 1.0,
      // strutStyle: StrutStyle(
      //   fontSize: style.fontSize,
      //   height: 1.0,
      // ),
    );
  }
}
