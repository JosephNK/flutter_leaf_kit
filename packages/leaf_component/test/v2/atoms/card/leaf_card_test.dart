import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

/// Finds the [Material] widget that is a direct descendant of [LeafCard].
Finder findCardMaterial() {
  return find.descendant(
    of: find.byType(LeafCard),
    matching: find.byType(Material),
  );
}

/// Finds the [Container] widget that is a direct descendant of [LeafCard].
Finder findCardContainer() {
  return find.descendant(
    of: find.byType(LeafCard),
    matching: find.byType(Container),
  );
}

void main() {
  group('LeafCard', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafCard(child: Text('Hello'))),
      );

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('renders with header and footer', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCard(
            header: Text('Header'),
            footer: Text('Footer'),
            child: Text('Body'),
          ),
        ),
      );

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('uses default elevated variant', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafCard(child: Text('Elevated'))),
      );

      final material = tester.widget<Material>(findCardMaterial().first);
      expect(material.elevation, 2.0);
    });

    testWidgets('uses outlined variant', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCard(
            variant: LeafCardVariant.outlined,
            child: Text('Outlined'),
          ),
        ),
      );

      final material = tester.widget<Material>(findCardMaterial().first);
      expect(material.elevation, 0.0);
    });

    testWidgets('uses filled variant', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCard(
            variant: LeafCardVariant.filled,
            child: Text('Filled'),
          ),
        ),
      );

      final material = tester.widget<Material>(findCardMaterial().first);
      expect(material.elevation, 0.0);
    });

    testWidgets('explicit backgroundColor overrides theme', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        cardTheme: const LeafCardThemeData(backgroundColor: Colors.orange),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCard(
            backgroundColor: Colors.green,
            child: Text('Override'),
          ),
          theme: theme,
        ),
      );

      final container = tester.widget<Container>(findCardContainer().first);
      final decoration = container.decoration as BoxDecoration?;
      expect(decoration?.color, Colors.green);
    });

    testWidgets('resolves colors from cardTheme', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        cardTheme: const LeafCardThemeData(backgroundColor: Colors.amber),
      );

      await tester.pumpWidget(
        wrapWithTheme(const LeafCard(child: Text('Themed')), theme: theme),
      );

      final container = tester.widget<Container>(findCardContainer().first);
      final decoration = container.decoration as BoxDecoration?;
      expect(decoration?.color, Colors.amber);
    });

    testWidgets('calls onTap callback', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafCard(onTap: () => tapped = true, child: const Text('Tappable')),
        ),
      );

      await tester.tap(find.text('Tappable'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('calls onLongPress callback', (tester) async {
      var longPressed = false;

      await tester.pumpWidget(
        wrapWithTheme(
          LeafCard(
            onLongPress: () => longPressed = true,
            child: const Text('LongPress'),
          ),
        ),
      );

      await tester.longPress(find.text('LongPress'));
      await tester.pumpAndSettle();

      expect(longPressed, isTrue);
    });

    testWidgets('applies custom borderRadius', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCard(borderRadius: 24.0, child: Text('Rounded')),
        ),
      );

      final material = tester.widget<Material>(findCardMaterial().first);
      final borderRadius = material.borderRadius as BorderRadius;
      expect(borderRadius, BorderRadius.circular(24.0));
    });

    testWidgets('applies custom elevation', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafCard(elevation: 8.0, child: Text('High'))),
      );

      final material = tester.widget<Material>(findCardMaterial().first);
      expect(material.elevation, 8.0);
    });

    testWidgets('has semantics label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCard(semanticLabel: 'Profile card', child: Text('Content')),
        ),
      );

      final semantics = tester.widgetList<Semantics>(find.byType(Semantics));
      final hasLabel = semantics.any(
        (s) => s.properties.label == 'Profile card',
      );
      expect(hasLabel, isTrue);
    });

    testWidgets('clips content when clipBehavior set', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCard(clipBehavior: Clip.hardEdge, child: Text('Clipped')),
        ),
      );

      final material = tester.widget<Material>(findCardMaterial().first);
      expect(material.clipBehavior, Clip.hardEdge);
    });
  });
}
