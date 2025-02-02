import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_common.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_component.dart';

class SetupScreen extends ScreenStatefulWidget {
  final LFBottomTabBarScaffoldController bottomTabBarScaffoldController;
  final VoidCallback? onScreenTap;

  const SetupScreen({
    super.key,
    super.index,
    required this.bottomTabBarScaffoldController,
    this.onScreenTap,
  });

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ScreenState<SetupScreen> {
  @override
  Color? get backgroundColor => Colors.greenAccent;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'SetupScreen',
              style: TextStyle(fontSize: 34.0),
            ),
          ),
          const Divider(),
          LFButton(
            text: 'Update Badge Count',
            onTap: () {
              widget.bottomTabBarScaffoldController.updateTabBadge(
                tabIndex: 2,
                badgeCount: 9,
              );
            },
          ),
        ],
      ),
    );
  }
}
