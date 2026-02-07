import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ScrollViewScreen extends LeafScreenStatefulWidget {
  const ScrollViewScreen({super.key});

  @override
  State<ScrollViewScreen> createState() => _ScrollViewScreenState();
}

class _ScrollViewScreenState extends LeafScreenState<ScrollViewScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'ScrollView'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;
    final typography = context.leafTypography;
    final spacing = context.leafSpacing;
    final radius = context.leafRadius;

    return LeafScrollView(
      child: Padding(
        padding: EdgeInsets.all(spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(15, (index) {
            return Container(
              margin: EdgeInsets.only(bottom: spacing.md),
              padding: EdgeInsets.all(spacing.xl),
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(radius.md),
              ),
              child: Text(
                'Scrollable content block ${index + 1}',
                style: typography.bodyLarge,
              ),
            );
          }),
        ),
      ),
    );
  }
}
