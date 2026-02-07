import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LeafAppBar', () {
    testWidgets('renders with title widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              appBar: const LeafAppBar(
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
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LeafTheme(
                          data: LeafThemeData.light(),
                          child: const Scaffold(
                            appBar: LeafAppBar(
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

  group('LeafAppBarBack', () {
    testWidgets('renders with default icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: const Scaffold(
              body: LeafAppBarBack(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    });

    testWidgets('uses custom icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: const Scaffold(
              body: LeafAppBarBack(icon: Icons.close),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('resolves color from theme', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        appBarTheme: const LeafAppBarThemeData(
          backButtonColor: Colors.red,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: LeafTheme(
            data: theme,
            child: const Scaffold(
              body: LeafAppBarBack(),
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, Colors.red);
    });
  });

  group('LeafAppBarAction', () {
    testWidgets('renders text action', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: const Scaffold(
              body: LeafAppBarAction(text: 'Done'),
            ),
          ),
        ),
      );

      expect(find.text('Done'), findsOneWidget);
    });

    testWidgets('renders icon action', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: const Scaffold(
              body: LeafAppBarAction(
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
          home: LeafTheme(
            data: LeafThemeData.light(),
            child: Scaffold(
              body: LeafAppBarAction(
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
