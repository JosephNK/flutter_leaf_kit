import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../common/models/component_category.dart';
import 'component_list_screen.dart';
import 'component_registry.dart';

class ComponentCatalogScreen extends LeafScreenStatefulWidget {
  const ComponentCatalogScreen({super.key});

  @override
  State<ComponentCatalogScreen> createState() => _ComponentCatalogScreenState();
}

class _ComponentCatalogScreenState
    extends LeafScreenState<ComponentCatalogScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Components'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;
    final typography = context.leafTypography;
    final spacing = context.leafSpacing;
    final radius = context.leafRadius;
    final categories = ComponentCategory.values;

    return ListView.separated(
      padding: EdgeInsets.all(spacing.xl),
      itemCount: categories.length,
      separatorBuilder: (_, _) => SizedBox(height: spacing.md),
      itemBuilder: (context, index) {
        final category = categories[index];
        final items = componentRegistry[category] ?? [];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.lg),
          ),
          child: ListTile(
            leading: Icon(category.icon, color: colors.primary),
            title: Text(category.label, style: typography.titleMedium),
            subtitle: Text(
              '${items.length} components',
              style: typography.bodySmall,
            ),
            trailing: Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ComponentListScreen(category: category),
              ),
            ),
          ),
        );
      },
    );
  }
}
