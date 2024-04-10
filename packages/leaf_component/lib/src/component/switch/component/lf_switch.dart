part of '../lf_switch.dart';

class LFSwitch extends StatelessWidget {
  final bool value;
  final Color? activeColor;
  final Color? activeTrackColor;
  final bool isIOSStyle;
  final ValueChanged<bool>? onChanged;

  const LFSwitch({
    super.key,
    required this.value,
    this.activeColor,
    this.activeTrackColor,
    this.isIOSStyle = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || isIOSStyle) {
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
