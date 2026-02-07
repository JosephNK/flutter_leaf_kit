import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ListViewScreen extends LFScreenStatefulWidgetV2 {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends LFScreenStateV2<ListViewScreen> {
  final _items = List.generate(30, (i) => 'Item ${i + 1}');

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'ListView'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.lfColors;
    final typography = context.lfTypography;
    final spacing = context.lfSpacing;

    return LFListViewV2<String>(
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
            subtitle: Text('Description for $item', style: typography.bodySmall),
          ),
        );
      },
    );
  }
}
