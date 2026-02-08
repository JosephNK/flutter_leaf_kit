part of '../switch.dart';

@Deprecated('Use LeafSwitch instead')
class LFSwitch extends StatelessWidget {
  final bool value;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final bool isIOS;
  final ValueChanged<bool>? onChanged;

  const LFSwitch({
    super.key,
    required this.value,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.isIOS = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoSwitch(
        value: value,
        activeTrackColor: activeTrackColor,
        inactiveTrackColor: inactiveTrackColor,
        thumbColor: thumbColor,
        applyTheme: false,
        onChanged: onChanged,
      );
    }
    return Switch(
      value: value,
      thumbColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.disabled)) {
          return thumbColor?.withValues(alpha: 0.5);
        }
        if (states.contains(WidgetState.selected)) {
          return thumbColor;
        }
        if (states.contains(WidgetState.hovered)) {
          return thumbColor;
        }
        return thumbColor;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.disabled)) {
          return inactiveTrackColor?.withValues(alpha: 0.5);
        }
        if (states.contains(WidgetState.selected)) {
          return activeTrackColor;
        }
        if (states.contains(WidgetState.hovered)) {
          return activeTrackColor;
        }
        return inactiveTrackColor;
      }),
      trackOutlineWidth: WidgetStateProperty.resolveWith<double?>((
        Set<WidgetState> states,
      ) {
        return 0.0;
      }),
      onChanged: onChanged,
    );
  }
}
