import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class AppBarScreen extends LeafScreenStatefulWidget {
  const AppBarScreen({super.key});

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();
}

class _AppBarScreenState extends LeafScreenState<AppBarScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'AppBar'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'AppBar Variants',
          children: [
            ShowcaseTile(
              label: 'Default',
              child: SizedBox(
                height: 56,
                child: LeafAppBar(
                  title: const LeafAppBarTitle(text: 'Default'),
                  automaticallyImplyLeading: false,
                ),
              ),
            ),
            ShowcaseTile(
              label: 'With actions',
              child: SizedBox(
                height: 56,
                child: LeafAppBar(
                  title: const LeafAppBarTitle(text: 'With Actions'),
                  automaticallyImplyLeading: false,
                  actions: [
                    LeafAppBarAction(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    LeafAppBarAction(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            ShowcaseTile(
              label: 'Custom background',
              child: SizedBox(
                height: 56,
                child: LeafAppBar(
                  title: const LeafAppBarTitle(text: 'Custom'),
                  automaticallyImplyLeading: false,
                  backgroundColor: colors.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
