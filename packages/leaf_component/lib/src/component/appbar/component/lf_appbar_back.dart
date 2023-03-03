part of lf_appbar;

class LFAppBarBack extends StatelessWidget {
  final Color? color;
  final double? size;
  final VoidCallback? onPressed;

  const LFAppBarBack({
    Key? key,
    this.color,
    this.size,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? LFComponentConfigure.shared.appBar?.backIconSize;

    return LFInkWell(
      onTap: onPressed,
      child: Icon(
        Icons.arrow_back_ios_new,
        color: color,
        size: size,
      ),
    );
  }
}
