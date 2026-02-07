import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class AlignedGridViewScreen extends LeafScreenStatefulWidget {
  const AlignedGridViewScreen({super.key});

  @override
  State<AlignedGridViewScreen> createState() => _AlignedGridViewScreenState();
}

class _AlignedGridViewScreenState
    extends LeafScreenState<AlignedGridViewScreen> {
  final _items = List.generate(20, (i) => 'Aligned ${i + 1}');

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Aligned GridView'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;
    final typography = context.leafTypography;
    final spacing = context.leafSpacing;
    final radius = context.leafRadius;

    return LeafAlignedGridView<String>(
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
