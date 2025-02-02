import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class PageIndicatorScreen extends ScreenStatefulWidget {
  final String title;

  const PageIndicatorScreen({
    super.key,
    required this.title,
  });

  @override
  State<PageIndicatorScreen> createState() => _PageIndicatorScreenState();
}

class _PageIndicatorScreenState extends ScreenState<PageIndicatorScreen> {
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
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('LFPageIndicator'),
          LFPageRectIndicator(
            total: 5,
            current: 2,
          ),
          Text('LFPageCircleIndicator'),
          LFPageCircleIndicator(
            total: 30,
            current: 10,
            size: 10.0,
            indicatorStyle: LFPageCircleIndicatorStyle.decrease,
          ),
        ],
      ),
    );
  }
}
