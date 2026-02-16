import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ListViewScreen extends LeafScreenStatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends LeafScreenState<ListViewScreen> {
  final _items = List.generate(30, (i) => 'Item ${i + 1}');

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'ListView'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;
    final typography = context.leafTypography;
    final spacing = context.leafSpacing;

    return LeafListView<String>(
      items: _items,
      padding: EdgeInsets.all(spacing.xl),
      builder: (context, item, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: colors.primary,
              child: Text(
                '${index + 1}',
                style: TextStyle(color: colors.onPrimary),
              ),
            ),
            title: Text(item, style: typography.bodyLarge),
            subtitle: Text(
              'Description for $item',
              style: typography.bodySmall,
            ),
          ),
        );
      },
    );
  }
}
