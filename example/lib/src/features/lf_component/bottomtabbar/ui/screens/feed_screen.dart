import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_common.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_component.dart';

class FeedScreen extends ScreenStatefulWidget {
  final VoidCallback? onScreenTap;

  const FeedScreen({
    super.key,
    super.index,
    this.onScreenTap,
  });

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ScreenState<FeedScreen> {
  @override
  Color? get backgroundColor => Colors.amber;

  @override
  SafeAreaInsets get safeAreaInsets =>
      SafeAreaInsets.fromLTRB(true, false, true, true);

  @override
  Widget? buildScreen(BuildContext context) {
    Logging.i('FeedScreen buildScreen called');
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return null;
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onScreenTap,
      child: const Center(
        child: Text(
          'FeedScreen',
          style: TextStyle(fontSize: 34.0),
        ),
      ),
    );
  }
}
