import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_action_tile.dart';

class ToastScreen extends LeafScreenStatefulWidget {
  const ToastScreen({super.key});

  @override
  State<ToastScreen> createState() => _ToastScreenState();
}

class _ToastScreenState extends LeafScreenState<ToastScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Toast'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Simple Toast',
          children: [
            ShowcaseActionTile(
              label: 'Short toast',
              buttonText: 'Show Toast',
              onPressed: () {
                LeafToast.showToast(
                  context,
                  message: 'This is a toast message',
                );
              },
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Notification Toast',
          children: [
            ShowcaseActionTile(
              label: 'Success',
              buttonText: 'Show Success',
              onPressed: () {
                LeafToast.showNotification(
                  context,
                  message: 'Success',
                  description: 'Operation completed successfully.',
                  type: LeafToastNotificationType.success,
                );
              },
            ),
            ShowcaseActionTile(
              label: 'Error',
              buttonText: 'Show Error',
              onPressed: () {
                LeafToast.showNotification(
                  context,
                  message: 'Error',
                  description: 'Something went wrong.',
                  type: LeafToastNotificationType.error,
                );
              },
            ),
            ShowcaseActionTile(
              label: 'Warning',
              buttonText: 'Show Warning',
              onPressed: () {
                LeafToast.showNotification(
                  context,
                  message: 'Warning',
                  description: 'Please check your input.',
                  type: LeafToastNotificationType.warning,
                );
              },
            ),
            ShowcaseActionTile(
              label: 'Info',
              buttonText: 'Show Info',
              onPressed: () {
                LeafToast.showNotification(
                  context,
                  message: 'Info',
                  description: 'Here is some information.',
                  type: LeafToastNotificationType.info,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
