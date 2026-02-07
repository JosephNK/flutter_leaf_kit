import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../model/lf_bottom_sheet_item_v2.dart';

/// A themed bottom sheet that shows a list of action items.
///
/// On iOS/macOS, displays a [CupertinoActionSheet].
/// On other platforms, displays a Material [showModalBottomSheet].
///
/// Style resolution order:
///   1. Explicit widget parameters ([activeColor], [inactiveColor])
///   2. [LFBottomSheetThemeData] from the nearest [LFTheme]
///   3. Global tokens ([LFColors.primary], [LFColors.onSurface])
class LFBottomSheetV2 {
  const LFBottomSheetV2._();

  static void show<T>(
    BuildContext context, {
    required List<LFBottomSheetItemV2<T>> items,
    LFBottomSheetItemV2<T>? selectedItem,
    Color? activeColor,
    Color? inactiveColor,
    TextStyle? itemTextStyle,
    String? cancelText,
    ValueChanged<LFBottomSheetItemV2<T>>? onTap,
    VoidCallback? onClose,
  }) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final componentTheme = theme.bottomSheetTheme;

    final resolvedActiveColor =
        activeColor ?? componentTheme?.activeColor ?? colors.primary;
    final resolvedInactiveColor =
        inactiveColor ?? componentTheme?.inactiveColor ?? colors.onSurface;
    final resolvedItemTextStyle = itemTextStyle ?? componentTheme?.itemTextStyle;
    final resolvedCancelText =
        cancelText ?? componentTheme?.cancelText ?? 'Cancel';

    final platform = Theme.of(context).platform;
    final isApple =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    if (isApple) {
      _showCupertinoSheet<T>(
        context,
        items: items,
        selectedItem: selectedItem,
        resolvedActiveColor: resolvedActiveColor,
        resolvedInactiveColor: resolvedInactiveColor,
        itemTextStyle: resolvedItemTextStyle,
        cancelText: resolvedCancelText,
        onTap: onTap,
      );
      return;
    }

    _showMaterialSheet<T>(
      context,
      items: items,
      selectedItem: selectedItem,
      resolvedActiveColor: resolvedActiveColor,
      resolvedInactiveColor: resolvedInactiveColor,
      itemTextStyle: resolvedItemTextStyle,
      onTap: onTap,
      onClose: onClose,
    );
  }

  static void _showCupertinoSheet<T>(
    BuildContext context, {
    required List<LFBottomSheetItemV2<T>> items,
    LFBottomSheetItemV2<T>? selectedItem,
    required Color resolvedActiveColor,
    required Color resolvedInactiveColor,
    TextStyle? itemTextStyle,
    required String cancelText,
    ValueChanged<LFBottomSheetItemV2<T>>? onTap,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoActionSheet(
          actions: items.map((item) {
            final active = item.key == selectedItem?.key;
            final baseStyle = itemTextStyle ??
                const TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0);
            final textStyle = baseStyle.copyWith(
              fontWeight: active ? FontWeight.w500 : FontWeight.normal,
              color: active ? resolvedActiveColor : resolvedInactiveColor,
            );

            return CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.maybePop(ctx);
                await Future.delayed(const Duration(milliseconds: 250));
                if (!item.enabled) return;
                onTap?.call(item);
              },
              child: Text(item.title, style: textStyle),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(ctx),
            child: Text(
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
  }

  static void _showMaterialSheet<T>(
    BuildContext context, {
    required List<LFBottomSheetItemV2<T>> items,
    LFBottomSheetItemV2<T>? selectedItem,
    required Color resolvedActiveColor,
    required Color resolvedInactiveColor,
    TextStyle? itemTextStyle,
    ValueChanged<LFBottomSheetItemV2<T>>? onTap,
    VoidCallback? onClose,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Semantics(
          label: 'Bottom sheet',
          child: Wrap(
            children: items.map((item) {
              final active = item.key == selectedItem?.key;
              final baseStyle = itemTextStyle ??
                  const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 18.0);
              final textStyle = baseStyle.copyWith(
                fontWeight: active ? FontWeight.w500 : FontWeight.normal,
                color: active ? resolvedActiveColor : resolvedInactiveColor,
              );

              return ListTile(
                title: Text(item.title, style: textStyle),
                enabled: item.enabled,
                onTap: () async {
                  Navigator.maybePop(ctx);
                  await Future.delayed(const Duration(milliseconds: 250));
                  if (!item.enabled) return;
                  onTap?.call(item);
                },
              );
            }).toList(),
          ),
        );
      },
    ).then((_) {
      onClose?.call();
    });
  }
}
