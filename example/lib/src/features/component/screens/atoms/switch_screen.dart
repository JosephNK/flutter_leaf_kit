import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class SwitchScreen extends LFScreenStatefulWidgetV2 {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends LFScreenStateV2<SwitchScreen> {
  bool _value1 = false;
  bool _value2 = true;
  bool _value3 = false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Switch'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Basic Switch',
          children: [
            ShowcaseTile(
              label: 'Default (platform-adaptive)',
              child: LFSwitchV2(
                value: _value1,
                onChanged: (v) => setState(() => _value1 = v),
              ),
            ),
            ShowcaseTile(
              label: 'Initially on',
              child: LFSwitchV2(
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
              child: LFSwitchV2(
                value: _value3,
                activeTrackColor: colors.success,
                onChanged: (v) => setState(() => _value3 = v),
              ),
            ),
            ShowcaseTile(
              label: 'Disabled',
              child: LFSwitchV2(value: true, onChanged: null),
            ),
          ],
        ),
      ],
    );
  }
}
