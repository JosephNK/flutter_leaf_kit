# LeafThemeContext

`BuildContext` extension for quick access to the Leaf theme and its design tokens. Eliminates boilerplate when reading theme values in widget `build` methods.

## API Reference

### Extension: LeafThemeContext on BuildContext

| Getter | Return Type | Equivalent |
|--------|-------------|------------|
| `context.leafTheme` | `LeafThemeData` | `LeafTheme.of(context)` |
| `context.leafColors` | `LeafColors` | `LeafTheme.of(context).colors` |
| `context.leafTypography` | `LeafTypography` | `LeafTheme.of(context).typography` |
| `context.leafSpacing` | `LeafSpacing` | `LeafTheme.of(context).spacing` |
| `context.leafElevation` | `LeafElevation` | `LeafTheme.of(context).elevation` |
| `context.leafRadius` | `LeafRadius` | `LeafTheme.of(context).radius` |
| `context.leafDuration` | `LeafDuration` | `LeafTheme.of(context).duration` |

All getters call `LeafTheme.of(context)` internally, which falls back to `LeafThemeData.light()` if no ancestor `LeafTheme` is found.

## Usage

### Before (verbose)
```dart
Widget build(BuildContext context) {
  final theme = LeafTheme.of(context);
  final colors = theme.colors;
  final typography = theme.typography;
  final spacing = theme.spacing;

  return Padding(
    padding: EdgeInsets.all(spacing.md),
    child: Text('Hello', style: typography.bodyMedium.copyWith(color: colors.onSurface)),
  );
}
```

### After (concise)
```dart
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(context.leafSpacing.md),
    child: Text(
      'Hello',
      style: context.leafTypography.bodyMedium.copyWith(
        color: context.leafColors.onSurface,
      ),
    ),
  );
}
```

### Accessing Component Themes
```dart
// Component themes are accessed through leafTheme
final buttonTheme = context.leafTheme.buttonTheme;
final dialogTheme = context.leafTheme.dialogTheme;
```

### All Tokens in One Widget
```dart
Widget build(BuildContext context) {
  final colors = context.leafColors;
  final typography = context.leafTypography;
  final spacing = context.leafSpacing;
  final radius = context.leafRadius;
  final elevation = context.leafElevation;
  final duration = context.leafDuration;

  return AnimatedContainer(
    duration: duration.normal,
    padding: EdgeInsets.all(spacing.xl),
    decoration: BoxDecoration(
      color: colors.surface,
      borderRadius: BorderRadius.circular(radius.md),
      boxShadow: elevation.shadowMd,
    ),
    child: Text('Card', style: typography.titleMedium),
  );
}
```
