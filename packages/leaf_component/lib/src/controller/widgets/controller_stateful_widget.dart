part of leaf_controller;

mixin ControllerMixin {
  void bottomAppBarTapedWhenVisible();
}

class ControllerVariable {
  LeafBottomIndex? get bottomIndex => null;
  bool get useSafeArea => false;
  bool get resizeToAvoidBottomInset => false;
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;
  Color? get backgroundColor => null;
}

abstract class ControllerBuild {
  Widget? build(BuildContext context);
  Widget? buildScreen(BuildContext context);
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state);
  Widget buildBody(BuildContext context, Object? state);
  Widget? buildFloatingActionButton(BuildContext context, Object? state);
  Widget? buildBottomNavigationBar(BuildContext context, Object? state);
}

abstract class ControllerStatefulWidget extends StatefulWidget {
  const ControllerStatefulWidget({Key? key}) : super(key: key);
}

abstract class ControllerState<T extends StatefulWidget> extends State<T>
    with ControllerVariable, ControllerMixin
    implements ControllerBuild {
  String? className;
  // Object? objectState;

  bool isActivation = true;

  @override
  LeafBottomIndex? get bottomIndex => null;

  @override
  bool get useSafeArea => false;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  @override
  Color? get backgroundColor => null;

  @override
  void initState() {
    super.initState();
    className = context.widget.toString();
    Logging.d('Controller initState: $className');

    final bottomIndex = this.bottomIndex;
    if (bottomIndex != null) {
      isActivation = (bottomIndex.activeTabIndex == bottomIndex.tabIndex);
    }
  }

  @override
  void dispose() {
    Logging.d('Controller dispose: $className');
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    final bottomIndex = this.bottomIndex;

    // Once Activation
    if (!isActivation) {
      if (bottomIndex != null) {
        isActivation = (bottomIndex.activeTabIndex == bottomIndex.tabIndex);
      }
    }

    // Taped when visible
    if (bottomIndex != null && bottomIndex.scrollTop) {
      bottomAppBarTapedWhenVisible();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (!isActivation) {
      return const LeafTransparentContainer();
    }

    final screenWidget = buildScreen(context);
    if (screenWidget != null) {
      return screenWidget;
    }

    return buildScaffold(context, null);
  }

  Widget buildScaffold(BuildContext context, Object? state, {Key? key}) {
    final body = useSafeArea
        ? SafeArea(
            child: buildBody(context, state),
          )
        : buildBody(context, state);

    return Scaffold(
      key: key,
      appBar: buildAppbar(context, state),
      body: Container(
        color: Colors.transparent,
        child: body,
      ),
      backgroundColor: backgroundColor ?? Colors.transparent,
      bottomNavigationBar: buildBottomNavigationBar(context, state),
      floatingActionButton: buildFloatingActionButton(context, state),
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
