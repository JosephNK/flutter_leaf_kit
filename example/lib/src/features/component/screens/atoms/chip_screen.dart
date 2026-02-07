import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class ChipScreen extends LFScreenStatefulWidgetV2 {
  const ChipScreen({super.key});

  @override
  State<ChipScreen> createState() => _ChipScreenState();
}

class _ChipScreenState extends LFScreenStateV2<ChipScreen> {
  bool _chipSelected = false;
  List<LFDataItem> _multiValues = [];
  List<LFDataItem> _singleValues = [];

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Chip'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final items = [
      LFDataItem(id: '1', text: 'Flutter'),
      LFDataItem(id: '2', text: 'Dart'),
      LFDataItem(id: '3', text: 'Swift'),
      LFDataItem(id: '4', text: 'Kotlin'),
    ];

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Single Chip',
          children: [
            ShowcaseTile(
              label: 'Toggleable',
              child: LFChipV2(
                text: 'Flutter',
                selected: _chipSelected,
                onPressed: (v) => setState(() => _chipSelected = v),
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Multi-Select Chips',
          children: [
            ShowcaseTile(
              label: 'Horizontal (multi)',
              child: LFChipsV2(
                items: items,
                values: _multiValues,
                onChanged: (items, _) {
                  setState(() => _multiValues = items);
                },
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Single-Select Chips',
          children: [
            ShowcaseTile(
              label: 'Horizontal (single)',
              child: LFChipsV2(
                items: items,
                values: _singleValues,
                multiple: false,
                onChanged: (items, _) {
                  setState(() => _singleValues = items);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
