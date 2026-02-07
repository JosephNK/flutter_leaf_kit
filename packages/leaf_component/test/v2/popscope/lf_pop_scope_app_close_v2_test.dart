import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/theme_test_helper.dart';

/// Wraps a widget for testing with a specific [TargetPlatform].
Widget _wrapWithPlatform(Widget child, TargetPlatform platform) {
  return MaterialApp(
    theme: ThemeData(platform: platform),
    home: LFTheme(
      data: LFThemeData.light(),
      child: Scaffold(body: child),
    ),
  );
}

/// Returns true if the widget tree contains a [PopScope] with [canPop] == false
/// that was inserted by [LFPopScopeAppCloseV2].
bool _hasPopScopeWithCanPopFalse(WidgetTester tester) {
  final popScopes = tester
      .widgetList(find.byWidgetPredicate(
        (w) => w is PopScope && w is! LFPopScopeAppCloseV2,
      ))
      .toList();
  return popScopes.any((w) {
    final ps = w as PopScope;
    return ps.canPop == false;
  });
}

void main() {
  group('LFPopScopeAppCloseV2', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFPopScopeAppCloseV2(
            child: Text('Hello'),
          ),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('wraps with PopScope on Android platform', (tester) async {
      await tester.pumpWidget(
        _wrapWithPlatform(
          const LFPopScopeAppCloseV2(
            child: Text('Android'),
          ),
          TargetPlatform.android,
        ),
      );

      expect(find.byType(LFPopScopeAppCloseV2), findsOneWidget);
      expect(find.text('Android'), findsOneWidget);
      expect(_hasPopScopeWithCanPopFalse(tester), isTrue);
    });

    testWidgets('does not wrap with PopScope on iOS platform', (tester) async {
      await tester.pumpWidget(
        _wrapWithPlatform(
          const LFPopScopeAppCloseV2(
            child: Text('iOS'),
          ),
          TargetPlatform.iOS,
        ),
      );

      expect(find.byType(LFPopScopeAppCloseV2), findsOneWidget);
      expect(find.text('iOS'), findsOneWidget);
      expect(_hasPopScopeWithCanPopFalse(tester), isFalse);
    });

    testWidgets('accepts custom duration', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFPopScopeAppCloseV2(
            duration: Duration(seconds: 2),
            child: Text('Custom Duration'),
          ),
        ),
      );

      expect(find.text('Custom Duration'), findsOneWidget);
    });
  });
}
