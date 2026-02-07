import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class TextScreen extends LFScreenStatefulWidgetV2 {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends LFScreenStateV2<TextScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Text'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;
    final typography = context.lfTypography;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Basic Text',
          children: [
            ShowcaseTile(
              label: 'Default',
              child: LFTextV2('Hello, Leaf Kit V2!'),
            ),
            ShowcaseTile(
              label: 'Custom color',
              child: LFTextV2('Primary color', color: colors.primary),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Typography Styles',
          children: [
            ShowcaseTile(
              label: 'Headline small',
              child: LFTextV2('Headline', style: typography.headlineSmall),
            ),
            ShowcaseTile(
              label: 'Title medium',
              child: LFTextV2('Title', style: typography.titleMedium),
            ),
            ShowcaseTile(
              label: 'Body medium',
              child: LFTextV2('Body text', style: typography.bodyMedium),
            ),
            ShowcaseTile(
              label: 'Label small',
              child: LFTextV2('Label', style: typography.labelSmall),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Text Overflow',
          children: [
            ShowcaseTile(
              label: 'Ellipsis (max 1 line)',
              child: LFTextV2(
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
