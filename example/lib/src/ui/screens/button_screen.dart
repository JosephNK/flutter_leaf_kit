import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ButtonScreen extends ScreenStatefulWidget {
  final String title;

  const ButtonScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends ScreenState<ButtonScreen> {
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
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: LFFlatButton(
            text: 'Button',
          ),
        ),
        SizedBox(height: 10.0),
        Center(
          child: LFRoundedButton(
            text: 'Button',
          ),
        ),
        SizedBox(height: 10.0),
        Center(
          child: LFTopButton(
            isShow: false,
          ),
        ),
      ],
    );
  }
}
