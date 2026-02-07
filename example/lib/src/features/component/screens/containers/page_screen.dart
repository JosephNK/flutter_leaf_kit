import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class PageScreen extends LFScreenStatefulWidgetV2 {
  const PageScreen({super.key});

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends LFScreenStateV2<PageScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'PageView'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;
    final radius = context.lfRadius;

    final pages = [
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.orange.shade100,
      Colors.purple.shade100,
    ];

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Auto-Paging',
          children: [
            ShowcaseTile(
              label: 'With indicators',
              child: SizedBox(
                height: 200,
                child: LFPageViewV2(
                  autoPage: true,
                  children: pages.map((color) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radius.lg),
                      ),
                      child: Center(
                        child: Text(
                          'Page ${pages.indexOf(color) + 1}',
                          style: TextStyle(
                            fontSize: 24,
                            color: colors.onSurface,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Manual Paging',
          children: [
            ShowcaseTile(
              label: 'Without auto-page',
              child: SizedBox(
                height: 150,
                child: LFPageViewV2(
                  autoPage: false,
                  children: pages.map((color) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radius.lg),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
