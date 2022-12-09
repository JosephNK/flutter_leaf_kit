part of lf_appbar;

class LFAppBarBack extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;

  const LFAppBarBack({
    Key? key,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LFInkWell(
      onTap: onPressed,
      child: Icon(
        Icons.arrow_back_ios,
        color: color,
      ),
    );
  }
}
