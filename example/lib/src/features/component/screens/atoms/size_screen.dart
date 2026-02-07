import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class SizeScreen extends LFScreenStatefulWidgetV2 {
  const SizeScreen({super.key});

  @override
  State<SizeScreen> createState() => _SizeScreenState();
}

class _SizeScreenState extends LFScreenStateV2<SizeScreen> {
  Size? _measuredSize;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Widget Size'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;
    final typography = context.lfTypography;
    final radius = context.lfRadius;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Size Measurement',
          children: [
            ShowcaseTile(
              label: _measuredSize != null
                  ? 'Measured: ${_measuredSize!.width.toStringAsFixed(1)} x ${_measuredSize!.height.toStringAsFixed(1)}'
                  : 'Measuring...',
              child: LFWidgetSizeV2(
                onChange: (_, size) {
                  if (_measuredSize != size) {
                    setState(() => _measuredSize = size);
                  }
                },
                child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(radius.md),
                    border: Border.all(color: colors.primary),
                  ),
                  child: Center(
                    child: Text('Measure me', style: typography.bodyMedium),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
