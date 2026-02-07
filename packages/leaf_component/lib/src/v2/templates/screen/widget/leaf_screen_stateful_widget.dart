import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../../navigationbar/model/leaf_bottom_tab_index.dart';
import '../model/safe_area_insets.dart';

/// Configuration mixin that exposes overridable scaffold properties.
///
/// Subclass [LeafScreenState] and override getters to customise the scaffold
/// without touching the build pipeline.
mixin LeafScreenVariable {
  bool get useSafeArea => true;
  SafeAreaInsets get safeAreaInsets => const SafeAreaInsets.all();
  bool? get resizeToAvoidBottomInset => null;
  bool get extendBodyBehindAppBar => false;
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;
  Color? get backgroundColor => null;
  double? get drawerEdgeDragWidth => null;
  bool get canPop => true;
}

/// Abstract builder that declares the slots a screen can fill.
abstract class LeafScreenBuild {
  Widget? buildScreen(BuildContext context);
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state);
  Widget buildBody(BuildContext context, Object? state);
  Widget? buildDrawer(BuildContext context, Object? state);
  Widget? buildEndDrawer(BuildContext context, Object? state);
  Widget? buildFloatingActionButton(BuildContext context, Object? state);
  Widget? buildBottomNavigationBar(BuildContext context, Object? state);
  void onDrawerChanged(BuildContext context, bool isOpened);
  void onEndDrawerChanged(BuildContext context, bool isOpened);
  void onPopInvokedWithResult(
    BuildContext context,
    bool didPop,
    dynamic result,
  );
}

/// A [StatefulWidget] base class that optionally carries a tab index for
/// bottom-tab integration.
abstract class LeafScreenStatefulWidget extends StatefulWidget {
  final LeafBottomTabIndex? index;

  const LeafScreenStatefulWidget({super.key, this.index});
}

/// A full-featured [State] base class with built-in [Scaffold] and
/// platform-aware [PopScope] handling.
///
/// Uses `Theme.of(context).platform` for web safety.
/// Uses [LeafTheme] tokens for theming.
abstract class LeafScreenState<T extends LeafScreenStatefulWidget>
    extends State<T>
    with LeafScreenVariable, AutomaticKeepAliveClientMixin
    implements LeafScreenBuild {
  // ------------------------------------------------------------------
  // Keep-alive – override to `true` in subclasses that need it
  // ------------------------------------------------------------------

  @override
  bool get wantKeepAlive => false;

  // ------------------------------------------------------------------
  // Lifecycle
  // ------------------------------------------------------------------

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);

    final index = widget.index;
    if (index != null && index.isSelected) {
      didTabSelected(context, index);
    }
  }

  // ------------------------------------------------------------------
  // Build
  // ------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenWidget = buildScreen(context);
    if (screenWidget != null) return screenWidget;
    return buildScaffold(context, null);
  }

  /// Builds a [Scaffold] with SafeArea body and optional [PopScope] on
  /// non-Apple platforms.
  Widget buildScaffold(BuildContext context, Object? state, {Key? key}) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final resolvedBg = backgroundColor ?? colors.background;

    final scaffold = Scaffold(
      key: key,
      appBar: buildAppBar(context, state),
      body: _buildSafeAreaBody(state),
      backgroundColor: resolvedBg,
      bottomNavigationBar: buildBottomNavigationBar(context, state),
      floatingActionButton: buildFloatingActionButton(context, state),
      floatingActionButtonLocation: floatingActionButtonLocation,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawer: buildDrawer(context, state),
      endDrawer: buildEndDrawer(context, state),
      onDrawerChanged: (isOpened) => onDrawerChanged(context, isOpened),
      onEndDrawerChanged: (isOpened) => onEndDrawerChanged(context, isOpened),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );

    return _wrapWithPopScope(scaffold);
  }

  /// Builds the body widget (with optional SafeArea) *without* Scaffold.
  Widget buildWithoutScaffold(BuildContext context, Object? state, {Key? key}) {
    final body = _buildSafeAreaBody(state);
    return _wrapWithPopScope(body);
  }

  // ------------------------------------------------------------------
  // Defaults – override in subclasses to customise
  // ------------------------------------------------------------------

  @override
  Widget? buildScreen(BuildContext context) => null;

  @override
  Widget? buildDrawer(BuildContext context, Object? state) => null;

  @override
  Widget? buildEndDrawer(BuildContext context, Object? state) => null;

  @override
  Widget? buildBottomNavigationBar(BuildContext context, Object? state) => null;

  @override
  Widget? buildFloatingActionButton(BuildContext context, Object? state) =>
      null;

  @override
  void onDrawerChanged(BuildContext context, bool isOpened) {}

  @override
  void onEndDrawerChanged(BuildContext context, bool isOpened) {}

  @override
  void onPopInvokedWithResult(
    BuildContext context,
    bool didPop,
    dynamic result,
  ) {}

  /// Called when the user re-taps the currently selected bottom tab.
  void didTabSelected(BuildContext context, LeafBottomTabIndex index) {}

  // ------------------------------------------------------------------
  // Private helpers
  // ------------------------------------------------------------------

  Widget _buildSafeAreaBody(Object? state) {
    final body = buildBody(context, state);
    if (!useSafeArea) return body;

    final insets = safeAreaInsets;
    return SafeArea(
      left: insets.left,
      top: insets.top,
      right: insets.right,
      bottom: insets.bottom,
      child: body,
    );
  }

  Widget _wrapWithPopScope(Widget child) {
    final platform = Theme.of(context).platform;
    final isApple =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    if (isApple) return child;

    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        onPopInvokedWithResult(context, didPop, result);
      },
      child: child,
    );
  }
}
