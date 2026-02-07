import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class AppLayoutScreen extends LeafScreenStatefulWidget {
  const AppLayoutScreen({super.key});

  @override
  State<AppLayoutScreen> createState() => _AppLayoutScreenState();
}

class _AppLayoutScreenState extends LeafScreenState<AppLayoutScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'App Layout'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final typography = context.leafTypography;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'LeafLayoutApp',
          children: [
            ShowcaseTile(
              label: 'Root app wrapper',
              child: Text(
                'LeafLayoutApp wraps your MaterialApp to provide:\n\n'
                '- Build name banner (DEV/STAGING)\n'
                '- Device setup callback\n'
                '- Background color configuration\n\n'
                'Usage:\n'
                'LeafLayoutApp(\n'
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
