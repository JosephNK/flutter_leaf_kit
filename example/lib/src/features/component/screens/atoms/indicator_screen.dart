import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class IndicatorScreen extends LFScreenStatefulWidgetV2 {
  const IndicatorScreen({super.key});

  @override
  State<IndicatorScreen> createState() => _IndicatorScreenState();
}

class _IndicatorScreenState extends LFScreenStateV2<IndicatorScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Indicator'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Loading Indicator',
          children: [
            ShowcaseTile(
              label: 'Small',
              child: LFIndicatorV2(size: LFIndicatorSizeV2.small),
            ),
            ShowcaseTile(
              label: 'Medium',
              child: LFIndicatorV2(size: LFIndicatorSizeV2.medium),
            ),
            ShowcaseTile(
              label: 'Large',
              child: LFIndicatorV2(size: LFIndicatorSizeV2.large),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Page Circle Indicator',
          children: [
            ShowcaseTile(
              label: 'Basic (page 2 of 5)',
              child: LFPageCircleIndicatorV2(total: 5, current: 2),
            ),
            ShowcaseTile(
              label: 'Decrease style',
              child: LFPageCircleIndicatorV2(
                total: 5,
                current: 2,
                indicatorStyle: LFPageCircleIndicatorStyleV2.decrease,
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Page Rect Indicator',
          children: [
            ShowcaseTile(
              label: 'Basic (page 1 of 4)',
              child: LFPageRectIndicatorV2(total: 4, current: 1),
            ),
          ],
        ),
      ],
    );
  }
}
