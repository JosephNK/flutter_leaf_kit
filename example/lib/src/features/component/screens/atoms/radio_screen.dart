import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class RadioScreen extends LeafScreenStatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends LeafScreenState<RadioScreen> {
  bool _singleValue = false;
  LeafDataItem? _groupValue;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Radio'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final groupItems = [
      LeafDataItem(id: '1', text: 'Small'),
      LeafDataItem(id: '2', text: 'Medium'),
      LeafDataItem(id: '3', text: 'Large'),
    ];

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Single Radio',
          children: [
            ShowcaseTile(
              label: 'Basic',
              child: LeafRadio(
                value: _singleValue,
                text: 'Option',
                onChanged: (value) => setState(() => _singleValue = value),
              ),
            ),
            ShowcaseTile(
              label: 'Right aligned',
              child: LeafRadio(
                value: _singleValue,
                text: 'Right align',
                align: LeafRadioAlign.right,
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
              child: LeafRadioGroup(
                items: groupItems,
                value: _groupValue,
                onChanged: (item, _) {
                  setState(() => _groupValue = item);
                },
              ),
            ),
            ShowcaseTile(
              label: 'Horizontal group',
              child: LeafRadioGroup(
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
