import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ScrollViewScreen extends LFScreenStatefulWidgetV2 {
  const ScrollViewScreen({super.key});

  @override
  State<ScrollViewScreen> createState() => _ScrollViewScreenState();
}

class _ScrollViewScreenState extends LFScreenStateV2<ScrollViewScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'ScrollView'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;
    final typography = context.lfTypography;
    final spacing = context.lfSpacing;
    final radius = context.lfRadius;

    return LFScrollViewV2(
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
