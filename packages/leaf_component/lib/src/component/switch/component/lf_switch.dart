part of '../switch.dart';

class LFSwitch extends StatelessWidget {
  final bool value;
  final Color? activeTrackColor;
  final Color? trackColor;
  final Color? thumbColor;
  final bool isIOS;
  final ValueChanged<bool>? onChanged;

  const LFSwitch({
    super.key,
    required this.value,
    this.activeTrackColor,
    this.trackColor,
    this.thumbColor,
    this.isIOS = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoSwitch(
        value: value,
        activeColor: activeTrackColor,
        trackColor: trackColor,
        thumbColor: thumbColor,
        applyTheme: false,
        onChanged: onChanged,
      );
    }
    return Switch(
      value: value,
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return thumbColor?.withOpacity(0.5);
          }
          if (states.contains(WidgetState.selected)) {
            return thumbColor;
          }
          if (states.contains(WidgetState.hovered)) {
            return thumbColor;
          }
          return thumbColor;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return trackColor?.withOpacity(0.5);
          }
          if (states.contains(WidgetState.selected)) {
            return activeTrackColor;
          }
          if (states.contains(WidgetState.hovered)) {
            return activeTrackColor;
          }
          return trackColor;
        },
      ),
      trackOutlineWidth: WidgetStateProperty.resolveWith<double?>(
        (Set<WidgetState> states) {
          return 0.0;
        },
      ),
      onChanged: onChanged,
    );
  }
}
