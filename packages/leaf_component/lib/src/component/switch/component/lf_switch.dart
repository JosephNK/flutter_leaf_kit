part of lf_switch;

class LFSwitch extends StatelessWidget {
  final bool value;
  final Color? activeColor;
  final Color? activeTrackColor;
  final ValueChanged<bool>? onChanged;

  const LFSwitch({
    Key? key,
    required this.value,
    this.activeColor,
    this.activeTrackColor,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        value: value,
        activeColor: activeColor,
        trackColor: activeTrackColor,
        onChanged: onChanged,
      );
    }
    return Switch(
      value: value,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      activeColor: activeColor,
      activeTrackColor: activeTrackColor,
      onChanged: onChanged,
    );
  }
}
