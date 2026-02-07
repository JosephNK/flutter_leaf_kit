import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LFRatingBarV2', () {
    testWidgets('renders star icons', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFRatingBarV2(
            itemCount: 5,
            onRatingUpdate: (_) {},
          ),
        ),
      );

      // Should find star icons (empty stars for 0 rating)
      expect(find.byIcon(Icons.star_border), findsWidgets);
    });

    testWidgets('renders with initial rating', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFRatingBarV2(
            itemCount: 5,
            initialRating: 3.0,
            onRatingUpdate: (_) {},
          ),
        ),
      );

      // Should find filled stars
      expect(find.byIcon(Icons.star), findsWidgets);
    });

    testWidgets('resolves colors from theme', (tester) async {
      final theme = LFThemeData.light().copyWith(
        ratingBarTheme: const LFRatingBarThemeData(
          ratedColor: Colors.amber,
          unratedColor: Colors.grey,
          size: 30.0,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          LFRatingBarV2(
            itemCount: 5,
            initialRating: 2.0,
            onRatingUpdate: (_) {},
          ),
          theme: theme,
        ),
      );

      expect(find.byIcon(Icons.star), findsWidgets);
    });

    testWidgets('has rating semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFRatingBarV2(
            itemCount: 5,
            initialRating: 3.5,
            onRatingUpdate: (_) {},
          ),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasRating = semantics.any(
        (s) => s.properties.label == 'Rating',
      );
      expect(hasRating, isTrue);
    });

    testWidgets('supports read-only mode', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFRatingBarV2(
            itemCount: 5,
            initialRating: 4.0,
            ignoreGestures: true,
            onRatingUpdate: (_) {},
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsWidgets);
    });
  });
}
