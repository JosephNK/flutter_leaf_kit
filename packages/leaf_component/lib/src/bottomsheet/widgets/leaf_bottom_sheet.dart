part of leaf_bottom_sheet_component;

class LeafBottomSheetItem {
  final dynamic key;
  final String title;
  final bool enabled;

  LeafBottomSheetItem({
    required this.key,
    required this.title,
    this.enabled = true,
  });
}

class LeafBottomSheet {
  static void show(
    BuildContext context, {
    required List<LeafBottomSheetItem> items,
    required LeafBottomSheetItem selectItem,
    required TextStyle activeTextStyle,
    required TextStyle deactiveTextStyle,
    ValueChanged<LeafBottomSheetItem>? onTap,
    VoidCallback? onClose,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: items.map((item) {
            return ListTile(
              title: LeafText(
                item.title,
                style: (item.key == selectItem.key)
                    ? activeTextStyle
                    : deactiveTextStyle,
              ),
              enabled: item.enabled,
              onTap: () async {
                Navigator.maybePop(context);
                await Future.delayed(const Duration(milliseconds: 250));
                if (!item.enabled) return;
                onTap?.call(item);
              },
            );
          }).toList(),
        );
      },
    ).then((value) {
      onClose?.call();
    });
  }
}
