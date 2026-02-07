import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/theme_test_helper.dart';

void main() {
  group('LFAssetImageV2', () {
    testWidgets('shows error icon for null uri', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFAssetImageV2(width: 100, height: 100),
        ),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('shows error icon for empty uri', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFAssetImageV2(
            uri: Uri.parse(''),
            width: 100,
            height: 100,
          ),
        ),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('uses custom error widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFAssetImageV2(
            width: 100,
            height: 100,
            errorWidget: Text('Error'),
          ),
        ),
      );

      expect(find.text('Error'), findsOneWidget);
    });
  });

  group('LFMemoryImageV2', () {
    testWidgets('shows error icon for null bytes', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFMemoryImageV2(width: 100, height: 100),
        ),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('shows error icon for empty bytes', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFMemoryImageV2(
            bytes: Uint8List(0),
            width: 100,
            height: 100,
          ),
        ),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('uses custom error widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFMemoryImageV2(
            width: 100,
            height: 100,
            errorWidget: Text('Custom'),
          ),
        ),
      );

      expect(find.text('Custom'), findsOneWidget);
    });
  });

  group('LFCacheNetworkImageV2', () {
    testWidgets('shows error icon for empty url', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFCacheNetworkImageV2(width: 100, height: 100),
        ),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('uses custom error widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFCacheNetworkImageV2(
            width: 100,
            height: 100,
            errorWidget: Text('Net Error'),
          ),
        ),
      );

      expect(find.text('Net Error'), findsOneWidget);
    });
  });

  group('LFCacheImageV2', () {
    testWidgets('delegates to asset for non-url uri', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFCacheImageV2(
            uri: Uri.parse('assets/images/test.png'),
            width: 100,
            height: 100,
          ),
        ),
      );

      // Routes to LFAssetImageV2 for non-network URIs
      expect(find.byType(LFAssetImageV2), findsOneWidget);
    });

    testWidgets('applies border radius via ClipRRect', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFCacheImageV2(
            width: 100,
            height: 100,
            borderRadius: 8.0,
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LFCacheImageV2),
          matching: find.byType(ClipRRect),
        ),
        findsOneWidget,
      );
    });

    testWidgets('resolves border radius from theme', (tester) async {
      final theme = LFThemeData.light().copyWith(
        imageTheme: const LFImageThemeData(borderRadius: 12.0),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LFCacheImageV2(width: 100, height: 100),
          theme: theme,
        ),
      );

      expect(
        find.descendant(
          of: find.byType(LFCacheImageV2),
          matching: find.byType(ClipRRect),
        ),
        findsOneWidget,
      );
    });
  });

  group('LFCircleAvatarImageV2', () {
    testWidgets('renders with ClipOval', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFCircleAvatarImageV2(),
        ),
      );

      expect(find.byType(ClipOval), findsOneWidget);
    });

    testWidgets('renders with border', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFCircleAvatarImageV2(
            size: 30,
            borderWidth: 2.0,
            borderColor: Colors.blue,
          ),
        ),
      );

      expect(find.byType(ClipOval), findsOneWidget);
    });

    testWidgets('has avatar semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFCircleAvatarImageV2(),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasAvatar = semantics.any(
        (s) => s.properties.label == 'Avatar image',
      );
      expect(hasAvatar, isTrue);
    });

    testWidgets('shows error for null sources', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFCircleAvatarImageV2(),
        ),
      );

      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });
  });
}
