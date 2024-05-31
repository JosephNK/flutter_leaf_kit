import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_common.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_component.dart';

class SetupScreen extends ScreenStatefulWidget {
  final VoidCallback? onScreenTap;

  const SetupScreen({
    super.key,
    super.index,
    this.onScreenTap,
  });

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ScreenState<SetupScreen> {
  @override
  Color? get backgroundColor => Colors.teal;

  @override
  SafeAreaInsets get safeAreaInsets =>
      SafeAreaInsets.fromLTRB(true, false, true, true);

  @override
  Widget? buildScreen(BuildContext context) {
    Logging.i('SetupScreen buildScreen called');
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
          'SetupScreen',
          style: TextStyle(fontSize: 34.0),
        ),
      ),
    );
  }
}
