part of lf_appbar;

const double kLFToolbarHeight = 52.0;

class LFAppBar extends StatelessWidget implements PreferredSizeWidget {
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
  final double? toolbarHeight;
  final Widget? flexibleSpace;
  final double? elevation;
  final VoidCallback? onBackPressed;

  const LFAppBar({
    Key? key,
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
    this.bottom,
    this.toolbarHeight,
    this.flexibleSpace,
    this.elevation,
    this.onBackPressed,
  }) : super(key: key);

  IconThemeData get defaultIconTheme =>
      const IconThemeData(color: Colors.black);

  TextStyle get defaultTitleTextStyle =>
      const TextStyle(color: Colors.black, fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    final centerTitle = this.centerTitle ?? Platform.isIOS ? true : false;
    final toolbarHeight = this.toolbarHeight ?? kLFToolbarHeight;
    final leadingWidth = this.leadingWidth ?? toolbarHeight;
    final backgroundColor = this.backgroundColor ?? Colors.white;
    final backButtonColor = this.backButtonColor ?? Colors.black;
    final bottomBorderColor = this.bottomBorderColor ??
        LFComponentConfigure.shared.appBar?.bottomBorderColor;

    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    return PreferredSize(
      preferredSize: Size.fromHeight(toolbarHeight),
      child: AppBar(
        title: title,
        titleSpacing: !canPop ? titleSpacing : 0.0,
        leading: (leading != null)
            ? leading
            : canPop
                ? LFAppBarBack(
                    color: backButtonColor,
                    onPressed: () {
                      Navigator.maybePop(context);
                      onBackPressed?.call();
                    },
                  )
                : null,
        leadingWidth: leadingWidth,
        actions: actions,
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        automaticallyImplyLeading: automaticallyImplyLeading,
        shadowColor: shadowColor,
        bottom: bottom ?? LFAppBar.bottomBorder(bottomBorderColor),
        toolbarHeight: toolbarHeight,
        flexibleSpace: flexibleSpace,
        iconTheme: defaultIconTheme,
        titleTextStyle: defaultTitleTextStyle,
        // shape: const Border(bottom: BorderSide(color: Colors.orange, width: 1)),
        elevation: elevation,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ??
      kLFToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  static PreferredSizeWidget bottomBorder(Color? color) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: color,
        child: const SizedBox(
          width: double.infinity,
          height: 1.0,
        ),
      ),
    );
  }
}
