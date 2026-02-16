import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class TextScreen extends LeafScreenStatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends LeafScreenState<TextScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Text'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;
    final typography = context.leafTypography;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Basic Text',
          children: [
            ShowcaseTile(label: 'Default', child: LeafText('Hello, Leaf Kit!')),
            ShowcaseTile(
              label: 'Custom color',
              child: LeafText('Primary color', color: colors.primary),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Typography Styles',
          children: [
            ShowcaseTile(
              label: 'Headline small',
              child: LeafText('Headline', style: typography.headlineSmall),
            ),
            ShowcaseTile(
              label: 'Title medium',
              child: LeafText('Title', style: typography.titleMedium),
            ),
            ShowcaseTile(
              label: 'Body medium',
              child: LeafText('Body text', style: typography.bodyMedium),
            ),
            ShowcaseTile(
              label: 'Label small',
              child: LeafText('Label', style: typography.labelSmall),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Text Overflow',
          children: [
            ShowcaseTile(
              label: 'Ellipsis (max 1 line)',
              child: LeafText(
                'This is a very long text that should be truncated with an ellipsis when it overflows the available space.',
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
