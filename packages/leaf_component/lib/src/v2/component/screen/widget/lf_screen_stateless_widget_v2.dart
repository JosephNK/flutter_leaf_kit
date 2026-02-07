import 'package:flutter/material.dart';

/// A minimal stateless screen wrapper.
///
/// Wraps a [child] widget unchanged. Useful as a semantic marker for
/// screen-level widgets in routing tables.
@immutable
class LFScreenStatelessWidgetV2 extends StatelessWidget {
  final Widget child;

  const LFScreenStatelessWidgetV2({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => child;
}
