part of lf_radio;

enum LFRadioAlign {
  left,
  right,
}

class LFRadio extends StatelessWidget {
  final Widget? leading;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final bool value;
  final String? text;
  final TextStyle? textStyle;
  final LFRadioAlign align;
  final MainAxisAlignment mainAxisAlignment;
  final ValueChanged<bool>? onChanged;

  const LFRadio({
    Key? key,
    this.leading,
    this.activeIcon,
    this.inactiveIcon,
    this.value = false,
    this.text,
    this.textStyle,
    this.align = LFRadioAlign.left,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leading = this.leading;
    final mainAxisAlignment = this.mainAxisAlignment;
    final activeIcon = this.activeIcon ??
        const Icon(
          Icons.radio_button_checked,
          color: Colors.blueAccent,
        );
    final inactiveIcon = this.activeIcon ??
        const Icon(
          Icons.radio_button_off,
          color: Colors.grey,
        );

    final children = [
      value ? activeIcon : inactiveIcon,
      Visibility(
        visible: isNotEmpty(text),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Row(
            children: [
              leading ?? Container(),
              LFText(
                text ?? '',
                style: textStyle,
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
          if (align == LFRadioAlign.left)
            ...children
          else
            ...children.reversed.toList()
        ],
      ),
    );
  }
}
