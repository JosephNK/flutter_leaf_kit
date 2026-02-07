import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class SkeletonScreen extends LeafScreenStatefulWidget {
  const SkeletonScreen({super.key});

  @override
  State<SkeletonScreen> createState() => _SkeletonScreenState();
}

class _SkeletonScreenState extends LeafScreenState<SkeletonScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Skeleton'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final spacing = context.leafSpacing;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Basic Skeleton',
          children: [
            ShowcaseTile(
              label: 'Rectangle',
              child: LeafSkeleton(width: 200, height: 20),
            ),
            ShowcaseTile(
              label: 'Circle',
              child: LeafSkeleton(width: 48, height: 48, radius: 24),
            ),
            ShowcaseTile(
              label: 'Rounded rectangle',
              child: LeafSkeleton(width: 200, height: 100, radius: 12),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Content Placeholder',
          children: [
            ShowcaseTile(
              label: 'Card layout',
              child: Row(
                children: [
                  LeafSkeleton(width: 48, height: 48, radius: 24),
                  SizedBox(width: spacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LeafSkeleton(height: 14, radius: 4),
                        SizedBox(height: spacing.md),
                        LeafSkeleton(width: 150, height: 10, radius: 4),
                      ],
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
