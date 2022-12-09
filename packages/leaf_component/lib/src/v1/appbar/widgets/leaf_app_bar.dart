part of leaf_appbar_component;

class LeafAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final double? titleSpacing;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final Color? shadowColor;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;
  final Widget? flexibleSpace;
  final IconThemeData? iconTheme;

  const LeafAppBar({
    Key? key,
    this.title,
    this.titleSpacing,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.shadowColor = Colors.transparent,
    this.bottom,
    this.toolbarHeight,
    this.flexibleSpace,
    this.iconTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      titleSpacing: titleSpacing,
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor ?? Colors.white,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      shadowColor: shadowColor,
      bottom: bottom,
      toolbarHeight: toolbarHeight,
      flexibleSpace: flexibleSpace,
      iconTheme: iconTheme,
      // shape: const Border(bottom: BorderSide(color: Colors.orange, width: 1)),
      // elevation: 4,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      toolbarHeight ?? kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  static PreferredSizeWidget bottomBorder() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: const Color(0x0d000000),
        child: const SizedBox(
          height: 1.0,
          width: 1.0,
          // width: double.infinity,
        ),
      ),
    );
  }
}

// class NanoAppBar extends AppBar {
//   @override
//   final Widget title;

//   @override
//   final Widget leading;

//   @override
//   final List<Widget> actions;

//   @override
//   final Color backgroundColor;

//   @override
//   final bool centerTitle;

//   @override
//   final bool automaticallyImplyLeading;

//   @override
//   final Color shadowColor;

//   @override
//   final PreferredSizeWidget bottom;

//   NanoAppBar({
//     Key key,
//     this.title,
//     this.leading,
//     this.actions,
//     this.backgroundColor,
//     this.centerTitle,
//     this.automaticallyImplyLeading = true,
//     this.shadowColor = Colors.transparent,
//     this.bottom,
//   }) : super(
//           key: key,
//           title: title,
//           leading: leading,
//           actions: actions,
//           backgroundColor: backgroundColor,
//           centerTitle: centerTitle,
//           automaticallyImplyLeading: automaticallyImplyLeading,
//           shadowColor: shadowColor,
//           bottom: bottom,
//         );
// }
