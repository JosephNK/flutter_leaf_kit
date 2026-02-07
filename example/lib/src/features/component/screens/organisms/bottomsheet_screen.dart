import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_action_tile.dart';

class BottomSheetScreen extends LeafScreenStatefulWidget {
  const BottomSheetScreen({super.key});

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends LeafScreenState<BottomSheetScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Bottom Sheet'));
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
                LeafBottomSheet.show<String>(
                  context,
                  items: [
                    LeafBottomSheetItem(key: 'option1', title: 'Option 1'),
                    LeafBottomSheetItem(key: 'option2', title: 'Option 2'),
                    LeafBottomSheetItem(key: 'option3', title: 'Option 3'),
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
