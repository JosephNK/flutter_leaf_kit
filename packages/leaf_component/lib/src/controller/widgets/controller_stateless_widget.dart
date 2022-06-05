part of leaf_controller;

class ControllerStatelessWidget extends StatelessWidget {
  final Widget child;

  const ControllerStatelessWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
