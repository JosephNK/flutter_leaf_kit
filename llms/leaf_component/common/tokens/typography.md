# LeafTypography

Defines the complete type scale for the Leaf design system, based on Material Design 3 typography roles. Provides 15 text styles organized into five categories: Display, Headline, Title, Body, and Label.

## Token Values

### Display Styles

| Property | Type | fontSize | fontWeight | letterSpacing | height | Description |
|----------|------|----------|------------|---------------|--------|-------------|
| `displayLarge` | `TextStyle` | 57.0 | w400 | -0.25 | 1.12 | Largest display text, for hero sections |
| `displayMedium` | `TextStyle` | 45.0 | w400 | -- | 1.16 | Medium display text |
| `displaySmall` | `TextStyle` | 36.0 | w400 | -- | 1.22 | Small display text |

### Headline Styles

| Property | Type | fontSize | fontWeight | letterSpacing | height | Description |
|----------|------|----------|------------|---------------|--------|-------------|
| `headlineLarge` | `TextStyle` | 32.0 | w400 | -- | 1.25 | Page-level headings |
| `headlineMedium` | `TextStyle` | 28.0 | w400 | -- | 1.29 | Section headings |
| `headlineSmall` | `TextStyle` | 24.0 | w400 | -- | 1.33 | Subsection headings |

### Title Styles

| Property | Type | fontSize | fontWeight | letterSpacing | height | Description |
|----------|------|----------|------------|---------------|--------|-------------|
| `titleLarge` | `TextStyle` | 22.0 | w500 | -- | 1.27 | Large titles, app bars |
| `titleMedium` | `TextStyle` | 16.0 | w500 | 0.15 | 1.50 | Medium titles, card headers |
| `titleSmall` | `TextStyle` | 14.0 | w500 | 0.1 | 1.43 | Small titles, list items |

### Body Styles

| Property | Type | fontSize | fontWeight | letterSpacing | height | Description |
|----------|------|----------|------------|---------------|--------|-------------|
| `bodyLarge` | `TextStyle` | 16.0 | w400 | 0.5 | 1.50 | Primary body text |
| `bodyMedium` | `TextStyle` | 14.0 | w400 | 0.25 | 1.43 | Default body text |
| `bodySmall` | `TextStyle` | 12.0 | w400 | 0.4 | 1.33 | Secondary body text, captions |

### Label Styles

| Property | Type | fontSize | fontWeight | letterSpacing | height | Description |
|----------|------|----------|------------|---------------|--------|-------------|
| `labelLarge` | `TextStyle` | 14.0 | w500 | 0.1 | 1.43 | Button text, prominent labels |
| `labelMedium` | `TextStyle` | 12.0 | w500 | 0.5 | 1.33 | Navigation labels, tags |
| `labelSmall` | `TextStyle` | 11.0 | w500 | 0.5 | 1.45 | Smallest labels, annotations |

## Factories

| Factory | Description |
|---------|-------------|
| `LeafTypography.defaults()` | Creates the default type scale based on Material Design 3 |

## Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith(...)` | `LeafTypography` | Returns a new instance with selectively overridden text styles |
| `lerp(a, b, t)` | `LeafTypography` (static) | Linearly interpolates between two `LeafTypography` instances |

## Usage

### Access via Theme

```dart
final theme = LeafTheme.of(context);
final typography = theme.typography;

Text(
  'Welcome',
  style: typography.headlineMedium,
)
```

### Access via Context Extension

```dart
final typography = context.leafTypography;

Text(
  'Body content goes here.',
  style: typography.bodyMedium,
)
```

### Custom Configuration

```dart
LeafThemeData.light().copyWith(
  typography: LeafTypography.defaults().copyWith(
    displayLarge: TextStyle(
      fontSize: 60.0,
      fontWeight: FontWeight.w700,
      fontFamily: 'CustomFont',
    ),
    bodyMedium: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'CustomFont',
    ),
  ),
)
```

### Combining with Colors

```dart
final colors = context.leafColors;
final typography = context.leafTypography;

Text(
  'Error occurred',
  style: typography.bodyMedium.copyWith(color: colors.error),
)
```

## Related

- [tokens-colors.md](tokens-colors.md) - Color tokens for text colors
- [theme-data.md](theme-data.md) - Theme data that holds `LeafTypography`
- [theme-context.md](theme-context.md) - Context extension for `context.leafTypography`
