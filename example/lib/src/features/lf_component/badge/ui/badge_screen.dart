import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class BadgeScreen extends ScreenStatefulWidget {
  final String title;

  const BadgeScreen({
    super.key,
    required this.title,
  });

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends ScreenState<BadgeScreen> {
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
    const TextStyle textStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    const backgroundColor = Colors.red;

    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: LFBadge(
            text: 'N',
            size: 28.0,
            textStyle: textStyle,
            backgroundColor: backgroundColor,
          ),
        ),
        SizedBox(height: 16.0),
        Center(
          child: LFBadge(
            text: '1',
            size: 28.0,
            textStyle: textStyle,
            backgroundColor: backgroundColor,
          ),
        ),
        SizedBox(height: 16.0),
        Center(
          child: LFBadge(
            text: '10',
            size: 28.0,
            textStyle: textStyle,
            backgroundColor: backgroundColor,
          ),
        ),
        SizedBox(height: 16.0),
        Center(
          child: LFBadge(
            text: '999',
            size: 28.0,
            textStyle: textStyle,
            backgroundColor: backgroundColor,
          ),
        ),
      ],
    );
  }
}
