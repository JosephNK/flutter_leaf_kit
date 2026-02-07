# LeafRadius

Border radius token class providing a scale from `none` (0) to `full` (50). Stores raw `double` values to be used with `BorderRadius.circular()`. Immutable with `copyWith()` and `lerp()` support.

## API Reference

### Constructor Parameters

All parameters are **required** `double` values.

| Parameter | Description |
|-----------|-------------|
| `none` | No rounding (sharp corners) |
| `sm` | Small radius |
| `md` | Medium radius |
| `lg` | Large radius |
| `xl` | Extra large radius |
| `xxl` | Double extra large radius |
| `full` | Fully rounded (pill/circle) |

### Factory Constructors

| Factory | Description |
|---------|-------------|
| `LeafRadius.defaults()` | Default radius scale |

### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith({...})` | `LeafRadius` | Returns a copy with the given fields replaced |
| `LeafRadius.lerp(a, b, t)` | `LeafRadius` | Linearly interpolates between two instances |

## Default Scale

| Token | Value (dp) |
|-------|------------|
| `none` | 0.0 |
| `sm` | 4.0 |
| `md` | 8.0 |
| `lg` | 12.0 |
| `xl` | 16.0 |
| `xxl` | 20.0 |
| `full` | 50.0 |

## Usage

### Using Default Scale
```dart
final radius = LeafRadius.defaults();
```

### Custom Radius
```dart
final radius = LeafRadius.defaults().copyWith(
  md: 12.0,
  full: 100.0,
);
```

### Accessing via Theme
```dart
final radius = LeafTheme.of(context).radius;
// or
final radius = context.leafRadius;

Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius.md),
  ),
);

ClipRRect(
  borderRadius: BorderRadius.circular(radius.full),
  child: avatar,
);
```
