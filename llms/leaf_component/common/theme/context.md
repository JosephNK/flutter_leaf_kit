# LeafThemeContext

A `BuildContext` extension that provides convenient getter shortcuts for accessing the Leaf theme and its individual design token sets. Eliminates boilerplate by allowing direct access to tokens without manually calling `LeafTheme.of(context)` and navigating through `LeafThemeData`.

## API Reference

### Extension Getters

| Getter | Return Type | Equivalent | Description |
|--------|-------------|------------|-------------|
| `leafTheme` | `LeafThemeData` | `LeafTheme.of(this)` | Returns the full theme data from the nearest `LeafTheme` ancestor, or `LeafThemeData.light()` if none exists |
| `leafColors` | `LeafColors` | `leafTheme.colors` | Returns the color palette tokens |
| `leafTypography` | `LeafTypography` | `leafTheme.typography` | Returns the typography scale tokens |
| `leafSpacing` | `LeafSpacing` | `leafTheme.spacing` | Returns the spacing scale tokens |
| `leafElevation` | `LeafElevation` | `leafTheme.elevation` | Returns the elevation and shadow tokens |
| `leafRadius` | `LeafRadius` | `leafTheme.radius` | Returns the border radius tokens |
| `leafDuration` | `LeafDuration` | `leafTheme.duration` | Returns the animation duration tokens |

## Usage

### Basic Access

```dart
Widget build(BuildContext context) {
  final colors = context.leafColors;
  final typography = context.leafTypography;

  return Text(
    'Hello, Leaf!',
    style: typography.headlineMedium.copyWith(color: colors.primary),
  );
}
```

### Accessing All Tokens

```dart
Widget build(BuildContext context) {
  final colors = context.leafColors;
  final typography = context.leafTypography;
  final spacing = context.leafSpacing;
  final elevation = context.leafElevation;
  final radius = context.leafRadius;
  final duration = context.leafDuration;

  return AnimatedContainer(
    duration: duration.normal,
    padding: EdgeInsets.all(spacing.xl),
    decoration: BoxDecoration(
      color: colors.surface,
      borderRadius: BorderRadius.circular(radius.md),
      boxShadow: elevation.shadowMd,
    ),
    child: Text(
      'Themed Card',
      style: typography.titleMedium.copyWith(color: colors.onSurface),
    ),
  );
}
```

### Accessing Component Themes

```dart
Widget build(BuildContext context) {
  final theme = context.leafTheme;

  // Access component-level theme via the full theme data
  final buttonBg = theme.buttonTheme?.backgroundColor ?? theme.colors.primary;
  final dialogRadius = theme.dialogTheme?.borderRadius ?? theme.radius.lg;

  return Container();
}
```

### Comparison: With and Without Extension

```dart
// Without extension (verbose)
Widget build(BuildContext context) {
  final theme = LeafTheme.of(context);
  final colors = theme.colors;
  final typography = theme.typography;
  final spacing = theme.spacing;

  return Padding(
    padding: EdgeInsets.all(spacing.xl),
    child: Text('Hello', style: typography.bodyMedium.copyWith(color: colors.onSurface)),
  );
}

// With extension (concise)
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(context.leafSpacing.xl),
    child: Text(
      'Hello',
      style: context.leafTypography.bodyMedium.copyWith(
        color: context.leafColors.onSurface,
      ),
    ),
  );
}
```

### Inline Usage in Widget Trees

```dart
Column(
  children: [
    SizedBox(height: context.leafSpacing.md),
    Container(
      color: context.leafColors.surfaceVariant,
      padding: EdgeInsets.symmetric(
        horizontal: context.leafSpacing.xl,
        vertical: context.leafSpacing.md,
      ),
      child: Text(
        'Section Title',
        style: context.leafTypography.titleMedium,
      ),
    ),
    Divider(color: context.leafColors.divider),
  ],
)
```

## Related

- [theme-system.md](theme-system.md) - The `LeafTheme` InheritedWidget these getters read from
- [theme-data.md](theme-data.md) - The `LeafThemeData` class returned by `context.leafTheme`
- [tokens-colors.md](tokens-colors.md) - `LeafColors` returned by `context.leafColors`
- [tokens-typography.md](tokens-typography.md) - `LeafTypography` returned by `context.leafTypography`
- [tokens-spacing.md](tokens-spacing.md) - `LeafSpacing` returned by `context.leafSpacing`
- [tokens-elevation.md](tokens-elevation.md) - `LeafElevation` returned by `context.leafElevation`
- [tokens-radius.md](tokens-radius.md) - `LeafRadius` returned by `context.leafRadius`
- [tokens-duration.md](tokens-duration.md) - `LeafDuration` returned by `context.leafDuration`
