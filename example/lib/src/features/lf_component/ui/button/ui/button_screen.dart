import 'package:example/src/common/widget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ButtonScreen extends ScreenStatefulWidget {
  final String title;

  const ButtonScreen({super.key, required this.title});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends ScreenState<ButtonScreen> {
  bool _loading = false;

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return LFAppBar(title: LFAppBarTitle(text: widget.title));
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
              title: 'LFButton',
              child: SizedBox(
                width: double.infinity,
                height: 56.0,
                child: LFButton(
                  text: 'LFButton',
                  leading: const Icon(Icons.touch_app, color: Colors.white),
                  onTap: () {
                    debugPrint('LFButton onTap');
                  },
                ),
              ),
            ),
            WidgetTile(
              title: 'LFLockGestureDetector with InkWell',
              child: LFLockGestureDetector(
                loading: _loading,
                duration: const Duration(seconds: 1),
                onTap: () {
                  setState(() {
                    _loading = !_loading;
                  });
                },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.orange, width: 1.0),
                  color: Colors.grey[300],
                  boxShadow: const [
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
                  ],
                ),
                padding: const EdgeInsets.all(12.0),
                enabledInkWell: true,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LFText(
                          'enabledInkWell is true',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: LFBadge(text: 9.toString()),
                    ),
                  ],
                ),
              ),
            ),
            WidgetTile(
              title: 'LFLockGestureDetector without InkWell',
              child: LFLockGestureDetector(
                duration: const Duration(seconds: 1),
                // onTap: () {
                //   print('onTap');
                // },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.orange, width: 1.0),
                  color: Colors.grey[300],
                  boxShadow: const [
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
                  ],
                ),
                padding: const EdgeInsets.all(12.0),
                enabledInkWell: false,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LFText(
                          'enabledInkWell is false',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: LFBadge(text: 9.toString()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        LFCornerPositionButton(
          rightTop: LFCornerPosition(show: 10.0, hide: -100),
          show: true,
          onTap: () {
            debugPrint('LFCornerPositionButton onTap');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_upward_sharp,
              color: Colors.black.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }
}
