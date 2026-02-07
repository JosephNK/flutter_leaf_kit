import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class AppBarScreen extends LFScreenStatefulWidgetV2 {
  const AppBarScreen({super.key});

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();
}

class _AppBarScreenState extends LFScreenStateV2<AppBarScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'AppBar'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'AppBar Variants',
          children: [
            ShowcaseTile(
              label: 'Default',
              child: SizedBox(
                height: 56,
                child: LFAppBarV2(
                  title: const LFAppBarTitleV2(text: 'Default'),
                  automaticallyImplyLeading: false,
                ),
              ),
            ),
            ShowcaseTile(
              label: 'With actions',
              child: SizedBox(
                height: 56,
                child: LFAppBarV2(
                  title: const LFAppBarTitleV2(text: 'With Actions'),
                  automaticallyImplyLeading: false,
                  actions: [
                    LFAppBarActionV2(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    LFAppBarActionV2(
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
                child: LFAppBarV2(
                  title: const LFAppBarTitleV2(text: 'Custom'),
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
