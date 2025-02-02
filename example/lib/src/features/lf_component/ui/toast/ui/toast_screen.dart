import 'package:example/src/common/widget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ToastScreen extends ScreenStatefulWidget {
  final String title;

  const ToastScreen({
    super.key,
    required this.title,
  });

  @override
  State<ToastScreen> createState() => _ToastScreenState();
}

class _ToastScreenState extends ScreenState<ToastScreen> {
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
            WidgetTile(
              title: 'Toast',
              child: LFButton(
                text: 'Toast',
                onTap: () {
                  LFToast.showToast(
                    context,
                    message: 'message',
                  );
                },
              ),
            ),
            WidgetTile(
              title: 'ToastNotification (Style flat)',
              child: LFButton(
                text: 'ToastNotification',
                onTap: () {
                  LFToast.showNotification(
                    context,
                    message: 'message',
                  );
                },
              ),
            ),
            WidgetTile(
              title: 'ToastNotification (Style simple)',
              child: LFButton(
                text: 'ToastNotification',
                onTap: () {
                  LFToast.showNotification(
                    context,
                    message: 'message',
                    style: LFToastNotificationStyle.simple,
                  );
                },
              ),
            ),
            WidgetTile(
              title: 'ToastNotification (Alignment)',
              child: LFButton(
                text: 'ToastNotification',
                onTap: () {
                  LFToast.showNotification(
                    context,
                    message: 'message',
                    alignment: const Alignment(1.0, -0.5),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
