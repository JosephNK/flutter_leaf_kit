import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafSkeleton', () {
    testWidgets('renders shimmer widget', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafSkeleton(width: 100, height: 20),
        ),
      );

      expect(find.byType(Shimmer), findsOneWidget);
    });

    testWidgets('renders with custom child', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafSkeleton(
            child: SizedBox(width: 200, height: 50),
          ),
        ),
      );

      expect(find.byType(Shimmer), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('resolves colors from theme', (tester) async {
      final theme = LeafThemeData.light().copyWith(
        skeletonTheme: const LeafSkeletonThemeData(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          baseOpacity: 0.5,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          const LeafSkeleton(width: 100, height: 20),
          theme: theme,
        ),
      );

      expect(find.byType(Shimmer), findsOneWidget);
    });

    testWidgets('has loading semantics', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafSkeleton(width: 100, height: 20),
        ),
      );

      final semantics = tester.widgetList<Semantics>(
        find.byType(Semantics),
      );
      final hasLoadingLabel = semantics.any(
        (s) => s.properties.label == 'Loading placeholder',
      );
      expect(hasLoadingLabel, isTrue);
    });
  });
}
