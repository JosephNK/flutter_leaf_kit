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
  bool _loading = false;

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
            Center(
              child: LFButton(
                text: 'Toast',
                onTap: () {
                  LFToast.show(context, message: 'message');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TestBoxShadow {
  static const List<BoxShadow> shadows = [
    BoxShadow(
      color: Colors.black,
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color(0x0f101828),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
    ),
  ];
}
