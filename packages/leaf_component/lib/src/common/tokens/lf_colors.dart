import 'dart:ui';

class LFColors {
  // Brand
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;

  // Surface
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;

  // Background
  final Color background;
  final Color onBackground;

  // State
  final Color error;
  final Color onError;
  final Color success;
  final Color warning;
  final Color info;

  // Interactive
  final Color active;
  final Color inactive;
  final Color disabled;
  final Color focus;
  final Color hover;

  // Specific
  final Color divider;
  final Color shadow;
  final Color overlay;
  final Color shimmerBase;
  final Color shimmerHighlight;

  const LFColors({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.background,
    required this.onBackground,
    required this.error,
    required this.onError,
    required this.success,
    required this.warning,
    required this.info,
    required this.active,
    required this.inactive,
    required this.disabled,
    required this.focus,
    required this.hover,
    required this.divider,
    required this.shadow,
    required this.overlay,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  factory LFColors.light() {
    return const LFColors(
      primary: Color(0xFF448AFF),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF625B71),
      onSecondary: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1C1B1F),
      surfaceVariant: Color(0xFFF5F5F5),
      onSurfaceVariant: Color(0xFF757575),
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFF1C1B1F),
      error: Color(0xFFE53935),
      onError: Color(0xFFFFFFFF),
      success: Color(0xFF43A047),
      warning: Color(0xFFFFA726),
      info: Color(0xFF29B6F6),
      active: Color(0xFF448AFF),
      inactive: Color(0xFF9E9E9E),
      disabled: Color(0xFFBDBDBD),
      focus: Color(0xFF448AFF),
      hover: Color(0x14000000),
      divider: Color(0xFFE0E0E0),
      shadow: Color(0x40000000),
      overlay: Color(0x8A000000),
      shimmerBase: Color(0xFFE0E0E0),
      shimmerHighlight: Color(0xFFF5F5F5),
    );
  }

  factory LFColors.dark() {
    return const LFColors(
      primary: Color(0xFF82B1FF),
      onPrimary: Color(0xFF002F6C),
      secondary: Color(0xFFCCC2DC),
      onSecondary: Color(0xFF332D41),
      surface: Color(0xFF1E1E1E),
      onSurface: Color(0xFFE6E1E5),
      surfaceVariant: Color(0xFF2C2C2C),
      onSurfaceVariant: Color(0xFFCAC4D0),
      background: Color(0xFF121212),
      onBackground: Color(0xFFE6E1E5),
      error: Color(0xFFEF9A9A),
      onError: Color(0xFF601410),
      success: Color(0xFFA5D6A7),
      warning: Color(0xFFFFCC80),
      info: Color(0xFF81D4FA),
      active: Color(0xFF82B1FF),
      inactive: Color(0xFF757575),
      disabled: Color(0xFF616161),
      focus: Color(0xFF82B1FF),
      hover: Color(0x14FFFFFF),
      divider: Color(0xFF424242),
      shadow: Color(0x66000000),
      overlay: Color(0xB3000000),
      shimmerBase: Color(0xFF424242),
      shimmerHighlight: Color(0xFF616161),
    );
  }

  LFColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? background,
    Color? onBackground,
    Color? error,
    Color? onError,
    Color? success,
    Color? warning,
    Color? info,
    Color? active,
    Color? inactive,
    Color? disabled,
    Color? focus,
    Color? hover,
    Color? divider,
    Color? shadow,
    Color? overlay,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) {
    return LFColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      active: active ?? this.active,
      inactive: inactive ?? this.inactive,
      disabled: disabled ?? this.disabled,
      focus: focus ?? this.focus,
      hover: hover ?? this.hover,
      divider: divider ?? this.divider,
      shadow: shadow ?? this.shadow,
      overlay: overlay ?? this.overlay,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    );
  }

  static LFColors lerp(LFColors a, LFColors b, double t) {
    return LFColors(
      primary: Color.lerp(a.primary, b.primary, t)!,
      onPrimary: Color.lerp(a.onPrimary, b.onPrimary, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      onSecondary: Color.lerp(a.onSecondary, b.onSecondary, t)!,
      surface: Color.lerp(a.surface, b.surface, t)!,
      onSurface: Color.lerp(a.onSurface, b.onSurface, t)!,
      surfaceVariant: Color.lerp(a.surfaceVariant, b.surfaceVariant, t)!,
      onSurfaceVariant:
          Color.lerp(a.onSurfaceVariant, b.onSurfaceVariant, t)!,
      background: Color.lerp(a.background, b.background, t)!,
      onBackground: Color.lerp(a.onBackground, b.onBackground, t)!,
      error: Color.lerp(a.error, b.error, t)!,
      onError: Color.lerp(a.onError, b.onError, t)!,
      success: Color.lerp(a.success, b.success, t)!,
      warning: Color.lerp(a.warning, b.warning, t)!,
      info: Color.lerp(a.info, b.info, t)!,
      active: Color.lerp(a.active, b.active, t)!,
      inactive: Color.lerp(a.inactive, b.inactive, t)!,
      disabled: Color.lerp(a.disabled, b.disabled, t)!,
      focus: Color.lerp(a.focus, b.focus, t)!,
      hover: Color.lerp(a.hover, b.hover, t)!,
      divider: Color.lerp(a.divider, b.divider, t)!,
      shadow: Color.lerp(a.shadow, b.shadow, t)!,
      overlay: Color.lerp(a.overlay, b.overlay, t)!,
      shimmerBase: Color.lerp(a.shimmerBase, b.shimmerBase, t)!,
      shimmerHighlight:
          Color.lerp(a.shimmerHighlight, b.shimmerHighlight, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LFColors &&
        other.primary == primary &&
        other.onPrimary == onPrimary &&
        other.secondary == secondary &&
        other.onSecondary == onSecondary &&
        other.surface == surface &&
        other.onSurface == onSurface &&
        other.surfaceVariant == surfaceVariant &&
        other.onSurfaceVariant == onSurfaceVariant &&
        other.background == background &&
        other.onBackground == onBackground &&
        other.error == error &&
        other.onError == onError &&
        other.success == success &&
        other.warning == warning &&
        other.info == info &&
        other.active == active &&
        other.inactive == inactive &&
        other.disabled == disabled &&
        other.focus == focus &&
        other.hover == hover &&
        other.divider == divider &&
        other.shadow == shadow &&
        other.overlay == overlay &&
        other.shimmerBase == shimmerBase &&
        other.shimmerHighlight == shimmerHighlight;
  }

  @override
  int get hashCode => Object.hashAll([
        primary,
        onPrimary,
        secondary,
        onSecondary,
        surface,
        onSurface,
        surfaceVariant,
        onSurfaceVariant,
        background,
        onBackground,
        error,
        onError,
        success,
        warning,
        info,
        active,
        inactive,
        disabled,
        focus,
        hover,
        divider,
        shadow,
        overlay,
        shimmerBase,
        shimmerHighlight,
      ]);
}
