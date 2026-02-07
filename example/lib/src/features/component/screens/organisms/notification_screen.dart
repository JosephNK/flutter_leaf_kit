import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_action_tile.dart';

class NotificationScreen extends LeafScreenStatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends LeafScreenState<NotificationScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Notification'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Push Notification',
          children: [
            ShowcaseActionTile(
              label: 'Overlay notification',
              buttonText: 'Show Notification',
              description: 'Slides down from top with auto-dismiss',
              onPressed: () {
                final notification = LeafPushNotification(
                  title: 'New Message',
                  body: 'You have received a new message from Leaf Kit.',
                  onTap: (_) {},
                );
                notification.show(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
