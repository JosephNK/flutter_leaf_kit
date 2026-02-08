import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/src/v2/organisms/photo/widget/leaf_photo_list_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafPhotoListView', () {
    testWidgets('renders with null assetPath without error', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafPhotoListView(assetPath: null)),
      );
      await tester.pump();

      // Should render without crashing — shows empty grid
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('has semantics label', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafPhotoListView(assetPath: null)),
      );

      expect(find.bySemanticsLabel('Photo grid'), findsWidgets);
    });
  });
}
