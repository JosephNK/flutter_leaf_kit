import 'package:example/src/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class PageScreen04 extends ControllerStatefulWidget {
  final LeafBottomIndex bottomIndex;

  const PageScreen04({
    Key? key,
    required this.bottomIndex,
  }) : super(key: key);

  @override
  State<PageScreen04> createState() => _PageScreen04State();
}

class _PageScreen04State extends ControllerState<PageScreen04> {
  @override
  LeafBottomIndex? get bottomIndex => widget.bottomIndex;

  @override
  Color? get backgroundColor => AppColors.background;

  @override
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return null;
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return Center(
      child: Text(
        'Page Screen 04',
        style: AppTextStyles.body1.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context, Object? state) {
    return null;
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, Object? state) {
    return null;
  }

  @override
  void bottomAppBarTapedWhenVisible() {
    // TODO: implement bottomAppBarTapedWhenVisible
  }
}
