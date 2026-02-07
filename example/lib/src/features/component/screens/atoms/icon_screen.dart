import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class IconScreen extends LeafScreenStatefulWidget {
  const IconScreen({super.key});

  @override
  State<IconScreen> createState() => _IconScreenState();
}

class _IconScreenState extends LeafScreenState<IconScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Icon'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;

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
                  LeafIcons(Icons.home, color: colors.primary),
                  LeafIcons(Icons.settings, color: colors.secondary),
                  LeafIcons(Icons.favorite, color: colors.error),
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
                  LeafIcons(Icons.star, width: 16, height: 16),
                  LeafIcons(Icons.star, width: 24, height: 24),
                  LeafIcons(Icons.star, width: 32, height: 32),
                  LeafIcons(Icons.star, width: 48, height: 48),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
