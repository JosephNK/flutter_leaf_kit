part of '../screen.dart';

@Deprecated('Use LeafScreenStatelessWidget instead')
class ScreenStatelessWidget extends StatelessWidget {
  final Widget child;

  const ScreenStatelessWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
