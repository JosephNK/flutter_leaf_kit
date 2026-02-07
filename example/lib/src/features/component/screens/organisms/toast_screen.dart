import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_action_tile.dart';

class ToastScreen extends LFScreenStatefulWidgetV2 {
  const ToastScreen({super.key});

  @override
  State<ToastScreen> createState() => _ToastScreenState();
}

class _ToastScreenState extends LFScreenStateV2<ToastScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Toast'));
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
                LFToastV2.showToast(
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
                LFToastV2.showNotification(
                  context,
                  message: 'Success',
                  description: 'Operation completed successfully.',
                  type: LFToastNotificationTypeV2.success,
                );
              },
            ),
            ShowcaseActionTile(
              label: 'Error',
              buttonText: 'Show Error',
              onPressed: () {
                LFToastV2.showNotification(
                  context,
                  message: 'Error',
                  description: 'Something went wrong.',
                  type: LFToastNotificationTypeV2.error,
                );
              },
            ),
            ShowcaseActionTile(
              label: 'Warning',
              buttonText: 'Show Warning',
              onPressed: () {
                LFToastV2.showNotification(
                  context,
                  message: 'Warning',
                  description: 'Please check your input.',
                  type: LFToastNotificationTypeV2.warning,
                );
              },
            ),
            ShowcaseActionTile(
              label: 'Info',
              buttonText: 'Show Info',
              onPressed: () {
                LFToastV2.showNotification(
                  context,
                  message: 'Info',
                  description: 'Here is some information.',
                  type: LFToastNotificationTypeV2.info,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
