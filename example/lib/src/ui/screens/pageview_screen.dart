import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class PageViewScreen extends ScreenStatefulWidget {
  final String title;

  const PageViewScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends ScreenState<PageViewScreen> {
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
        LFPageView(
          // autoPage: true,
          margin: const EdgeInsets.all(16.0),
          children: [
            Container(color: Colors.red, height: 200),
            Container(color: Colors.blue, height: 200),
            Container(color: Colors.orange, height: 200),
          ],
        ),
      ],
    );
  }
}
