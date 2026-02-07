import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_action_tile.dart';

class DialogScreen extends LeafScreenStatefulWidget {
  const DialogScreen({super.key});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends LeafScreenState<DialogScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Dialog'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Alert Dialog',
          children: [
            ShowcaseActionTile(
              label: 'Simple alert',
              buttonText: 'Show Alert',
              onPressed: () {
                LeafAlertDialog.show(
                  context,
                  title: 'Alert',
                  message: 'This is a simple alert dialog.',
                );
              },
            ),
            ShowcaseActionTile(
              label: 'Confirmation',
              buttonText: 'Show Confirm',
              onPressed: () {
                LeafAlertDialog.confirm(
                  context,
                  title: 'Confirm',
                  message: 'Are you sure you want to proceed?',
                  okText: 'Yes',
                  cancelText: 'No',
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
