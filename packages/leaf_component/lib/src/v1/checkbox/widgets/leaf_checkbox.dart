part of leaf_checkbox_component;

class LeafCheckBox extends StatelessWidget {
  final Widget actvieIcon;
  final Widget deactvieIcon;
  final bool value;
  final String? text;
  final TextStyle? textStyle;
  final MainAxisAlignment? mainAxisAlignment;
  final ValueChanged<bool>? onChanged;

  const LeafCheckBox({
    Key? key,
    required this.actvieIcon,
    required this.deactvieIcon,
    required this.value,
    this.text,
    this.textStyle,
    this.mainAxisAlignment,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged?.call(!value);
      },
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        children: [
          value ? actvieIcon : deactvieIcon,
          Visibility(
            visible: isNotEmpty(text),
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: LeafText(
                text ?? '',
                style: textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
