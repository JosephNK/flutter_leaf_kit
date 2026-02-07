# LeafThemeData

The central theme data class for the Leaf design system. Holds all six design token sets (colors, typography, spacing, elevation, radius, duration) and 23 optional component-level theme overrides, enabling complete visual customization of the entire component library.

## API Reference

### Constructor Parameters

#### Design Tokens (Required)

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `colors` | `LeafColors` | Yes | -- | Color palette tokens (see [tokens-colors.md](tokens-colors.md)) |
| `typography` | `LeafTypography` | Yes | -- | Typography scale tokens (see [tokens-typography.md](tokens-typography.md)) |
| `spacing` | `LeafSpacing` | Yes | -- | Spacing scale tokens (see [tokens-spacing.md](tokens-spacing.md)) |
| `elevation` | `LeafElevation` | Yes | -- | Elevation and shadow tokens (see [tokens-elevation.md](tokens-elevation.md)) |
| `radius` | `LeafRadius` | Yes | -- | Border radius tokens (see [tokens-radius.md](tokens-radius.md)) |
| `duration` | `LeafDuration` | Yes | -- | Animation duration tokens (see [tokens-duration.md](tokens-duration.md)) |

#### Component Themes (Optional)

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `buttonTheme` | `LeafButtonThemeData?` | No | `null` | Theme overrides for LeafButton |
| `appBarTheme` | `LeafAppBarThemeData?` | No | `null` | Theme overrides for LeafAppBar |
| `textFieldTheme` | `LeafTextFieldThemeData?` | No | `null` | Theme overrides for LeafTextField |
| `dialogTheme` | `LeafDialogThemeData?` | No | `null` | Theme overrides for LeafAlertDialog |
| `checkBoxTheme` | `LeafCheckBoxThemeData?` | No | `null` | Theme overrides for LeafCheckBox |
| `radioTheme` | `LeafRadioThemeData?` | No | `null` | Theme overrides for LeafRadio |
| `chipTheme` | `LeafChipThemeData?` | No | `null` | Theme overrides for LeafChip |
| `switchTheme` | `LeafSwitchThemeData?` | No | `null` | Theme overrides for LeafSwitch |
| `tabBarTheme` | `LeafTabBarThemeData?` | No | `null` | Theme overrides for LeafTabBar |
| `bottomSheetTheme` | `LeafBottomSheetThemeData?` | No | `null` | Theme overrides for LeafBottomSheet |
| `badgeTheme` | `LeafBadgeThemeData?` | No | `null` | Theme overrides for LeafBadge |
| `toastTheme` | `LeafToastThemeData?` | No | `null` | Theme overrides for LeafToast |
| `indicatorTheme` | `LeafIndicatorThemeData?` | No | `null` | Theme overrides for LeafIndicator |
| `skeletonTheme` | `LeafSkeletonThemeData?` | No | `null` | Theme overrides for LeafSkeleton |
| `calendarTheme` | `LeafCalendarThemeData?` | No | `null` | Theme overrides for LeafCalendarView |
| `notificationTheme` | `LeafNotificationThemeData?` | No | `null` | Theme overrides for LeafPushNotification |
| `sliderTheme` | `LeafSliderThemeData?` | No | `null` | Theme overrides for LeafSlider |
| `ratingBarTheme` | `LeafRatingBarThemeData?` | No | `null` | Theme overrides for LeafRatingBar |
| `accordionTheme` | `LeafAccordionThemeData?` | No | `null` | Theme overrides for LeafAccordion |
| `imageTheme` | `LeafImageThemeData?` | No | `null` | Theme overrides for Image widgets |
| `navigationBarTheme` | `LeafNavigationBarThemeData?` | No | `null` | Theme overrides for LeafBottomTabBarScaffold |
| `pageViewTheme` | `LeafPageViewThemeData?` | No | `null` | Theme overrides for LeafPageView |
| `pickerTheme` | `LeafPickerThemeData?` | No | `null` | Theme overrides for LeafDatePicker / LeafTimePicker |

### Factories

| Factory | Description |
|---------|-------------|
| `LeafThemeData.light()` | Creates a light theme with `LeafColors.light()` and default values for all other tokens. Component themes are `null`. |
| `LeafThemeData.dark()` | Creates a dark theme with `LeafColors.dark()` and default values for all other tokens. Component themes are `null`. |

### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith(...)` | `LeafThemeData` | Returns a new instance with selectively overridden token sets and component themes |
| `lerp(a, b, t)` | `LeafThemeData` (static) | Interpolates between two themes. Colors, typography, spacing, and radius use linear interpolation. Elevation, duration, and all component themes use discrete switching at `t < 0.5`. |

## Usage

### Light Theme (Default)

```dart
LeafTheme(
  data: LeafThemeData.light(),
  child: MaterialApp(home: MyApp()),
)
```

### Dark Theme

```dart
LeafTheme(
  data: LeafThemeData.dark(),
  child: MaterialApp(home: MyApp()),
)
```

### Custom Brand Colors

```dart
final theme = LeafThemeData.light().copyWith(
  colors: LeafColors.light().copyWith(
    primary: Color(0xFF6200EE),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF03DAC6),
  ),
);

LeafTheme(
  data: theme,
  child: MaterialApp(home: MyApp()),
)
```

### Component Theme Overrides

```dart
final theme = LeafThemeData.light().copyWith(
  buttonTheme: LeafButtonThemeData(
    backgroundColor: Color(0xFF6200EE),
    foregroundColor: Color(0xFFFFFFFF),
    borderRadius: 24.0,
  ),
  appBarTheme: LeafAppBarThemeData(
    backgroundColor: Color(0xFF6200EE),
    foregroundColor: Color(0xFFFFFFFF),
  ),
  dialogTheme: LeafDialogThemeData(
    backgroundColor: Color(0xFFF5F5F5),
    borderRadius: 16.0,
  ),
);
```

### Full Custom Theme

```dart
final customTheme = LeafThemeData(
  colors: LeafColors.light().copyWith(
    primary: Color(0xFFFF5722),
  ),
  typography: LeafTypography.defaults().copyWith(
    bodyMedium: TextStyle(fontSize: 15.0, fontFamily: 'Inter'),
  ),
  spacing: LeafSpacing.defaults().copyWith(xl: 20.0),
  elevation: LeafElevation.defaults(),
  radius: LeafRadius.defaults().copyWith(md: 12.0),
  duration: LeafDuration.defaults(),
);
```

### Accessing Theme Data in Components

Components follow a three-tier style resolution priority:

```dart
Widget build(BuildContext context) {
  final theme = LeafTheme.of(context);
  final colors = theme.colors;

  // Priority: widget parameter > component theme > global token
  final bgColor = widget.backgroundColor
      ?? theme.buttonTheme?.backgroundColor
      ?? colors.primary;
}
```

### Theme Interpolation (Animated Transitions)

```dart
final lightTheme = LeafThemeData.light();
final darkTheme = LeafThemeData.dark();

// At t=0.0: fully light, at t=1.0: fully dark
final interpolated = LeafThemeData.lerp(lightTheme, darkTheme, 0.5);
```

## Related

- [theme-system.md](theme-system.md) - `LeafTheme` InheritedWidget that propagates this data
- [theme-context.md](theme-context.md) - `BuildContext` extensions for accessing tokens directly
- [tokens-colors.md](tokens-colors.md) - `LeafColors` token reference
- [tokens-typography.md](tokens-typography.md) - `LeafTypography` token reference
- [tokens-spacing.md](tokens-spacing.md) - `LeafSpacing` token reference
- [tokens-elevation.md](tokens-elevation.md) - `LeafElevation` token reference
- [tokens-radius.md](tokens-radius.md) - `LeafRadius` token reference
- [tokens-duration.md](tokens-duration.md) - `LeafDuration` token reference
