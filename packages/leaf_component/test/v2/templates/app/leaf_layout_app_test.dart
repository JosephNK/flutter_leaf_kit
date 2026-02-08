import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

/// Wraps with [MaterialApp] + [LeafTheme], with debug banner disabled.
Widget _wrapWithThemeNoBanner(Widget child, {LeafThemeData? theme}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LeafTheme(
      data: theme ?? LeafThemeData.light(),
      child: Scaffold(body: child),
    ),
  );
}

void main() {
  group('LeafLayoutApp', () {
    testWidgets('renders child when constraints are non-zero', (tester) async {
      var builderCalled = false;

      await tester.pumpWidget(
        _wrapWithThemeNoBanner(
          LeafLayoutApp(
            onBuilder: () => builderCalled = true,
            child: const Text('App Content'),
          ),
        ),
      );

      expect(find.text('App Content'), findsOneWidget);
      expect(builderCalled, isTrue);
    });

    testWidgets('calls onSetupDevice when provided', (tester) async {
      var setupCalled = false;
      var builderCalled = false;

      await tester.pumpWidget(
        _wrapWithThemeNoBanner(
          LeafLayoutApp(
            onSetupDevice: (onBuilder) {
              setupCalled = true;
              onBuilder();
            },
            onBuilder: () => builderCalled = true,
            child: const Text('Setup Content'),
          ),
        ),
      );

      expect(find.text('Setup Content'), findsOneWidget);
      expect(setupCalled, isTrue);
      expect(builderCalled, isTrue);
    });

    testWidgets('shows Banner when buildName is non-empty', (tester) async {
      await tester.pumpWidget(
        _wrapWithThemeNoBanner(
          LeafLayoutApp(
            buildName: 'DEV',
            onBuilder: () {},
            child: const Text('Banner Content'),
          ),
        ),
      );

      expect(find.text('Banner Content'), findsOneWidget);
      // Only our Banner should exist (debug banner is disabled)
      expect(find.byType(Banner), findsOneWidget);
    });

    testWidgets('no Banner when buildName is empty', (tester) async {
      await tester.pumpWidget(
        _wrapWithThemeNoBanner(
          LeafLayoutApp(onBuilder: () {}, child: const Text('No Banner')),
        ),
      );

      expect(find.text('No Banner'), findsOneWidget);
      expect(find.byType(Banner), findsNothing);
    });

    testWidgets('applies custom background colour', (tester) async {
      await tester.pumpWidget(
        _wrapWithThemeNoBanner(
          LeafLayoutApp(
            backgroundColor: Colors.blue,
            onBuilder: () {},
            child: const Text('Blue BG'),
          ),
        ),
      );

      expect(find.text('Blue BG'), findsOneWidget);

      final containers = tester.widgetList<Container>(find.byType(Container));
      final hasBlueColor = containers.any((c) => c.color == Colors.blue);
      expect(hasBlueColor, isTrue);
    });

    testWidgets('uses LeafTheme background when no explicit colour', (
      tester,
    ) async {
      final theme = LeafThemeData.light();

      await tester.pumpWidget(
        _wrapWithThemeNoBanner(
          LeafLayoutApp(onBuilder: () {}, child: const Text('Themed BG')),
          theme: theme,
        ),
      );

      expect(find.text('Themed BG'), findsOneWidget);
    });
  });
}
