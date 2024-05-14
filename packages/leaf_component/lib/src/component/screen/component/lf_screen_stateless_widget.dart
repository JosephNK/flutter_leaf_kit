part of '../screen.dart';

class ScreenStatelessWidget extends StatelessWidget {
  final Widget child;

  const ScreenStatelessWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
