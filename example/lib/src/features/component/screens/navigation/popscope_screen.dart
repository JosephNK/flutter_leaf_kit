import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class PopScopeScreen extends LFScreenStatefulWidgetV2 {
  const PopScopeScreen({super.key});

  @override
  State<PopScopeScreen> createState() => _PopScopeScreenState();
}

class _PopScopeScreenState extends LFScreenStateV2<PopScopeScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'PopScope'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final typography = context.lfTypography;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'PopScope App Close',
          children: [
            ShowcaseTile(
              label: 'Description',
              child: Text(
                'LFPopScopeAppCloseV2 wraps a widget to require '
                'double-tap back button to close the app on Android. '
                'This is typically used at the root of your app.',
                style: typography.bodyMedium,
              ),
            ),
            ShowcaseTile(
              label: 'Usage',
              child: Text(
                'LFPopScopeAppCloseV2(\n'
                '  child: YourAppContent(),\n'
                '  duration: Duration(seconds: 2),\n'
                ')',
                style: typography.bodySmall.copyWith(
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
