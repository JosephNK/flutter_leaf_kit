import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_common.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_component.dart';

class HomeScreen extends ScreenStatefulWidget {
  final VoidCallback? onScreenTap;

  const HomeScreen({
    super.key,
    super.index,
    this.onScreenTap,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ScreenState<HomeScreen> {
  @override
  Color? get backgroundColor => Colors.blue;

  @override
  SafeAreaInsets get safeAreaInsets =>
      SafeAreaInsets.fromLTRB(true, false, true, true);

  @override
  Widget? buildScreen(BuildContext context) {
    Logging.i('HomeScreen buildScreen called');
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
          'HomeScreen',
          style: TextStyle(fontSize: 34.0),
        ),
      ),
    );
  }
}