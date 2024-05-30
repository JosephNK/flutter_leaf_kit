part of '../button.dart';

class LFCornerPosition {
  final double show;
  final double hide;

  LFCornerPosition({
    this.show = 0.0,
    this.hide = 0.0,
  });
}

class LFCornerPositionButton extends StatelessWidget {
  final bool show;
  final Widget? child;
  final LFCornerPosition? leftTop;
  final LFCornerPosition? rightTop;
  final LFCornerPosition? leftBottom;
  final LFCornerPosition? rightBottom;
  final BoxDecoration? decoration;
  final VoidCallback? onTap;

  const LFCornerPositionButton({
    super.key,
    required this.show,
    this.child,
    this.leftTop,
    this.rightTop,
    this.leftBottom,
    this.rightBottom,
    this.decoration,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 500);

    double? top, left, right, bottom;
    if (leftTop != null) {
      left = leftTop!.show;
      top = show ? leftTop!.show : leftTop!.hide;
    }
    if (rightTop != null) {
      right = rightTop!.show;
      top = show ? rightTop!.show : rightTop!.hide;
    }
    if (leftBottom != null) {
      left = leftBottom!.show;
      bottom = show ? leftBottom!.show : leftBottom!.hide;
    }
    if (rightBottom != null) {
      right = rightBottom!.show;
      bottom = show ? rightBottom!.show : rightBottom!.hide;
    }

    return AnimatedPositioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      duration: duration,
      child: AnimatedOpacity(
        duration: duration,
        opacity: show ? 1.0 : 0.0,
        child: _buildButton(context),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      decoration: decoration ??
          BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            border: Border.all(color: const Color(0xffdee0e8), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1a000000),
                offset: Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
              )
            ],
            color: const Color(0xfffbfbfc),
          ),
      child: LFLockGestureDetector(
        showLoading: false,
        onTap: onTap,
        child: Center(
          child: child ??
              Icon(
                Icons.arrow_upward_sharp,
                color: Colors.black.withOpacity(0.6),
              ),
        ),
      ),
    );
  }
}
