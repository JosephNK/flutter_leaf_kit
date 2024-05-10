part of '../lf_screen.dart';

mixin class ScreenVariable {
  bool get useSafeArea => true;
  SafeAreaInsets get safeAreaInsets =>
      SafeAreaInsets.fromLTRB(true, true, true, true);
  bool? get resizeToAvoidBottomInset => null;
  bool get extendBodyBehindAppBar => false;
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;
  Color? get backgroundColor => null;
  double? get drawerEdgeDragWidth => null;
  bool get canPop => true;
}

abstract class ScreenBuild {
  Widget? buildScreen(BuildContext context);
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state);
  Widget buildBody(BuildContext context, Object? state);
  Widget? buildDrawer(BuildContext context, Object? state);
  Widget? buildEndDrawer(BuildContext context, Object? state);
  Widget? buildFloatingActionButton(BuildContext context, Object? state);
  Widget? buildBottomNavigationBar(BuildContext context, Object? state);
  void onDrawerChanged(BuildContext context, bool isOpened);
  void onEndDrawerChanged(BuildContext context, bool isOpened);
  // only Android
  Future<bool> willPopScopeCallback(BuildContext context);
}

abstract class StatefulExtWidget extends StatefulWidget {
  final LFBottomTabIndex? index;

  const StatefulExtWidget({
    super.key,
    this.index,
  });
}

abstract class ScreenStatefulWidget extends StatefulExtWidget {
  const ScreenStatefulWidget({super.key, super.index});
}

abstract class ScreenState<T extends StatefulExtWidget> extends State<T>
    with ScreenVariable
    implements ScreenBuild {
  String? className;

  bool _isActivation = true;

  @override
  bool get useSafeArea => true;

  @override
  SafeAreaInsets get safeAreaInsets =>
      SafeAreaInsets.fromLTRB(true, true, true, true);

  @override
  bool? get resizeToAvoidBottomInset => null;

  @override
  bool get extendBodyBehindAppBar => false;

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  @override
  Color? get backgroundColor => null;

  @override
  void initState() {
    super.initState();

    className = context.widget.toString();
    Logging.d('$className is initState');

    _updateActivation();
  }

  @override
  void dispose() {
    Logging.d('$className is dispose');

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    // Once Activation
    if (!_isActivation) {
      _updateActivation();
    }

    // BottomTabBar Scroll Top Event
    final index = widget.index;
    if (index != null && index.didSelected) {
      didTabSelected(context, index);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isActivation) {
      Logging.i('$className is not Activation!');
      return Container();
    }
    final screenWidget = buildScreen(context);
    if (screenWidget != null) {
      return screenWidget;
    }
    return buildScaffold(context, null);
  }

  Widget buildScaffold(
    BuildContext context,
    Object? state, {
    Key? key,
  }) {
    const defaultBackgroundColor = Colors.transparent;

    final backgroundColor = this.backgroundColor;
    final drawerEdgeDragWidth = this.drawerEdgeDragWidth;
    final floatingActionButtonLocation = this.floatingActionButtonLocation;
    final resizeToAvoidBottomInset = this.resizeToAvoidBottomInset;
    final extendBodyBehindAppBar = this.extendBodyBehindAppBar;

    final scaffold = Scaffold(
      key: key,
      appBar: buildAppbar(context, state),
      body: _buildSafeAreaBody(defaultBackgroundColor, state),
      backgroundColor: backgroundColor ?? defaultBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context, state),
      floatingActionButton: buildFloatingActionButton(context, state),
      floatingActionButtonLocation: floatingActionButtonLocation,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawer: buildDrawer(context, state),
      endDrawer: buildEndDrawer(context, state),
      onDrawerChanged: (bool isOpened) {
        onDrawerChanged(context, isOpened);
      },
      onEndDrawerChanged: (bool isOpened) {
        onEndDrawerChanged(context, isOpened);
      },
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );

    if (Platform.isIOS) {
      return scaffold;
    }

    return PopScope(
      canPop: canPop,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          willPopScopeCallback(context);
        }
      },
      child: scaffold,
    );
  }

  Widget buildWithoutScaffold(
    BuildContext context,
    Object? state, {
    Key? key,
  }) {
    const defaultBackgroundColor = Colors.transparent;

    final body = _buildSafeAreaBody(defaultBackgroundColor, state);

    if (Platform.isIOS) {
      return body;
    }

    return PopScope(
      canPop: canPop,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          willPopScopeCallback(context);
        }
      },
      child: body,
    );
  }

  Widget _buildSafeAreaBody(Color? defaultBackgroundColor, Object? state) {
    final useSafeArea = this.useSafeArea;
    final safeAreaInsets = this.safeAreaInsets;

    return Container(
      color: defaultBackgroundColor,
      child: useSafeArea
          ? SafeArea(
              left: safeAreaInsets.left,
              top: safeAreaInsets.top,
              right: safeAreaInsets.right,
              bottom: safeAreaInsets.bottom,
              child: buildBody(context, state),
            )
          : buildBody(context, state),
    );
  }

  @override
  Widget? buildDrawer(BuildContext context, Object? state) {
    return null;
  }

  @override
  Widget? buildEndDrawer(BuildContext context, Object? state) {
    return null;
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
  void onDrawerChanged(BuildContext context, bool isOpened) {}

  @override
  void onEndDrawerChanged(BuildContext context, bool isOpened) {}

  @override
  Future<bool> willPopScopeCallback(BuildContext context) {
    return Future<bool>.value(true);
  }
}

extension ScreenStateFunction on ScreenState {
  void _updateActivation() {
    final index = widget.index;
    if (index != null) {
      final isForceActive = index.forceActive;
      if (isForceActive) {
        _isActivation = true;
      } else {
        _isActivation = (index.activeTabIndex == index.tabIndex);
      }
    }
  }

  void didTabSelected(BuildContext context, LFBottomTabIndex index) {
    // Event
  }
}

class SafeAreaInsets {
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  const SafeAreaInsets({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  static SafeAreaInsets fromLTRB(bool left, bool top, bool right, bool bottom) {
    return SafeAreaInsets(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  static SafeAreaInsets only(
      {bool? left, bool? top, bool? right, bool? bottom}) {
    return SafeAreaInsets(
      left: left ?? false,
      top: top ?? false,
      right: right ?? false,
      bottom: bottom ?? false,
    );
  }
}
