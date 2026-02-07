import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class IconScreen extends LFScreenStatefulWidgetV2 {
  const IconScreen({super.key});

  @override
  State<IconScreen> createState() => _IconScreenState();
}

class _IconScreenState extends LFScreenStateV2<IconScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Icon'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'IconData',
          children: [
            ShowcaseTile(
              label: 'Material icons',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LFIconsV2(Icons.home, color: colors.primary),
                  LFIconsV2(Icons.settings, color: colors.secondary),
                  LFIconsV2(Icons.favorite, color: colors.error),
                ],
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Custom Size',
          children: [
            ShowcaseTile(
              label: 'Different sizes',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LFIconsV2(Icons.star, width: 16, height: 16),
                  LFIconsV2(Icons.star, width: 24, height: 24),
                  LFIconsV2(Icons.star, width: 32, height: 32),
                  LFIconsV2(Icons.star, width: 48, height: 48),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
