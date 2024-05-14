part of '../appbar.dart';

class LFAppBarAction extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;

  const LFAppBarAction({
    super.key,
    this.text,
    this.icon,
    this.textStyle,
    this.padding = const EdgeInsets.all(8.0),
    this.margin,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final text = this.text;
    final icon = this.icon;
    final textStyle = this.textStyle;
    final padding = this.padding;
    final onPressed = this.onPressed;

    final child = isNotEmpty(text)
        ? LFText(text ?? '', style: textStyle)
        : (icon != null)
            ? icon
            : Container();

    return Container(
      alignment: Alignment.center,
      margin: margin,
      child: LFInkWell(
        onTap: onPressed,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
