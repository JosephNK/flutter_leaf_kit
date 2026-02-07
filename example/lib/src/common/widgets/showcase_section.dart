import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ShowcaseSection extends StatelessWidget {
  const ShowcaseSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final typography = context.leafTypography;
    final spacing = context.leafSpacing;

    return Padding(
      padding: EdgeInsets.only(bottom: spacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: spacing.lg),
            child: Text(title, style: typography.titleMedium),
          ),
          ...children,
        ],
      ),
    );
  }
}
