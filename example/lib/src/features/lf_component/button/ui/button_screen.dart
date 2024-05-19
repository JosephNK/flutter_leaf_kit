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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: LFFlatButton(
            text: 'Button',
            onTap: () {},
          ),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: LFRoundedButton(
            text: 'Button',
            onTap: () {},
          ),
        ),
        const SizedBox(height: 10.0),
        const Center(
          child: LFTopButton(
            isShow: false,
          ),
        ),
        const SizedBox(height: 10.0),
        LFLockGestureDetector(
          loading: _loading,
          lockDuration: const Duration(seconds: 1),
          onTap: () {
            print('onTap');
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
          margin: const EdgeInsets.all(10.0),
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
        const SizedBox(height: 10.0),
        LFLockGestureDetector(
          lockDuration: const Duration(seconds: 1),
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
          margin: const EdgeInsets.all(10.0),
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
