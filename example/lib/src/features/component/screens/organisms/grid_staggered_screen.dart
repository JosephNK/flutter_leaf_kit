import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class GridStaggeredScreen extends LeafScreenStatefulWidget {
  const GridStaggeredScreen({super.key});

  @override
  State<GridStaggeredScreen> createState() => _GridStaggeredScreenState();
}

class _GridStaggeredScreenState extends LeafScreenState<GridStaggeredScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Staggered Grid'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;
    final radius = context.leafRadius;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Staggered Grid',
          children: [
            ShowcaseTile(
              label: 'Mixed tile sizes',
              child: LeafStaggeredGrid(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [
                  LeafStaggeredGridTile(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(radius.md),
                      ),
                      child: const Center(child: Text('2x2')),
                    ),
                  ),
                  LeafStaggeredGridTile(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.secondary.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(radius.md),
                      ),
                      child: const Center(child: Text('2x1')),
                    ),
                  ),
                  LeafStaggeredGridTile(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.error.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(radius.md),
                      ),
                      child: const Center(child: Text('1x1')),
                    ),
                  ),
                  LeafStaggeredGridTile(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.success.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(radius.md),
                      ),
                      child: const Center(child: Text('1x1')),
                    ),
                  ),
                  LeafStaggeredGridTile(
                    crossAxisCellCount: 4,
                    mainAxisCellCount: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.warning.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(radius.md),
                      ),
                      child: const Center(child: Text('4x1')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
