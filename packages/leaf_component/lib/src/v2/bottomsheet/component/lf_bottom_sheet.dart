part of lf_bottom_sheet;

class LFBottomSheetConfigure {
  final Color? activeColor;
  final Color? inactiveColor;

  LFBottomSheetConfigure({
    this.activeColor = Colors.blueAccent,
    this.inactiveColor = Colors.black54,
  });
}

class LFBottomSheet {
  static final LFBottomSheet _instance = LFBottomSheet._internal();
  static LFBottomSheet get shared => _instance;
  LFBottomSheet._internal();

  static LFBottomSheetConfigure get configure =>
      LFBottomSheet.shared._configure ?? LFBottomSheetConfigure();

  LFBottomSheetConfigure? _configure;

  void setup({required LFBottomSheetConfigure configure}) {
    _configure = configure;
  }

  static void show(
    BuildContext context, {
    required List<LFBottomSheetItem> items,
    LFBottomSheetItem? selectItem,
    ValueChanged<LFBottomSheetItem>? onTap,
    VoidCallback? onClose,
  }) {
    final activeColor = LFBottomSheet.configure.activeColor;
    final inactiveColor = LFBottomSheet.configure.inactiveColor;

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
              }).toList(),
            ],
            // cancelButton: CupertinoActionSheetAction(
            //   isDefaultAction: true,
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: const LFText(
            //     'Cancel',
            //     style: TextStyle(
            //       fontWeight: FontWeight.normal,
            //       fontSize: 18.0,
            //     ),
            //   ),
            // ),
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
            }).toList(),
          ],
        );
      },
    ).then((value) {
      onClose?.call();
    });
  }
}
