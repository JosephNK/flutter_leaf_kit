# LeafSpacing

Consistent spacing scale token class for margins, paddings, and gaps. Provides seven named `double` values from `xs` (2) to `xxxl` (32). Immutable with `copyWith()` and `lerp()` support.

## API Reference

### Constructor Parameters

All parameters are **required** `double` values.

| Parameter | Description |
|-----------|-------------|
| `xs` | Extra small spacing |
| `sm` | Small spacing |
| `md` | Medium spacing |
| `lg` | Large spacing |
| `xl` | Extra large spacing |
| `xxl` | Double extra large spacing |
| `xxxl` | Triple extra large spacing |

### Factory Constructors

| Factory | Description |
|---------|-------------|
| `LeafSpacing.defaults()` | Default spacing scale |

### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith({...})` | `LeafSpacing` | Returns a copy with the given fields replaced |
| `LeafSpacing.lerp(a, b, t)` | `LeafSpacing` | Linearly interpolates between two instances |

## Default Scale

| Token | Value (dp) |
|-------|------------|
| `xs` | 2.0 |
| `sm` | 4.0 |
| `md` | 8.0 |
| `lg` | 12.0 |
| `xl` | 16.0 |
| `xxl` | 24.0 |
| `xxxl` | 32.0 |

## Usage

### Using Default Scale
```dart
final spacing = LeafSpacing.defaults();
```

### Custom Spacing
```dart
final spacing = LeafSpacing.defaults().copyWith(
  md: 10.0,
  lg: 16.0,
);
```

### Accessing via Theme
```dart
final spacing = LeafTheme.of(context).spacing;
// or
final spacing = context.leafSpacing;

Padding(padding: EdgeInsets.all(spacing.md));
SizedBox(height: spacing.lg);
```
