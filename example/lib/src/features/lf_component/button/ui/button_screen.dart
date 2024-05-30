import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ButtonScreen extends ScreenStatefulWidget {
  final String title;

  const ButtonScreen({
    super.key,
    required this.title,
  });

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
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: LFText(
                'LFButton',
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: LFButton(
                text: 'Button',
                onTap: () {
                  debugPrint('LFButton onTap');
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: LFText(
                'LFLockGestureDetector with InkWell',
                textAlign: TextAlign.center,
              ),
            ),
            LFLockGestureDetector(
              loading: _loading,
              duration: const Duration(seconds: 1),
              onTap: () {
                setState(() {
                  _loading = !_loading;
                });
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.orange,
                  width: 1.0,
                ),
                color: Colors.grey[300],
                boxShadow: TestBoxShadow.shadows,
              ),
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LFText(
                        'Hello World',
                        textAlign: TextAlign.center,
                      )
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: LFText(
                'LFLockGestureDetector without InkWell',
                textAlign: TextAlign.center,
              ),
            ),
            LFLockGestureDetector(
              duration: const Duration(seconds: 1),
              // onTap: () {
              //   print('onTap');
              // },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.orange,
                  width: 1.0,
                ),
                color: Colors.grey[300],
                boxShadow: TestBoxShadow.shadows,
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
                        'Hello World',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: LFBadge(text: 9.toString()),
                  ),
                ],
              ),
            )
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
              color: Colors.black.withOpacity(0.6),
            ),
          ),
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
