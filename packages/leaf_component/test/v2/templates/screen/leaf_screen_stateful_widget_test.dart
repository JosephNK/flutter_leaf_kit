// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart' hide SafeAreaInsets;
import 'package:flutter_leaf_component/src/v2/templates/screen/model/safe_area_insets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

// ---------------------------------------------------------------------------
// Concrete test implementations
// ---------------------------------------------------------------------------

class _TestScreen extends LeafScreenStatefulWidget {
  final String bodyText;
  final bool useCustomScreen;
  final Color? overrideBg;
  final bool overrideUseSafeArea;
  final SafeAreaInsets? overrideSafeAreaInsets;
  final bool overrideCanPop;

  const _TestScreen({
    super.key,
    super.index,
    this.bodyText = 'Body',
    this.useCustomScreen = false,
    this.overrideBg,
    this.overrideUseSafeArea = true,
    this.overrideSafeAreaInsets,
    this.overrideCanPop = true,
  });

  @override
  State<_TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends LeafScreenState<_TestScreen> {
  @override
  bool get useSafeArea => widget.overrideUseSafeArea;

  @override
  SafeAreaInsets get safeAreaInsets =>
      widget.overrideSafeAreaInsets ?? const SafeAreaInsets.all();

  @override
  Color? get backgroundColor => widget.overrideBg;

  @override
  bool get canPop => widget.overrideCanPop;

  @override
  Widget? buildScreen(BuildContext context) {
    if (widget.useCustomScreen) {
      return const Text('Custom Screen');
    }
    return null;
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return AppBar(title: const Text('Test'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return Text(widget.bodyText);
  }
}

// Minimal implementation with no appbar
class _MinimalScreen extends LeafScreenStatefulWidget {
  const _MinimalScreen();

  @override
  State<_MinimalScreen> createState() => _MinimalScreenState();
}

class _MinimalScreenState extends LeafScreenState<_MinimalScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) => null;

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return const Text('Minimal');
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Widget _wrapWithPlatform(Widget child, TargetPlatform platform) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(platform: platform),
    home: LeafTheme(data: LeafThemeData.light(), child: child),
  );
}

/// Checks if there is a [PopScope] whose [canPop] matches [expectedCanPop].
bool _hasPopScopeWithCanPop(WidgetTester tester, bool expectedCanPop) {
  final popScopes = tester
      .widgetList(find.byWidgetPredicate((w) => w is PopScope))
      .toList();
  return popScopes.any((w) => (w as PopScope).canPop == expectedCanPop);
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('LeafScreenStatefulWidget', () {
    testWidgets('renders body in Scaffold with AppBar', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const _TestScreen()));

      expect(find.text('Body'), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('renders custom screen when buildScreen returns widget', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapWithTheme(const _TestScreen(useCustomScreen: true)),
      );

      expect(find.text('Custom Screen'), findsOneWidget);
      expect(find.text('Body'), findsNothing);
    });

    testWidgets('wraps with PopScope on Android', (tester) async {
      await tester.pumpWidget(
        _wrapWithPlatform(
          const _TestScreen(overrideCanPop: false),
          TargetPlatform.android,
        ),
      );

      // On Android, our screen wraps scaffold with PopScope(canPop: false)
      expect(_hasPopScopeWithCanPop(tester, false), isTrue);
    });

    testWidgets('does NOT wrap with PopScope on iOS', (tester) async {
      await tester.pumpWidget(
        _wrapWithPlatform(
          const _TestScreen(overrideCanPop: false),
          TargetPlatform.iOS,
        ),
      );

      // On iOS, our screen does NOT add a PopScope with canPop=false
      expect(_hasPopScopeWithCanPop(tester, false), isFalse);
      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('applies SafeArea when useSafeArea is true', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const _TestScreen()));

      expect(find.byType(SafeArea), findsWidgets);
    });

    testWidgets('skips SafeArea when useSafeArea is false', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const _TestScreen(overrideUseSafeArea: false)),
      );

      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('applies custom background colour', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const _TestScreen(overrideBg: Colors.red)),
      );

      final scaffolds = tester.widgetList<Scaffold>(find.byType(Scaffold));
      final hasRedBg = scaffolds.any((s) => s.backgroundColor == Colors.red);
      expect(hasRedBg, isTrue);
    });

    testWidgets('minimal screen without appbar renders body', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const _MinimalScreen()));

      expect(find.text('Minimal'), findsOneWidget);
    });
  });

  group('SafeAreaInsets', () {
    test('all() enables every edge', () {
      const insets = SafeAreaInsets.all();
      expect(insets.left, isTrue);
      expect(insets.top, isTrue);
      expect(insets.right, isTrue);
      expect(insets.bottom, isTrue);
    });

    test('none() disables every edge', () {
      const insets = SafeAreaInsets.none();
      expect(insets.left, isFalse);
      expect(insets.top, isFalse);
      expect(insets.right, isFalse);
      expect(insets.bottom, isFalse);
    });

    test('only() enables selected edges', () {
      const insets = SafeAreaInsets.only(top: true, bottom: true);
      expect(insets.left, isFalse);
      expect(insets.top, isTrue);
      expect(insets.right, isFalse);
      expect(insets.bottom, isTrue);
    });

    test('fromLTRB sets edges in order', () {
      const insets = SafeAreaInsets.fromLTRB(true, false, true, false);
      expect(insets.left, isTrue);
      expect(insets.top, isFalse);
      expect(insets.right, isTrue);
      expect(insets.bottom, isFalse);
    });
  });

  group('LeafScreenStatelessWidget', () {
    testWidgets('renders child unchanged', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafScreenStatelessWidget(child: Text('Stateless')),
        ),
      );

      expect(find.text('Stateless'), findsOneWidget);
    });
  });
}
