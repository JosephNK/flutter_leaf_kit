import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class CheckboxScreen extends LFScreenStatefulWidgetV2 {
  const CheckboxScreen({super.key});

  @override
  State<CheckboxScreen> createState() => _CheckboxScreenState();
}

class _CheckboxScreenState extends LFScreenStateV2<CheckboxScreen> {
  bool _singleValue = false;
  List<LFDataItem> _groupValues = [];

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'CheckBox'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final groupItems = [
      LFDataItem(id: '1', text: 'Apple'),
      LFDataItem(id: '2', text: 'Banana'),
      LFDataItem(id: '3', text: 'Cherry'),
    ];

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Single CheckBox',
          children: [
            ShowcaseTile(
              label: 'Basic',
              child: LFCheckBoxV2(
                value: _singleValue,
                text: 'Accept terms',
                onChanged: (value) => setState(() => _singleValue = value),
              ),
            ),
            ShowcaseTile(
              label: 'Right aligned',
              child: LFCheckBoxV2(
                value: _singleValue,
                text: 'Right align',
                align: LFCheckBoxAlignV2.right,
                onChanged: (value) => setState(() => _singleValue = value),
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'CheckBox Group',
          children: [
            ShowcaseTile(
              label: 'Vertical group',
              child: LFCheckBoxGroupV2(
                items: groupItems,
                values: _groupValues,
                onChanged: (items, _) {
                  setState(() => _groupValues = items);
                },
              ),
            ),
            ShowcaseTile(
              label: 'Horizontal group',
              child: LFCheckBoxGroupV2(
                items: groupItems,
                values: _groupValues,
                direction: Axis.horizontal,
                onChanged: (items, _) {
                  setState(() => _groupValues = items);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
