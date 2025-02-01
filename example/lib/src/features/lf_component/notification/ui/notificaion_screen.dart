import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class NotificationScreen extends ScreenStatefulWidget {
  final String title;

  const NotificationScreen({
    super.key,
    required this.title,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ScreenState<NotificationScreen> {
  @override
  Color? get backgroundColor => Colors.white;

  @override
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return LFAppBar(
      title: LFAppBarTitle(text: widget.title),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: LFText(
                'One Time Notification',
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: LFButton(
                text: 'Show',
                onTap: () {
                  LFPushNotification(
                    title: 'Hello',
                    body: 'World',
                    data: {},
                  ).show(context);
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: LFText(
                'Multiple Time Notification',
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: LFButton(
                text: 'Show',
                onTap: () {
                  LFStackPushNotification.shared
                      .enqueue(
                        LFPushNotification(
                          title: 'Hello',
                          body: 'World',
                          data: {},
                        ),
                      )
                      .show(context);

                  Future.delayed(const Duration(milliseconds: 1000), () {
                    if (!context.mounted) return;
                    LFStackPushNotification.shared
                        .enqueue(
                          LFPushNotification(
                            title: 'Hello1',
                            body: 'World1',
                            data: {},
                          ),
                        )
                        .show(context);
                  });

                  Future.delayed(const Duration(milliseconds: 2000), () {
                    if (!context.mounted) return;
                    LFStackPushNotification.shared
                        .enqueue(
                          LFPushNotification(
                            title: 'Hello2',
                            body: 'World2',
                            data: {},
                          ),
                        )
                        .show(context);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
