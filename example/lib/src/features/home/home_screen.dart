import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../common/models/package_entry.dart';
import '../component/component_catalog_screen.dart';
import '../theme_showcase/theme_showcase_screen.dart';

class HomeScreen extends LFScreenStatefulWidgetV2 {
  const HomeScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends LFScreenStateV2<HomeScreen> {
  late final List<PackageEntry> _entries;

  @override
  void initState() {
    super.initState();
    _entries = [
      PackageEntry(
        title: 'Components',
        subtitle: 'V2 UI component library',
        icon: Icons.widgets_outlined,
        builder: (_) => const ComponentCatalogScreen(),
      ),
      PackageEntry(
        title: 'Theme Showcase',
        subtitle: 'Design tokens visualization',
        icon: Icons.palette_outlined,
        builder: (_) => const ThemeShowcaseScreen(),
      ),
      PackageEntry(
        title: 'Network',
        subtitle: 'Coming Soon',
        icon: Icons.cloud_outlined,
        builder: (_) => const SizedBox.shrink(),
        enabled: false,
      ),
      PackageEntry(
        title: 'Manager',
        subtitle: 'Coming Soon',
        icon: Icons.settings_outlined,
        builder: (_) => const SizedBox.shrink(),
        enabled: false,
      ),
      PackageEntry(
        title: 'Store',
        subtitle: 'Coming Soon',
        icon: Icons.storage_outlined,
        builder: (_) => const SizedBox.shrink(),
        enabled: false,
      ),
    ];
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return LFAppBarV2(
      title: const LFAppBarTitleV2(text: 'Leaf Kit V2'),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
          onPressed: widget.onToggleTheme,
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;
    final typography = context.lfTypography;
    final spacing = context.lfSpacing;
    final radius = context.lfRadius;

    return ListView.separated(
      padding: EdgeInsets.all(spacing.xl),
      itemCount: _entries.length,
      separatorBuilder: (_, _) => SizedBox(height: spacing.md),
      itemBuilder: (context, index) {
        final entry = _entries[index];
        return Opacity(
          opacity: entry.enabled ? 1.0 : 0.5,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius.lg),
            ),
            child: ListTile(
              leading: Icon(entry.icon, color: colors.primary),
              title: Text(entry.title, style: typography.titleMedium),
              subtitle: Text(entry.subtitle, style: typography.bodySmall),
              trailing: entry.enabled
                  ? Icon(Icons.chevron_right, color: colors.onSurfaceVariant)
                  : LFBadgeV2(text: 'Soon', size: 24),
              enabled: entry.enabled,
              onTap: entry.enabled
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: entry.builder),
                      )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
