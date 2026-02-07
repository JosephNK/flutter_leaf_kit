import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

/// Wraps with [MaterialApp] + [LFTheme], with debug banner disabled.
Widget _wrapWithThemeNoBanner(Widget child, {LFThemeData? theme}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LFTheme(
      data: theme ?? LFThemeData.light(),
      child: Scaffold(body: child),
    ),
  );
}

void main() {
  group('LFLayoutAppV2', () {
    testWidgets('renders child when constraints are non-zero', (tester) async {
      var builderCalled = false;

      await tester.pumpWidget(
        _wrapWithThemeNoBanner(
          LFLayoutAppV2(
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
          LFLayoutAppV2(
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
          LFLayoutAppV2(
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
          LFLayoutAppV2(
            onBuilder: () {},
            child: const Text('No Banner'),
          ),
        ),
      );

      expect(find.text('No Banner'), findsOneWidget);
      expect(find.byType(Banner), findsNothing);
    });

    testWidgets('applies custom background colour', (tester) async {
      await tester.pumpWidget(
        _wrapWithThemeNoBanner(
          LFLayoutAppV2(
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

    testWidgets('uses LFTheme background when no explicit colour',
        (tester) async {
      final theme = LFThemeData.light();

      await tester.pumpWidget(
        _wrapWithThemeNoBanner(
          LFLayoutAppV2(
            onBuilder: () {},
            child: const Text('Themed BG'),
          ),
          theme: theme,
        ),
      );

      expect(find.text('Themed BG'), findsOneWidget);
    });
  });
}
