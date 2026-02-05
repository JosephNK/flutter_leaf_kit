import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LFAppBarV2', () {
    testWidgets('renders with title widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: LFThemeData.light(),
            child: Scaffold(
              appBar: const LFAppBarV2(
                title: Text('Test Title'),
              ),
              body: const SizedBox.shrink(),
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('shows back button when route can pop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: LFThemeData.light(),
            child: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LFTheme(
                          data: LFThemeData.light(),
                          child: const Scaffold(
                            appBar: LFAppBarV2(
                              title: Text('Page 2'),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text('Go'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();

      expect(find.text('Page 2'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    });
  });

  group('LFAppBarBackV2', () {
    testWidgets('renders with default icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: LFThemeData.light(),
            child: const Scaffold(
              body: LFAppBarBackV2(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    });

    testWidgets('uses custom icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: LFThemeData.light(),
            child: const Scaffold(
              body: LFAppBarBackV2(icon: Icons.close),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('resolves color from theme', (tester) async {
      final theme = LFThemeData.light().copyWith(
        appBarTheme: const LFAppBarThemeData(
          backButtonColor: Colors.red,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: theme,
            child: const Scaffold(
              body: LFAppBarBackV2(),
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, Colors.red);
    });
  });

  group('LFAppBarActionV2', () {
    testWidgets('renders text action', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: LFThemeData.light(),
            child: const Scaffold(
              body: LFAppBarActionV2(text: 'Done'),
            ),
          ),
        ),
      );

      expect(find.text('Done'), findsOneWidget);
    });

    testWidgets('renders icon action', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: LFThemeData.light(),
            child: const Scaffold(
              body: LFAppBarActionV2(
                icon: Icon(Icons.settings),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: LFTheme(
            data: LFThemeData.light(),
            child: Scaffold(
              body: LFAppBarActionV2(
                text: 'Tap',
                onPressed: () => pressed = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap'));
      await tester.pump();

      expect(pressed, isTrue);
    });
  });
}
