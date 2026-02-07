import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class IndicatorScreen extends LeafScreenStatefulWidget {
  const IndicatorScreen({super.key});

  @override
  State<IndicatorScreen> createState() => _IndicatorScreenState();
}

class _IndicatorScreenState extends LeafScreenState<IndicatorScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Indicator'));
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
              child: LeafIndicator(size: LeafIndicatorSize.small),
            ),
            ShowcaseTile(
              label: 'Medium',
              child: LeafIndicator(size: LeafIndicatorSize.medium),
            ),
            ShowcaseTile(
              label: 'Large',
              child: LeafIndicator(size: LeafIndicatorSize.large),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Page Circle Indicator',
          children: [
            ShowcaseTile(
              label: 'Basic (page 2 of 5)',
              child: LeafPageCircleIndicator(total: 5, current: 2),
            ),
            ShowcaseTile(
              label: 'Decrease style',
              child: LeafPageCircleIndicator(
                total: 5,
                current: 2,
                indicatorStyle: LeafPageCircleIndicatorStyle.decrease,
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Page Rect Indicator',
          children: [
            ShowcaseTile(
              label: 'Basic (page 1 of 4)',
              child: LeafPageRectIndicator(total: 4, current: 1),
            ),
          ],
        ),
      ],
    );
  }
}
