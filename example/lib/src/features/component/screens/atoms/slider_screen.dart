import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class SliderScreen extends LFScreenStatefulWidgetV2 {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends LFScreenStateV2<SliderScreen> {
  double _value = 50;
  RangeValues _rangeValues = const RangeValues(20, 80);

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Slider'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Basic Slider',
          children: [
            ShowcaseTile(
              label: 'Continuous (${_value.toInt()})',
              child: LFSliderV2(
                value: _value,
                min: 0,
                max: 100,
                onChanged: (v) => setState(() => _value = v),
              ),
            ),
            ShowcaseTile(
              label: 'With divisions',
              child: LFSliderV2(
                value: _value,
                min: 0,
                max: 100,
                divisions: 10,
                onChanged: (v) => setState(() => _value = v),
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Range Slider',
          children: [
            ShowcaseTile(
              label: 'Range (${_rangeValues.start.toInt()} - ${_rangeValues.end.toInt()})',
              child: LFRangeSliderV2(
                values: _rangeValues,
                min: 0,
                max: 100,
                divisions: 10,
                onChanged: (v) => setState(() => _rangeValues = v),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
