import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';

/// A themed switch widget that adapts to the platform.
///
/// Uses [Theme.of(context).platform] instead of `Platform.isIOS` for
/// web-safe platform detection.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LeafSwitchThemeData] from the nearest [LeafTheme]
///   3. Global tokens / hardcoded defaults
@immutable
class LeafSwitch extends StatelessWidget {
  final bool value;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final ValueChanged<bool>? onChanged;

  const LeafSwitch({
    super.key,
    required this.value,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final swTheme = theme.switchTheme;

    final resolvedActiveTrack =
        activeTrackColor ?? swTheme?.activeTrackColor ?? colors.primary;
    final resolvedInactiveTrack =
        inactiveTrackColor ?? swTheme?.inactiveTrackColor ?? colors.inactive;
    final resolvedThumb = thumbColor ?? swTheme?.thumbColor;

    final platform = Theme.of(context).platform;
    final isApple =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    return Semantics(
      toggled: value,
      label: 'Switch',
      child: isApple
          ? CupertinoSwitch(
              value: value,
              activeTrackColor: resolvedActiveTrack,
              inactiveTrackColor: resolvedInactiveTrack,
              thumbColor: resolvedThumb,
              applyTheme: false,
              onChanged: onChanged,
            )
          : Switch(
              value: value,
              thumbColor: WidgetStateProperty.resolveWith<Color?>(
                (states) => resolvedThumb,
              ),
              trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return resolvedInactiveTrack.withValues(alpha: 0.5);
                }
                if (states.contains(WidgetState.selected)) {
                  return resolvedActiveTrack;
                }
                return resolvedInactiveTrack;
              }),
              trackOutlineWidth: WidgetStateProperty.resolveWith<double?>(
                (_) => 0.0,
              ),
              onChanged: onChanged,
            ),
    );
  }
}
