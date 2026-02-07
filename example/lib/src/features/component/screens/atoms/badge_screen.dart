import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class BadgeScreen extends LFScreenStatefulWidgetV2 {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends LFScreenStateV2<BadgeScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Badge'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Text Badge',
          children: [
            ShowcaseTile(
              label: 'Single character',
              child: LFBadgeV2(text: 'N'),
            ),
            ShowcaseTile(
              label: 'Number',
              child: LFBadgeV2(text: '99'),
            ),
            ShowcaseTile(
              label: 'Custom color',
              child: LFBadgeV2(
                text: '5',
                backgroundColor: colors.primary,
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Icon Badge',
          children: [
            ShowcaseTile(
              label: 'With icon',
              child: LFBadgeV2(icon: Icons.star),
            ),
            ShowcaseTile(
              label: 'Large size',
              child: LFBadgeV2(icon: Icons.check, size: 32),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Badge on Widget',
          children: [
            ShowcaseTile(
              label: 'On icon button',
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications, size: 32),
                  Positioned(
                    right: -6,
                    top: -6,
                    child: LFBadgeV2(text: '3'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
