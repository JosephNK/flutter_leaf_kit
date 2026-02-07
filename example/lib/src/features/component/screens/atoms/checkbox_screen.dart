import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class CheckboxScreen extends LeafScreenStatefulWidget {
  const CheckboxScreen({super.key});

  @override
  State<CheckboxScreen> createState() => _CheckboxScreenState();
}

class _CheckboxScreenState extends LeafScreenState<CheckboxScreen> {
  bool _singleValue = false;
  List<LeafDataItem> _groupValues = [];

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'CheckBox'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final groupItems = [
      LeafDataItem(id: '1', text: 'Apple'),
      LeafDataItem(id: '2', text: 'Banana'),
      LeafDataItem(id: '3', text: 'Cherry'),
    ];

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Single CheckBox',
          children: [
            ShowcaseTile(
              label: 'Basic',
              child: LeafCheckBox(
                value: _singleValue,
                text: 'Accept terms',
                onChanged: (value) => setState(() => _singleValue = value),
              ),
            ),
            ShowcaseTile(
              label: 'Right aligned',
              child: LeafCheckBox(
                value: _singleValue,
                text: 'Right align',
                align: LeafCheckBoxAlign.right,
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
              child: LeafCheckBoxGroup(
                items: groupItems,
                values: _groupValues,
                onChanged: (items, _) {
                  setState(() => _groupValues = items);
                },
              ),
            ),
            ShowcaseTile(
              label: 'Horizontal group',
              child: LeafCheckBoxGroup(
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
