import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../common/models/component_category.dart';
import 'component_registry.dart';

class ComponentListScreen extends LeafScreenStatefulWidget {
  const ComponentListScreen({super.key, required this.category});

  final ComponentCategory category;

  @override
  State<ComponentListScreen> createState() => _ComponentListScreenState();
}

class _ComponentListScreenState extends LeafScreenState<ComponentListScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return LeafAppBar(title: LeafAppBarTitle(text: widget.category.label));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;
    final typography = context.leafTypography;
    final spacing = context.leafSpacing;
    final items = componentRegistry[widget.category] ?? [];

    return ListView.separated(
      padding: EdgeInsets.all(spacing.xl),
      itemCount: items.length,
      separatorBuilder: (_, _) => Divider(height: 1, color: colors.divider),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.title, style: typography.bodyLarge),
          trailing: Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: item.builder)),
        );
      },
    );
  }
}
