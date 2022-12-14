part of lf_checkbox;

enum LFCheckBoxAlign {
  left,
  right,
}

class LFCheckBox extends StatelessWidget {
  final Widget? leading;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final bool value;
  final String? text;
  final TextStyle? textStyle;
  final double runSpacing;
  final LFCheckBoxAlign align;
  final MainAxisAlignment mainAxisAlignment;
  final ValueChanged<bool>? onChanged;

  const LFCheckBox({
    Key? key,
    this.leading,
    this.activeIcon,
    this.inactiveIcon,
    this.value = false,
    this.text,
    this.textStyle,
    this.runSpacing = 4.0,
    this.align = LFCheckBoxAlign.left,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leading = this.leading;
    final mainAxisAlignment = this.mainAxisAlignment;
    final activeIcon = this.activeIcon ??
        const Icon(
          Icons.check_box,
          color: Colors.blueAccent,
        );
    final inactiveIcon = this.inactiveIcon ??
        const Icon(
          Icons.check_box_outline_blank,
          color: Colors.grey,
        );

    final children = [
      value ? activeIcon : inactiveIcon,
      Visibility(
        visible: isNotEmpty(text),
        child: Padding(
          padding: EdgeInsets.only(left: runSpacing),
          child: Row(
            children: [
              leading ?? Container(),
              Align(
                alignment: Alignment.topCenter,
                child: LFText(
                  text ?? '',
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return LFInkWell(
      onTap: () {
        onChanged?.call(!value);
      },
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (align == LFCheckBoxAlign.left)
            ...children
          else
            ...children.reversed.toList()
        ],
      ),
    );
  }
}
