part of '../bottom_sheet.dart';

class LFBottomSheet {
  static final LFBottomSheet _instance = LFBottomSheet._internal();
  static LFBottomSheet get shared => _instance;
  LFBottomSheet._internal();

  static void show<T>(
    BuildContext context, {
    required List<LFBottomSheetItem<T>> items,
    LFBottomSheetItem? selectItem,
    ValueChanged<LFBottomSheetItem<T>>? onTap,
    VoidCallback? onClose,
  }) {
    final configure = LFComponentConfigure.shared.bottomSheet;
    final activeColor = configure?.activeColor;
    final inactiveColor = configure?.inactiveColor;
    final cancelText = configure?.cancelText ?? 'Cancel';

    if (Platform.isIOS) {
      /// Cupertino
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            // title: const Text('Choose Options'),
            // message: const Text('Your options are '),
            actions: [
              ...items.map((item) {
                final active = (item.key == selectItem?.key);
                final textStyle = TextStyle(
                  fontWeight: active ? FontWeight.w500 : FontWeight.normal,
                  fontSize: 18.0,
                ).copyWith(
                  color: active ? activeColor : inactiveColor,
                );

                return CupertinoActionSheetAction(
                  onPressed: () async {
                    Navigator.maybePop(context);
                    await Future.delayed(const Duration(milliseconds: 250));
                    if (!item.enabled) return;
                    onTap?.call(item);
                  },
                  child: LFText(item.title, style: textStyle),
                );
              }),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: LFText(
                cancelText,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                ),
              ),
            ),
          );
        },
      );
      return;
    }

    /// Material
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ...items.map((item) {
              final active = (item.key == selectItem?.key);
              final textStyle = TextStyle(
                fontWeight: active ? FontWeight.w500 : FontWeight.normal,
                fontSize: 18.0,
              ).copyWith(
                color: active ? activeColor : inactiveColor,
              );

              return ListTile(
                title: LFText(
                  item.title,
                  style: textStyle,
                ),
                enabled: item.enabled,
                onTap: () async {
                  Navigator.maybePop(context);
                  await Future.delayed(const Duration(milliseconds: 250));
                  if (!item.enabled) return;
                  onTap?.call(item);
                },
              );
            }),
          ],
        );
      },
    ).then((value) {
      onClose?.call();
    });
  }
}
