# LeafRadius

Defines a consistent border radius scale for the Leaf design system. Provides seven radius values from none (sharp corners) to full (pill/circle shapes), used for rounding corners on containers, buttons, cards, and other UI elements.

## Token Values

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `none` | `double` | `0.0` | No rounding; sharp corners |
| `sm` | `double` | `4.0` | Small radius; subtle rounding for inputs and chips |
| `md` | `double` | `8.0` | Medium radius; standard rounding for cards |
| `lg` | `double` | `12.0` | Large radius; prominent rounding for dialogs |
| `xl` | `double` | `16.0` | Extra large radius; modals and bottom sheets |
| `xxl` | `double` | `20.0` | Double extra large radius; floating action areas |
| `full` | `double` | `50.0` | Full rounding; pill-shaped buttons and avatars |

## Factories

| Factory | Description |
|---------|-------------|
| `LeafRadius.defaults()` | Creates the default radius scale (0, 4, 8, 12, 16, 20, 50) |

## Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith(...)` | `LeafRadius` | Returns a new instance with selectively overridden values |
| `lerp(a, b, t)` | `LeafRadius` (static) | Linearly interpolates between two `LeafRadius` instances |

## Usage

### Access via Theme

```dart
final theme = LeafTheme.of(context);
final radius = theme.radius;

Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius.md),
    color: theme.colors.surface,
  ),
  child: content,
)
```

### Access via Context Extension

```dart
final radius = context.leafRadius;

ClipRRect(
  borderRadius: BorderRadius.circular(radius.lg),
  child: Image.network('https://example.com/image.jpg'),
)
```

### Custom Configuration

```dart
LeafThemeData.light().copyWith(
  radius: LeafRadius.defaults().copyWith(
    md: 12.0,
    lg: 16.0,
    full: 100.0,
  ),
)
```

### Common Patterns

```dart
final radius = context.leafRadius;

// Card with standard rounding
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius.md),
  ),
  child: content,
)

// Pill-shaped button
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius.full),
    color: context.leafColors.primary,
  ),
  child: Text('Action'),
)

// Bottom sheet with top rounding
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(radius.xl),
    ),
  ),
  child: sheetContent,
)
```

## Related

- [tokens-spacing.md](tokens-spacing.md) - Spacing tokens for padding and margins
- [tokens-elevation.md](tokens-elevation.md) - Elevation tokens often paired with radius
- [theme-data.md](theme-data.md) - Theme data that holds `LeafRadius`
- [theme-context.md](theme-context.md) - Context extension for `context.leafRadius`
