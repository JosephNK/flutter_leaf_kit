import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class SwitchScreen extends LeafScreenStatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends LeafScreenState<SwitchScreen> {
  bool _value1 = false;
  bool _value2 = true;
  bool _value3 = false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Switch'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Basic Switch',
          children: [
            ShowcaseTile(
              label: 'Default (platform-adaptive)',
              child: LeafSwitch(
                value: _value1,
                onChanged: (v) => setState(() => _value1 = v),
              ),
            ),
            ShowcaseTile(
              label: 'Initially on',
              child: LeafSwitch(
                value: _value2,
                onChanged: (v) => setState(() => _value2 = v),
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Custom Colors',
          children: [
            ShowcaseTile(
              label: 'Custom active color',
              child: LeafSwitch(
                value: _value3,
                activeTrackColor: colors.success,
                onChanged: (v) => setState(() => _value3 = v),
              ),
            ),
            ShowcaseTile(
              label: 'Disabled',
              child: LeafSwitch(value: true, onChanged: null),
            ),
          ],
        ),
      ],
    );
  }
}
