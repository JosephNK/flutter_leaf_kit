part of '../appbar.dart';

class LFAppBarBack extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double? size;
  final VoidCallback? onPressed;

  const LFAppBarBack({
    super.key,
    this.icon,
    this.color,
    this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? LFComponentConfigure.shared.appBar?.backIconSize;

    return LFInkWell(
      onTap: onPressed,
      child: Icon(icon ?? Icons.arrow_back_ios_new, color: color, size: size),
    );
  }
}
