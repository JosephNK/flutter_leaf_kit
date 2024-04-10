part of '../lf_accordion.dart';

class LFAccordionSection extends StatefulWidget {
  final String title;
  final bool expand;
  final String? subtitle;
  final Color? borderColor;
  final ValueChanged<bool>? onPressed;

  const LFAccordionSection({
    super.key,
    required this.title,
    required this.expand,
    this.subtitle,
    this.borderColor,
    this.onPressed,
  });

  @override
  State<LFAccordionSection> createState() => _LFAccordionSectionState();
}

class _LFAccordionSectionState extends State<LFAccordionSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animation = Tween(begin: 0.0, end: -pi).animate(_animationController);

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
  void didUpdateWidget(covariant LFAccordionSection oldWidget) {
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
    final title = widget.title;
    final subtitle = widget.subtitle;
    final expand = widget.expand;
    final borderColor = widget.borderColor;
    final onPressed = widget.onPressed;

    return LFInkWell(
      onTap: () {
        onPressed?.call(!expand);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: borderColor ?? Colors.grey[300] ?? Colors.grey,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LFText(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                Visibility(
                  visible: isNotEmpty(subtitle),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: LFText(
                      subtitle ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                )
              ],
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value,
                  child: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.black87,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
