import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_leaf_component/src/v2/organisms/grid/index.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafStaggeredGrid', () {
    testWidgets('renders with required crossAxisCount', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafStaggeredGrid(crossAxisCount: 2),
        ),
      );

      expect(find.byType(LeafStaggeredGrid), findsOneWidget);
    });

    testWidgets('renders child tiles', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafStaggeredGrid(
            crossAxisCount: 2,
            children: [
              LeafStaggeredGridTile(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Text('Tile 1'),
              ),
              LeafStaggeredGridTile(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Text('Tile 2'),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Tile 1'), findsOneWidget);
      expect(find.text('Tile 2'), findsOneWidget);
    });

    testWidgets('applies spacing', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafStaggeredGrid(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 12,
            children: [
              LeafStaggeredGridTile(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Text('A'),
              ),
              LeafStaggeredGridTile(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Text('B'),
              ),
            ],
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
    });
  });

  group('LeafStaggeredGridTile', () {
    testWidgets('renders child content', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          const LeafStaggeredGrid(
            crossAxisCount: 2,
            children: [
              LeafStaggeredGridTile(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: Text('Full Width Tile'),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Full Width Tile'), findsOneWidget);
    });
  });
}
