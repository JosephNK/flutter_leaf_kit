import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class RadioScreen extends LFScreenStatefulWidgetV2 {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends LFScreenStateV2<RadioScreen> {
  bool _singleValue = false;
  LFDataItem? _groupValue;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Radio'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final groupItems = [
      LFDataItem(id: '1', text: 'Small'),
      LFDataItem(id: '2', text: 'Medium'),
      LFDataItem(id: '3', text: 'Large'),
    ];

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Single Radio',
          children: [
            ShowcaseTile(
              label: 'Basic',
              child: LFRadioV2(
                value: _singleValue,
                text: 'Option',
                onChanged: (value) => setState(() => _singleValue = value),
              ),
            ),
            ShowcaseTile(
              label: 'Right aligned',
              child: LFRadioV2(
                value: _singleValue,
                text: 'Right align',
                align: LFRadioAlignV2.right,
                onChanged: (value) => setState(() => _singleValue = value),
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Radio Group',
          children: [
            ShowcaseTile(
              label: 'Vertical group',
              child: LFRadioGroupV2(
                items: groupItems,
                value: _groupValue,
                onChanged: (item, _) {
                  setState(() => _groupValue = item);
                },
              ),
            ),
            ShowcaseTile(
              label: 'Horizontal group',
              child: LFRadioGroupV2(
                items: groupItems,
                value: _groupValue,
                direction: Axis.horizontal,
                onChanged: (item, _) {
                  setState(() => _groupValue = item);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
