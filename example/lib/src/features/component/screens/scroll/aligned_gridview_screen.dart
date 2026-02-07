import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class AlignedGridViewScreen extends LFScreenStatefulWidgetV2 {
  const AlignedGridViewScreen({super.key});

  @override
  State<AlignedGridViewScreen> createState() => _AlignedGridViewScreenState();
}

class _AlignedGridViewScreenState
    extends LFScreenStateV2<AlignedGridViewScreen> {
  final _items = List.generate(20, (i) => 'Aligned ${i + 1}');

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Aligned GridView'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;
    final typography = context.lfTypography;
    final spacing = context.lfSpacing;
    final radius = context.lfRadius;

    return LFAlignedGridViewV2<String>(
      items: _items,
      padding: EdgeInsets.all(spacing.xl),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: spacing.md,
        crossAxisSpacing: spacing.md,
      ),
      builder: (context, item, index) {
        return Container(
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(radius.md),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(spacing.md),
              child: Text(
                item,
                style: typography.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
