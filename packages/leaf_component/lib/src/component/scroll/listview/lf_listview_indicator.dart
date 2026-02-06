part of '../scroll.dart';

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFListViewIndicator extends StatelessWidget {
  final bool loading;

  const LFListViewIndicator({
    super.key,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loading,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: const Center(
          child: LFIndicator(size: LFIndicatorSize.medium),
        ),
      ),
    );
  }
}
