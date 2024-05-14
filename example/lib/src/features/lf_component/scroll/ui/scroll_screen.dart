import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ScrollScreen extends ScreenStatefulWidget {
  final String title;

  const ScrollScreen({
    super.key,
    required this.title,
  });

  @override
  State<ScrollScreen> createState() => _ScrollScreenState();
}

class _ScrollScreenState extends ScreenState<ScrollScreen> {
  final LFScrollViewController _scrollViewController = LFScrollViewController();

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
    return LFScrollView(
      controller: _scrollViewController,
      autoKeyboardHide: false,
      disallowGlow: false,
      shrinkWrap: false,
      scrollable: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(color: Colors.red, height: 300.0),
          Container(color: Colors.blue, height: 300.0),
          Container(color: Colors.yellow, height: 300.0),
          Container(color: Colors.orange, height: 300.0),
          Container(color: Colors.pink, height: 300.0),
          Container(color: Colors.deepPurple, height: 300.0),
          Container(color: Colors.teal, height: 300.0),
          Container(color: Colors.black54, height: 15000.0),
          Container(color: Colors.teal, height: 300.0),
        ],
      ),
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, Object? state) {
    return GestureDetector(
      onTap: () {
        _scrollViewController.scrollToPosition(
          animated: true,
          position: 15000.0,
        );
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: const Text('Bottom'),
      ),
    );
  }
}