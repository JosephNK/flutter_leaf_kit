import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class ChipScreen extends LeafScreenStatefulWidget {
  const ChipScreen({super.key});

  @override
  State<ChipScreen> createState() => _ChipScreenState();
}

class _ChipScreenState extends LeafScreenState<ChipScreen> {
  bool _chipSelected = false;
  List<LeafDataItem> _multiValues = [];
  List<LeafDataItem> _singleValues = [];

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Chip'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final items = [
      LeafDataItem(id: '1', text: 'Flutter'),
      LeafDataItem(id: '2', text: 'Dart'),
      LeafDataItem(id: '3', text: 'Swift'),
      LeafDataItem(id: '4', text: 'Kotlin'),
    ];

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Single Chip',
          children: [
            ShowcaseTile(
              label: 'Toggleable',
              child: LeafChip(
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
              child: LeafChips(
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
              child: LeafChips(
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
