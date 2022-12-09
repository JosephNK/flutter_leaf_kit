part of leaf_container_component;

class LeafContainer extends StatelessWidget {
  final Widget child;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? borderWidth;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  const LeafContainer({
    Key? key,
    required this.child,
    this.constraints,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = this.borderColor ?? Colors.transparent;
    final borderWidth = this.borderWidth ?? EdgeInsets.zero;
    final borderLeft = borderWidth.left;
    final borderTop = borderWidth.top;
    final borderRight = borderWidth.right;
    final borderBottom = borderWidth.bottom;

    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border(
          left: _buildBorderSize(borderLeft, borderColor),
          top: _buildBorderSize(borderTop, borderColor),
          right: _buildBorderSize(borderRight, borderColor),
          bottom: _buildBorderSize(borderBottom, borderColor),
        ),
        boxShadow: boxShadow,
        color: backgroundColor,
      ),
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      child: child,
    );
  }

  BorderSide _buildBorderSize(double width, Color color) {
    return BorderSide(
      color: width != 0.0 ? color : Colors.transparent,
      width: width,
    );
  }
}
