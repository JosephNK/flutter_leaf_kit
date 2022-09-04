import 'package:example/src/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class PageScreen01 extends ControllerStatefulWidget {
  final LeafBottomIndex bottomIndex;

  const PageScreen01({
    Key? key,
    required this.bottomIndex,
  }) : super(key: key);

  @override
  State<PageScreen01> createState() => _PageScreen01State();
}

class _PageScreen01State extends ControllerState<PageScreen01> {
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
    return LeafAppBar(
      backgroundColor: AppColors.surface1,
      title: LeafText(className ?? ''),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return Center(
      child: Text(
        'Page Screen 01',
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
