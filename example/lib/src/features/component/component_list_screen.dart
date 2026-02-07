import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../common/models/component_category.dart';
import 'component_registry.dart';

class ComponentListScreen extends LFScreenStatefulWidgetV2 {
  const ComponentListScreen({
    super.key,
    required this.category,
  });

  final ComponentCategory category;

  @override
  State<ComponentListScreen> createState() => _ComponentListScreenState();
}

class _ComponentListScreenState extends LFScreenStateV2<ComponentListScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return LFAppBarV2(
      title: LFAppBarTitleV2(text: widget.category.label),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;
    final typography = context.lfTypography;
    final spacing = context.lfSpacing;
    final items = componentRegistry[widget.category] ?? [];

    return ListView.separated(
      padding: EdgeInsets.all(spacing.xl),
      itemCount: items.length,
      separatorBuilder: (_, _) => Divider(height: 1, color: colors.divider),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.title, style: typography.bodyLarge),
          trailing: Icon(
            Icons.chevron_right,
            color: colors.onSurfaceVariant,
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: item.builder),
          ),
        );
      },
    );
  }
}
