# LeafSpacing

Defines a consistent spacing scale for the Leaf design system. Provides seven spacing values from extra-small to triple extra-large, used for padding, margins, and gaps throughout the UI.

## Token Values

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `xs` | `double` | `2.0` | Extra small spacing; tight gaps between inline elements |
| `sm` | `double` | `4.0` | Small spacing; compact padding, icon gaps |
| `md` | `double` | `8.0` | Medium spacing; standard inner padding |
| `lg` | `double` | `12.0` | Large spacing; content section gaps |
| `xl` | `double` | `16.0` | Extra large spacing; standard outer padding |
| `xxl` | `double` | `24.0` | Double extra large spacing; section dividers |
| `xxxl` | `double` | `32.0` | Triple extra large spacing; page-level separation |

## Factories

| Factory | Description |
|---------|-------------|
| `LeafSpacing.defaults()` | Creates the default spacing scale (2, 4, 8, 12, 16, 24, 32) |

## Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith(...)` | `LeafSpacing` | Returns a new instance with selectively overridden values |
| `lerp(a, b, t)` | `LeafSpacing` (static) | Linearly interpolates between two `LeafSpacing` instances |

## Usage

### Access via Theme

```dart
final theme = LeafTheme.of(context);
final spacing = theme.spacing;

Padding(
  padding: EdgeInsets.all(spacing.xl),
  child: Text('Padded content'),
)
```

### Access via Context Extension

```dart
final spacing = context.leafSpacing;

Column(
  children: [
    Text('First'),
    SizedBox(height: spacing.md),
    Text('Second'),
    SizedBox(height: spacing.lg),
    Text('Third'),
  ],
)
```

### Custom Configuration

```dart
LeafThemeData.light().copyWith(
  spacing: LeafSpacing.defaults().copyWith(
    md: 10.0,
    xl: 20.0,
  ),
)
```

### Common Patterns

```dart
final spacing = context.leafSpacing;

// Symmetric padding
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: spacing.xl,
    vertical: spacing.md,
  ),
  child: content,
)

// Card-style margins
Container(
  margin: EdgeInsets.all(spacing.lg),
  padding: EdgeInsets.all(spacing.xl),
  child: content,
)
```

## Related

- [tokens-radius.md](tokens-radius.md) - Border radius tokens
- [tokens-elevation.md](tokens-elevation.md) - Elevation tokens
- [theme-data.md](theme-data.md) - Theme data that holds `LeafSpacing`
- [theme-context.md](theme-context.md) - Context extension for `context.leafSpacing`
