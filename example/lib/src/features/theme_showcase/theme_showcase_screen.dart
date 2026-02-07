import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../common/widgets/showcase_scaffold.dart';
import '../../common/widgets/showcase_section.dart';

class ThemeShowcaseScreen extends LFScreenStatefulWidgetV2 {
  const ThemeShowcaseScreen({super.key});

  @override
  State<ThemeShowcaseScreen> createState() => _ThemeShowcaseScreenState();
}

class _ThemeShowcaseScreenState
    extends LFScreenStateV2<ThemeShowcaseScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Theme Showcase'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;
    final typography = context.lfTypography;
    final spacing = context.lfSpacing;
    final radius = context.lfRadius;

    return ShowcaseScaffold(
      children: [
        // Colors
        ShowcaseSection(
          title: 'Colors',
          children: [
            _colorRow('Primary', colors.primary, colors.onPrimary),
            _colorRow('Secondary', colors.secondary, colors.onSecondary),
            _colorRow('Surface', colors.surface, colors.onSurface),
            _colorRow('Background', colors.background, colors.onBackground),
            _colorRow('Error', colors.error, colors.onError),
            SizedBox(height: spacing.md),
            _colorRow('Success', colors.success, Colors.white),
            _colorRow('Warning', colors.warning, Colors.white),
            _colorRow('Info', colors.info, Colors.white),
          ],
        ),

        // Typography
        ShowcaseSection(
          title: 'Typography',
          children: [
            _typographyRow('Display Large', typography.displayLarge),
            _typographyRow('Display Medium', typography.displayMedium),
            _typographyRow('Headline Large', typography.headlineLarge),
            _typographyRow('Headline Medium', typography.headlineMedium),
            _typographyRow('Title Large', typography.titleLarge),
            _typographyRow('Title Medium', typography.titleMedium),
            _typographyRow('Body Large', typography.bodyLarge),
            _typographyRow('Body Medium', typography.bodyMedium),
            _typographyRow('Body Small', typography.bodySmall),
            _typographyRow('Label Large', typography.labelLarge),
            _typographyRow('Label Medium', typography.labelMedium),
            _typographyRow('Label Small', typography.labelSmall),
          ],
        ),

        // Spacing
        ShowcaseSection(
          title: 'Spacing',
          children: [
            _spacingRow('xs', spacing.xs, colors),
            _spacingRow('sm', spacing.sm, colors),
            _spacingRow('md', spacing.md, colors),
            _spacingRow('lg', spacing.lg, colors),
            _spacingRow('xl', spacing.xl, colors),
            _spacingRow('xxl', spacing.xxl, colors),
            _spacingRow('xxxl', spacing.xxxl, colors),
          ],
        ),

        // Radius
        ShowcaseSection(
          title: 'Border Radius',
          children: [
            Wrap(
              spacing: spacing.md,
              runSpacing: spacing.md,
              children: [
                _radiusBox('sm', radius.sm, colors),
                _radiusBox('md', radius.md, colors),
                _radiusBox('lg', radius.lg, colors),
                _radiusBox('xl', radius.xl, colors),
                _radiusBox('full', radius.full, colors),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _colorRow(String name, Color color, Color onColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(color: onColor)),
          Text(
            '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
            style: TextStyle(color: onColor, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _typographyRow(String name, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(name, style: style),
    );
  }

  Widget _spacingRow(String name, double value, LFColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(name, style: const TextStyle(fontSize: 12)),
          ),
          Container(
            width: value * 4,
            height: 20,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text('${value.toStringAsFixed(0)}pt',
              style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _radiusBox(String name, double value, LFColors colors) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.2),
            border: Border.all(color: colors.primary),
            borderRadius: BorderRadius.circular(value),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
