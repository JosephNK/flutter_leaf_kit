import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class BadgeScreen extends LeafScreenStatefulWidget {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends LeafScreenState<BadgeScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Badge'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Text Badge',
          children: [
            ShowcaseTile(
              label: 'Single character',
              child: LeafBadge(text: 'N'),
            ),
            ShowcaseTile(
              label: 'Number',
              child: LeafBadge(text: '99'),
            ),
            ShowcaseTile(
              label: 'Custom color',
              child: LeafBadge(
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
              child: LeafBadge(icon: Icons.star),
            ),
            ShowcaseTile(
              label: 'Large size',
              child: LeafBadge(icon: Icons.check, size: 32),
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
                    child: LeafBadge(text: '3'),
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
