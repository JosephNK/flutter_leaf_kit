import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class AppLayoutScreen extends LFScreenStatefulWidgetV2 {
  const AppLayoutScreen({super.key});

  @override
  State<AppLayoutScreen> createState() => _AppLayoutScreenState();
}

class _AppLayoutScreenState extends LFScreenStateV2<AppLayoutScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'App Layout'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final typography = context.lfTypography;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'LFLayoutAppV2',
          children: [
            ShowcaseTile(
              label: 'Root app wrapper',
              child: Text(
                'LFLayoutAppV2 wraps your MaterialApp to provide:\n\n'
                '- Build name banner (DEV/STAGING)\n'
                '- Device setup callback\n'
                '- Background color configuration\n\n'
                'Usage:\n'
                'LFLayoutAppV2(\n'
                '  buildName: "DEV",\n'
                '  child: MaterialApp(...),\n'
                ')',
                style: typography.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
