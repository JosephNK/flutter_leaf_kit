part of '../appbar.dart';

@Deprecated('Use LFAppBarV2 instead')
class LFAppBarHelper {
  static Widget? buildLeading(
    BuildContext context, {
    required Widget? leading,
    IconData? backIconData,
  }) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    final leadingWidget = (leading != null)
        ? leading
        : canPop
        ? LFAppBarBack(
            icon: backIconData,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        : null;

    return leadingWidget;
  }
}
