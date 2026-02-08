import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafAssetImage', () {
    testWidgets('shows error icon for null uri', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafAssetImage(width: 100, height: 100)),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('shows error icon for empty uri', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafAssetImage(uri: Uri.parse(''), width: 100, height: 100),
        ),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('uses custom error widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafAssetImage(
            width: 100,
            height: 100,
            errorWidget: Text('Error'),
          ),
        ),
      );

      expect(find.text('Error'), findsOneWidget);
    });
  });

  group('LeafMemoryImage', () {
    testWidgets('shows error icon for null bytes', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafMemoryImage(width: 100, height: 100)),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('shows error icon for empty bytes', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafMemoryImage(bytes: Uint8List(0), width: 100, height: 100),
        ),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('uses custom error widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafMemoryImage(
            width: 100,
            height: 100,
            errorWidget: Text('Custom'),
          ),
        ),
      );

      expect(find.text('Custom'), findsOneWidget);
    });
  });

  group('LeafCacheNetworkImage', () {
    testWidgets('shows error icon for empty url', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafCacheNetworkImage(width: 100, height: 100)),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('uses custom error widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCacheNetworkImage(
            width: 100,
            height: 100,
            errorWidget: Text('Net Error'),
          ),
        ),
      );

      expect(find.text('Net Error'), findsOneWidget);
    });
  });

  group('LeafCacheImage', () {
    testWidgets('delegates to asset for non-url uri', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LeafCacheImage(
            uri: Uri.parse('assets/images/test.png'),
            width: 100,
            height: 100,
          ),
        ),
      );

      // Routes to LeafAssetImage for non-network URIs
      expect(find.byType(LeafAssetImage), findsOneWidget);
    });

    testWidgets('applies border radius via ClipRRect', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCacheImage(width: 100, height: 100, borderRadius: 8.0),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LeafCacheImage),
          matching: find.byType(ClipRRect),
        ),
        findsOneWidget,
      );
    });

    testWidgets('resolves border radius from theme', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        imageTheme: const LeafImageThemeData(borderRadius: 12.0),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCacheImage(width: 100, height: 100),
          theme: theme,
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LeafCacheImage),
          matching: find.byType(ClipRRect),
        ),
        findsOneWidget,
      );
    });
  });

  group('LeafCircleAvatarImage', () {
    testWidgets('renders with ClipOval', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const LeafCircleAvatarImage()));

      expect(find.byType(ClipOval), findsOneWidget);
    });

    testWidgets('renders with border', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafCircleAvatarImage(
            size: 30,
            borderWidth: 2.0,
            borderColor: Colors.blue,
          ),
        ),
      );

      expect(find.byType(ClipOval), findsOneWidget);
    });

    testWidgets('has avatar semantics', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const LeafCircleAvatarImage()));

      final semantics = tester.widgetList<Semantics>(find.byType(Semantics));
      final hasAvatar = semantics.any(
        (s) => s.properties.label == 'Avatar image',
      );
      expect(hasAvatar, isTrue);
    });

    testWidgets('shows error for null sources', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const LeafCircleAvatarImage()));

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });
  });
}
