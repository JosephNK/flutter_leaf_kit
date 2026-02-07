import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class ScreenBaseScreen extends LeafScreenStatefulWidget {
  const ScreenBaseScreen({super.key});

  @override
  State<ScreenBaseScreen> createState() => _ScreenBaseScreenState();
}

class _ScreenBaseScreenState extends LeafScreenState<ScreenBaseScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Screen Base'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final typography = context.leafTypography;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'LeafScreenStatefulWidget',
          children: [
            ShowcaseTile(
              label: 'This screen uses it',
              child: Text(
                'This very screen extends LeafScreenStatefulWidget '
                'with LeafScreenState. It provides:\n\n'
                '- Built-in Scaffold with SafeArea\n'
                '- buildAppBar() / buildBody() overrides\n'
                '- PopScope handling (canPop)\n'
                '- Drawer support\n'
                '- FloatingActionButton support',
                style: typography.bodyMedium,
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'LeafScreenStatelessWidget',
          children: [
            ShowcaseTile(
              label: 'Semantic wrapper',
              child: Text(
                'LeafScreenStatelessWidget is a lightweight '
                'semantic wrapper that marks a widget as a screen. '
                'Useful for simple screens without state.',
                style: typography.bodyMedium,
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'SafeAreaInsets',
          children: [
            ShowcaseTile(
              label: 'Configuration',
              child: Text(
                'SafeAreaInsets.all() - All sides\n'
                'SafeAreaInsets.none() - No sides\n'
                'SafeAreaInsets(top: true, bottom: true)',
                style: typography.bodySmall.copyWith(fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
