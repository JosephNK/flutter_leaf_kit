import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ShowcaseActionTile extends StatelessWidget {
  const ShowcaseActionTile({
    super.key,
    required this.label,
    required this.buttonText,
    required this.onPressed,
    this.description,
  });

  final String label;
  final String buttonText;
  final VoidCallback onPressed;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final colors = context.lfColors;
    final typography = context.lfTypography;
    final spacing = context.lfSpacing;
    final radius = context.lfRadius;

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
          Text(label, style: typography.labelMedium),
          if (description != null) ...[
            SizedBox(height: spacing.sm),
            Text(description!, style: typography.bodySmall),
          ],
          SizedBox(height: spacing.md),
          LFButtonV2(text: buttonText, onTap: onPressed),
        ],
      ),
    );
  }
}
