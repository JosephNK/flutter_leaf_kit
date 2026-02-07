# LeafDuration

Animation duration preset token class. Provides four named `Duration` values for consistent animation timing across components. Immutable with `copyWith()` and `lerp()` support.

## API Reference

### Constructor Parameters

All parameters are **required** `Duration` values.

| Parameter | Description |
|-----------|-------------|
| `fast` | Quick micro-interactions (fades, color changes) |
| `normal` | Standard transitions |
| `slow` | Deliberate transitions (page changes, expansion) |
| `verySlow` | Complex multi-step animations |

### Factory Constructors

| Factory | Description |
|---------|-------------|
| `LeafDuration.defaults()` | Default duration presets |

### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith({...})` | `LeafDuration` | Returns a copy with the given fields replaced |
| `LeafDuration.lerp(a, b, t)` | `LeafDuration` | Interpolates between two instances (rounds to nearest ms) |

## Default Presets

| Token | Value |
|-------|-------|
| `fast` | 150 ms |
| `normal` | 250 ms |
| `slow` | 300 ms |
| `verySlow` | 450 ms |

## Usage

### Using Defaults
```dart
final duration = LeafDuration.defaults();
```

### Custom Duration
```dart
final duration = LeafDuration.defaults().copyWith(
  fast: Duration(milliseconds: 100),
  slow: Duration(milliseconds: 400),
);
```

### Accessing via Theme
```dart
final duration = LeafTheme.of(context).duration;
// or
final duration = context.leafDuration;

AnimatedContainer(
  duration: duration.normal,
  color: isActive ? colors.primary : colors.surface,
);

AnimatedOpacity(
  duration: duration.fast,
  opacity: isVisible ? 1.0 : 0.0,
  child: content,
);
```
