# LeafThemeData

Central theme configuration class that bundles all design tokens and 23 optional component theme overrides into a single immutable object. Used by `LeafTheme` to propagate styling through the widget tree.

## API Reference

### Constructor Parameters

#### Design Tokens (required)
| Parameter | Type | Description |
|-----------|------|-------------|
| `colors` | `LeafColors` | Color tokens |
| `typography` | `LeafTypography` | Typography tokens |
| `spacing` | `LeafSpacing` | Spacing tokens |
| `elevation` | `LeafElevation` | Elevation tokens |
| `radius` | `LeafRadius` | Border radius tokens |
| `duration` | `LeafDuration` | Animation duration tokens |

#### Component Themes (all optional, nullable)
| Parameter | Type | Target Component |
|-----------|------|------------------|
| `buttonTheme` | `LeafButtonThemeData?` | LeafButton |
| `appBarTheme` | `LeafAppBarThemeData?` | LeafAppBar |
| `textFieldTheme` | `LeafTextFieldThemeData?` | LeafTextField |
| `dialogTheme` | `LeafDialogThemeData?` | LeafAlertDialog |
| `checkBoxTheme` | `LeafCheckBoxThemeData?` | LeafCheckBox |
| `radioTheme` | `LeafRadioThemeData?` | LeafRadio |
| `chipTheme` | `LeafChipThemeData?` | LeafChip |
| `switchTheme` | `LeafSwitchThemeData?` | LeafSwitch |
| `tabBarTheme` | `LeafTabBarThemeData?` | LeafTabBar |
| `bottomSheetTheme` | `LeafBottomSheetThemeData?` | LeafBottomSheet |
| `badgeTheme` | `LeafBadgeThemeData?` | LeafBadge |
| `toastTheme` | `LeafToastThemeData?` | LeafToast |
| `indicatorTheme` | `LeafIndicatorThemeData?` | LeafIndicator |
| `skeletonTheme` | `LeafSkeletonThemeData?` | LeafSkeleton |
| `calendarTheme` | `LeafCalendarThemeData?` | LeafCalendarView |
| `notificationTheme` | `LeafNotificationThemeData?` | LeafPushNotification |
| `sliderTheme` | `LeafSliderThemeData?` | LeafSlider |
| `ratingBarTheme` | `LeafRatingBarThemeData?` | LeafRatingBar |
| `accordionTheme` | `LeafAccordionThemeData?` | LeafAccordion |
| `imageTheme` | `LeafImageThemeData?` | Image widgets |
| `navigationBarTheme` | `LeafNavigationBarThemeData?` | LeafBottomTabBarScaffold |
| `pageViewTheme` | `LeafPageViewThemeData?` | LeafPageView |
| `pickerTheme` | `LeafPickerThemeData?` | LeafDatePicker, LeafTimePicker |

### Factory Constructors

| Factory | Description |
|---------|-------------|
| `LeafThemeData.light()` | Light theme with `LeafColors.light()` and all default tokens |
| `LeafThemeData.dark()` | Dark theme with `LeafColors.dark()` and all default tokens |

Both factories use `LeafTypography.defaults()`, `LeafSpacing.defaults()`, `LeafElevation.defaults()`, `LeafRadius.defaults()`, and `LeafDuration.defaults()`. Component themes are `null` (components fall back to global tokens).

### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith({...})` | `LeafThemeData` | Returns a copy with the given fields replaced |
| `LeafThemeData.lerp(a, b, t)` | `LeafThemeData` | Interpolates tokens. Colors, typography, spacing, and radius use `lerp`. Elevation, duration, and component themes use threshold (`t < 0.5`). |

## Component Theme Data Classes

Each component theme class follows the same pattern: all-optional nullable properties and a `copyWith()` method.

### LeafButtonThemeData
`textStyle`, `backgroundColor`, `foregroundColor`, `padding`, `leadingSpacing`

### LeafAppBarThemeData
`backgroundColor`, `foregroundColor`, `backButtonColor`, `bottomBorderColor`, `shadowColor`, `elevation`, `scrolledUnderElevation`, `toolbarHeight`, `actionsRightMargin`, `titleStyle`

### LeafTextFieldThemeData
`textStyle`, `textColor`, `disabledTextColor`, `placeholderColor`, `backgroundColor`, `disabledBackgroundColor`, `borderColor`, `focusBorderColor`, `errorBorderColor`, `clearIconColor`, `disabledClearIconColor`, `contentPadding`, `borderRadius`, `borderWidth`, `countTextStyle`, `errorTextStyle`

### LeafDialogThemeData
`titleStyle`, `messageStyle`, `okTextStyle`, `okTextBackgroundColor`, `okTextBorderColor`, `okTextPadding`, `cancelTextStyle`, `cancelTextBackgroundColor`, `cancelTextBorderColor`, `cancelTextPadding`, `borderRadius`, `okText`, `cancelText`, `errorMessageTitle`

### LeafCheckBoxThemeData
`activeColor`, `inactiveColor`, `runSpacing`

### LeafRadioThemeData
`activeColor`, `inactiveColor`

### LeafChipThemeData
`defaultColor`, `selectedColor`, `padding`, `borderRadius`

### LeafSwitchThemeData
`activeTrackColor`, `inactiveTrackColor`, `thumbColor`

### LeafTabBarThemeData
`labelColor`, `unselectedLabelColor`, `labelStyle`, `unselectedLabelStyle`, `indicatorColor`, `dividerColor`, `indicatorPadding`, `labelPadding`

### LeafBottomSheetThemeData
`activeColor`, `inactiveColor`, `itemTextStyle`, `cancelText`

### LeafBadgeThemeData
`size`, `backgroundColor`, `iconColor`, `textStyle`, `padding`, `elevation`

### LeafToastThemeData
`backgroundColor`, `textStyle`, `descriptionTextStyle`, `borderRadius`

### LeafIndicatorThemeData
`padding`, `strokeWidth`

### LeafSkeletonThemeData
`baseColor`, `highlightColor`, `baseOpacity`, `highlightOpacity`, `radius`

### LeafCalendarThemeData
`todayColor`, `selectedColor`, `holidayColor`, `dayTextStyle`, `okText`

### LeafNotificationThemeData
`boxDecoration`, `animationDuration`, `titleTextStyle`, `bodyTextStyle`, `iconColor`, `iconSize`

### LeafSliderThemeData
`activeTrackColor`, `inactiveTrackColor`, `thumbColor`

### LeafRatingBarThemeData
`ratedColor`, `unratedColor`, `size`, `spacing`

### LeafAccordionThemeData
`headerBackgroundColor`, `contentBackgroundColor`, `dividerColor`, `iconColor`

### LeafImageThemeData
`placeholderColor`, `errorColor`, `borderRadius`

### LeafNavigationBarThemeData
`backgroundColor`, `selectedColor`, `unselectedColor`, `labelStyle`

### LeafPageViewThemeData
`indicatorActiveColor`, `indicatorInactiveColor`, `autoPageDuration`, `fadeTransitionDuration`

### LeafPickerThemeData
`activeColor`, `backgroundColor`, `headerTextStyle`

## Style Resolution Order

Components resolve styling in this priority:

```
Widget parameter > Component theme > Global token
```

```dart
// Inside a component's build method:
final theme = LeafTheme.of(context);
final colors = theme.colors;

final bgColor = widget.backgroundColor        // 1. Widget parameter
    ?? theme.buttonTheme?.backgroundColor      // 2. Component theme
    ?? colors.primary;                         // 3. Global token
```

## Usage

### Light Theme with Component Overrides
```dart
LeafTheme(
  data: LeafThemeData.light().copyWith(
    buttonTheme: LeafButtonThemeData(
      backgroundColor: Color(0xFF6200EE),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
    dialogTheme: LeafDialogThemeData(
      okText: 'Confirm',
      cancelText: 'Cancel',
    ),
  ),
  child: MyApp(),
);
```

### Custom Token Overrides
```dart
LeafThemeData(
  colors: LeafColors.light().copyWith(primary: Color(0xFF009688)),
  typography: LeafTypography.defaults(),
  spacing: LeafSpacing.defaults().copyWith(md: 12.0),
  elevation: LeafElevation.defaults(),
  radius: LeafRadius.defaults().copyWith(md: 12.0),
  duration: LeafDuration.defaults(),
);
```
