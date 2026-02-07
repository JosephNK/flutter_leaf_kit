import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/theme/theme.dart';
import 'lf_appbar_back_v2.dart';

const double kLFToolbarHeightV2 = 52.0;

/// A themed AppBar widget that resolves all styles from the LF design token
/// system.
///
/// Differences from v1 [LFAppBar]:
///   - No dependency on [LFComponentConfigure]
///   - Uses [Theme.of(context).platform] instead of [Platform.isIOS]
///   - Full 3-level style cascade: param > appBarTheme > global tokens
@immutable
class LFAppBarV2 extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final double? titleSpacing;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? backButtonColor;
  final Color? bottomBorderColor;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final Color? shadowColor;
  final PreferredSizeWidget? bottom;
  final double? actionsRightMargin;
  final double? toolbarHeight;
  final Widget? flexibleSpace;
  final double? elevation;
  final double? scrolledUnderElevation;
  final bool primary;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool forceMaterialTransparency;
  final bool excludeHeaderSemantics;
  final double toolbarOpacity;
  final double bottomOpacity;
  final VoidCallback? onBackPressed;

  const LFAppBarV2({
    super.key,
    this.title,
    this.titleSpacing,
    this.leading,
    this.leadingWidth,
    this.actions,
    this.backgroundColor,
    this.backButtonColor,
    this.bottomBorderColor,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.shadowColor = Colors.transparent,
    this.actionsRightMargin,
    this.bottom,
    this.toolbarHeight,
    this.flexibleSpace,
    this.elevation,
    this.scrolledUnderElevation,
    this.primary = true,
    this.systemOverlayStyle,
    this.forceMaterialTransparency = false,
    this.excludeHeaderSemantics = false,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final abTheme = theme.appBarTheme;

    // Resolve styles
    final resolvedIconTheme = IconThemeData(
      color: abTheme?.foregroundColor ?? colors.onSurface,
    );
    final resolvedTitleTextStyle = abTheme?.titleStyle ??
        theme.typography.titleLarge.copyWith(color: colors.onSurface);

    final platform = Theme.of(context).platform;
    final isApple =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
    final resolvedCenterTitle = centerTitle ?? isApple;
    final resolvedToolbarHeight =
        toolbarHeight ?? abTheme?.toolbarHeight ?? kLFToolbarHeightV2;
    final resolvedLeadingWidth = leadingWidth ?? resolvedToolbarHeight;
    final resolvedBg = backgroundColor ??
        abTheme?.backgroundColor ??
        colors.surface;
    final resolvedBackButtonColor =
        backButtonColor ?? abTheme?.backButtonColor ?? colors.onSurface;
    final resolvedBottomBorderColor =
        bottomBorderColor ?? abTheme?.bottomBorderColor;
    final resolvedElevation = elevation ?? abTheme?.elevation;
    final resolvedActionsRightMargin =
        actionsRightMargin ?? abTheme?.actionsRightMargin;

    final parentRoute = ModalRoute.of(context);
    final canPop = parentRoute?.canPop ?? false;

    return PreferredSize(
      preferredSize: Size.fromHeight(resolvedToolbarHeight),
      child: AppBar(
        title: title,
        titleSpacing: !canPop ? titleSpacing : 0.0,
        leading: leading ??
            (canPop
                ? LFAppBarBackV2(
                    color: resolvedBackButtonColor,
                    onPressed: () {
                      if (onBackPressed != null) {
                        onBackPressed!.call();
                      } else {
                        Navigator.maybePop(context);
                      }
                    },
                  )
                : null),
        leadingWidth: resolvedLeadingWidth,
        actions: [
          ...actions ?? [],
          if (resolvedActionsRightMargin != null)
            SizedBox(width: resolvedActionsRightMargin),
        ],
        backgroundColor: resolvedBg,
        centerTitle: resolvedCenterTitle,
        automaticallyImplyLeading: automaticallyImplyLeading,
        shadowColor: shadowColor,
        bottom: bottom ?? _bottomBorder(resolvedBottomBorderColor),
        toolbarHeight: resolvedToolbarHeight,
        flexibleSpace: flexibleSpace,
        iconTheme: resolvedIconTheme,
        titleTextStyle: resolvedTitleTextStyle,
        elevation: resolvedElevation,
        scrolledUnderElevation: scrolledUnderElevation,
        primary: primary,
        systemOverlayStyle: systemOverlayStyle,
        forceMaterialTransparency: forceMaterialTransparency,
        excludeHeaderSemantics: excludeHeaderSemantics,
        toolbarOpacity: toolbarOpacity,
        bottomOpacity: bottomOpacity,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight ??
            kLFToolbarHeightV2 + (bottom?.preferredSize.height ?? 0.0),
      );

  static PreferredSizeWidget _bottomBorder(Color? color) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: color,
        child: const SizedBox(width: double.infinity, height: 1.0),
      ),
    );
  }
}
