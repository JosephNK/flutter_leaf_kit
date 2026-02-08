import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/src/v2/organisms/scroll/index.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafDisallowGlowBehavior', () {
    testWidgets('suppresses overscroll glow', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          ScrollConfiguration(
            behavior: LeafDisallowGlowBehavior(),
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (_, i) => Text('Item $i'),
            ),
          ),
        ),
      );

      // Verify GlowingOverscrollIndicator is NOT present
      expect(find.byType(GlowingOverscrollIndicator), findsNothing);
    });

    testWidgets('returns child directly from buildOverscrollIndicator', (
      tester,
    ) async {
      await tester.pumpWidget(wrapWithTheme(const SizedBox()));

      final behavior = LeafDisallowGlowBehavior();
      final child = Container();
      final ctx = tester.element(find.byType(SizedBox));
      final result = behavior.buildOverscrollIndicator(
        ctx,
        child,
        const ScrollableDetails(direction: AxisDirection.down),
      );
      expect(result, same(child));
    });
  });
}
