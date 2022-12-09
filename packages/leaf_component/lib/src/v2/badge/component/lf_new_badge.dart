part of lf_badge;

class LFNewBadge extends StatelessWidget {
  final double size;

  const LFNewBadge({
    Key? key,
    this.size = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LFBadge(
      text: 'N',
      size: size,
      textStyle: const TextStyle(
        fontSize: 10.5,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
    );
  }
}
