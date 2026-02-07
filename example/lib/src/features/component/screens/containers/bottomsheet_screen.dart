import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_action_tile.dart';

class BottomSheetScreen extends LFScreenStatefulWidgetV2 {
  const BottomSheetScreen({super.key});

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends LFScreenStateV2<BottomSheetScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Bottom Sheet'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Bottom Sheet',
          children: [
            ShowcaseActionTile(
              label: 'Selection list',
              buttonText: 'Show Bottom Sheet',
              onPressed: () {
                LFBottomSheetV2.show<String>(
                  context,
                  items: [
                    LFBottomSheetItemV2(key: 'option1', title: 'Option 1'),
                    LFBottomSheetItemV2(key: 'option2', title: 'Option 2'),
                    LFBottomSheetItemV2(key: 'option3', title: 'Option 3'),
                  ],
                  onTap: (_) {},
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
