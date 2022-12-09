part of lf_screen;

class ScreenStatelessWidget extends StatelessWidget {
  final Widget child;

  const ScreenStatelessWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
