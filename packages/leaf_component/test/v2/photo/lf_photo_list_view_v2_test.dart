import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/src/component_v2/photo/widget/lf_photo_list_view_v2.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/theme_test_helper.dart';

void main() {
  group('LFPhotoListViewV2', () {
    testWidgets('renders with null assetPath without error', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFPhotoListViewV2(assetPath: null),
        ),
      );
      await tester.pump();

      // Should render without crashing — shows empty grid
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('has semantics label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LFPhotoListViewV2(assetPath: null),
        ),
      );

      expect(find.bySemanticsLabel('Photo grid'), findsWidgets);
    });
  });
}
