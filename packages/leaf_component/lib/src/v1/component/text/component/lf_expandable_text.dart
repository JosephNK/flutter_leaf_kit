part of '../text.dart';

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFExpandableText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final bool isExpanded;
  final int? maxLines;
  final int? expandMaxLines;
  final Widget? expandWidget;
  final Widget? collapseWidget;

  const LFExpandableText(
    this.text, {
    super.key,
    this.style,
    this.isExpanded = false,
    this.maxLines,
    this.expandMaxLines = 999,
    this.expandWidget,
    this.collapseWidget,
  });

  @override
  State<LFExpandableText> createState() => _LFExpandableTextState();
}

class _LFExpandableTextState extends State<LFExpandableText> {
  bool _isExpanded = false;

  @override
  void didUpdateWidget(covariant LFExpandableText oldWidget) {
    if (oldWidget.isExpanded != widget.isExpanded) {
      setState(() {
        _isExpanded = widget.isExpanded;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        final span = TextSpan(text: widget.text, style: widget.style);
        final tp = TextPainter(
          text: span,
          textDirection: TextDirection.ltr,
          maxLines: widget.maxLines,
        );
        tp.layout(maxWidth: size.maxWidth);

        if (tp.didExceedMaxLines) {
          return Column(
            children: [
              LFText(
                widget.text,
                style: widget.style,
                maxLines: _isExpanded ? widget.expandMaxLines : widget.maxLines,
              ),
              _isExpanded
                  ? (widget.collapseWidget ?? const SizedBox())
                  : (widget.expandWidget ?? const SizedBox()),
            ],
          );
        } else {
          return LFText(
            widget.text,
            style: widget.style,
            maxLines: widget.maxLines,
          );
        }
      },
    );
  }
}
