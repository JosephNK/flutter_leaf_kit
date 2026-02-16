import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class GridViewScreen extends LeafScreenStatefulWidget {
  const GridViewScreen({super.key});

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends LeafScreenState<GridViewScreen> {
  final _items = List.generate(20, (i) => 'Grid ${i + 1}');

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'GridView'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;
    final typography = context.leafTypography;
    final spacing = context.leafSpacing;
    final radius = context.leafRadius;

    return LeafGridView<String>(
      items: _items,
      padding: EdgeInsets.all(spacing.xl),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: spacing.md,
        crossAxisSpacing: spacing.md,
      ),
      builder: (context, item, index) {
        return Container(
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(radius.md),
          ),
          child: Center(child: Text(item, style: typography.bodyMedium)),
        );
      },
    );
  }
}
