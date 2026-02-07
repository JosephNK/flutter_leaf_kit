import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class PainterScreen extends LFScreenStatefulWidgetV2 {
  const PainterScreen({super.key});

  @override
  State<PainterScreen> createState() => _PainterScreenState();
}

class _PainterScreenState extends LFScreenStateV2<PainterScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Painter'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Timeline Painter',
          children: [
            ShowcaseTile(
              label: 'Vertical timeline',
              child: SizedBox(
                height: 200,
                width: 40,
                child: CustomPaint(
                  painter: LFTimelinePainterV2(
                    width: 40,
                    lineColor: colors.primary,
                    strokeWidth: 2,
                  ),
                  size: const Size(40, 200),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
