import 'package:example/src/common/widget_tile.dart';
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
        WidgetTile(
          title: 'Badge (N)',
          child: LFBadge(
            text: 'N',
            size: 28.0,
            textStyle: textStyle,
            backgroundColor: backgroundColor,
          ),
        ),
        WidgetTile(
          title: 'Badge (1)',
          child: LFBadge(
            text: '1',
            size: 28.0,
            textStyle: textStyle,
            backgroundColor: backgroundColor,
          ),
        ),
        WidgetTile(
          title: 'Badge (10)',
          child: LFBadge(
            text: '10',
            size: 28.0,
            textStyle: textStyle,
            backgroundColor: backgroundColor,
          ),
        ),
        WidgetTile(
          title: 'Badge (999)',
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
