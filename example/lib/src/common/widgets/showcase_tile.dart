import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ShowcaseTile extends StatelessWidget {
  const ShowcaseTile({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.leafColors;
    final typography = context.leafTypography;
    final spacing = context.leafSpacing;
    final radius = context.leafRadius;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spacing.md),
      padding: EdgeInsets.all(spacing.lg),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(radius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: spacing.md),
            child: Text(label, style: typography.labelMedium),
          ),
          child,
        ],
      ),
    );
  }
}
