part of leaf_button_component;

class LeafTopButton extends StatelessWidget {
  final Widget icon;
  final bool isShow;
  final bool bottomRight;
  final double defaultBottomPosition;
  final double bottomPosition;
  final VoidCallback? onTap;

  const LeafTopButton({
    Key? key,
    required this.icon,
    required this.isShow,
    this.defaultBottomPosition = -100.0,
    this.bottomPosition = 16.0,
    this.bottomRight = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bottomRight) {
      return AnimatedPositioned(
        right: 14,
        bottom: isShow ? bottomPosition : defaultBottomPosition,
        duration: const Duration(milliseconds: 500),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: isShow ? 1.0 : 0.0,
          child: _buildButton(context),
        ),
      );
    }
    return _buildButton(context);
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        border: Border.all(color: const Color(0xffdee0e8), width: 1),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1a000000),
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0)
        ],
        color: const Color(0xfffbfbfc),
      ),
      child: LeafInkWell(
        width: 36,
        height: 36,
        onTap: onTap,
        child: Center(child: icon),
      ),
    );
  }
}
