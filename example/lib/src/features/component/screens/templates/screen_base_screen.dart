import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class ScreenBaseScreen extends LFScreenStatefulWidgetV2 {
  const ScreenBaseScreen({super.key});

  @override
  State<ScreenBaseScreen> createState() => _ScreenBaseScreenState();
}

class _ScreenBaseScreenState extends LFScreenStateV2<ScreenBaseScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Screen Base'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final typography = context.lfTypography;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'LFScreenStatefulWidgetV2',
          children: [
            ShowcaseTile(
              label: 'This screen uses it',
              child: Text(
                'This very screen extends LFScreenStatefulWidgetV2 '
                'with LFScreenStateV2. It provides:\n\n'
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
          title: 'LFScreenStatelessWidgetV2',
          children: [
            ShowcaseTile(
              label: 'Semantic wrapper',
              child: Text(
                'LFScreenStatelessWidgetV2 is a lightweight '
                'semantic wrapper that marks a widget as a screen. '
                'Useful for simple screens without state.',
                style: typography.bodyMedium,
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'SafeAreaInsetsV2',
          children: [
            ShowcaseTile(
              label: 'Configuration',
              child: Text(
                'SafeAreaInsetsV2.all() - All sides\n'
                'SafeAreaInsetsV2.none() - No sides\n'
                'SafeAreaInsetsV2(top: true, bottom: true)',
                style: typography.bodySmall.copyWith(fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
