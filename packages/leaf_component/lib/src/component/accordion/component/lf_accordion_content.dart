part of '../lf_accordion.dart';

class LFAccordionContent extends StatefulWidget {
  final Widget child;
  final bool expand;

  const LFAccordionContent({
    super.key,
    required this.child,
    required this.expand,
  });

  @override
  State<LFAccordionContent> createState() => _LFAccordionContentState();
}

class _LFAccordionContentState extends State<LFAccordionContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );

    if (widget.expand) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFAccordionContent oldWidget) {
    if (oldWidget.expand != widget.expand) {
      if (widget.expand) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: _animation,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(16.0),
        child: (widget.expand) ? widget.child : Container(),
      ),
    );
  }
}
