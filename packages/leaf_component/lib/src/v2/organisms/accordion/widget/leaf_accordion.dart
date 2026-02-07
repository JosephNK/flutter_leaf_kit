import 'package:flutter/material.dart';

import '../model/leaf_accordion_item.dart';
import 'leaf_accordion_tile.dart';

@immutable
class LeafAccordion<T> extends StatelessWidget {
  final List<LeafAccordionItem<T>> items;
  final Widget Function(BuildContext context, int index, T data) itemBuilder;
  final int? expandedIndex;
  final Set<int>? expandedIndices;
  final bool allowMultiple;
  final ValueChanged<int>? onExpansionChanged;
  final Color? headerBackgroundColor;
  final Color? contentBackgroundColor;
  final Color? dividerColor;
  final Color? iconColor;
  final EdgeInsets? headerPadding;
  final EdgeInsets? contentPadding;
  final Duration? expandDuration;

  const LeafAccordion({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.expandedIndex,
    this.expandedIndices,
    this.allowMultiple = false,
    this.onExpansionChanged,
    this.headerBackgroundColor,
    this.contentBackgroundColor,
    this.dividerColor,
    this.iconColor,
    this.headerPadding,
    this.contentPadding,
    this.expandDuration,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isExpanded = allowMultiple
              ? (expandedIndices?.contains(index) ?? false)
              : expandedIndex == index;

          return LeafAccordionTile(
            key: ValueKey('accordion_tile_$index'),
            title: item.title,
            subtitle: item.subtitle,
            expanded: isExpanded,
            onExpansionChanged: (_) => onExpansionChanged?.call(index),
            headerBackgroundColor: headerBackgroundColor,
            contentBackgroundColor: contentBackgroundColor,
            dividerColor: dividerColor,
            iconColor: iconColor,
            headerPadding: headerPadding,
            contentPadding: contentPadding,
            expandDuration: expandDuration,
            child: itemBuilder(context, index, item.data),
          );
        }),
      ),
    );
  }
}
