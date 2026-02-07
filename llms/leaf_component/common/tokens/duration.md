# LeafDuration

Defines standardized animation durations for the Leaf design system. Provides four duration tiers from fast micro-interactions to slow page transitions, ensuring consistent motion timing across the entire UI.

## Token Values

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `fast` | `Duration` | `150ms` | Fast animations; button presses, toggles, hover effects |
| `normal` | `Duration` | `250ms` | Normal animations; fades, color transitions, standard interactions |
| `slow` | `Duration` | `300ms` | Slow animations; slide-ins, expand/collapse, page transitions |
| `verySlow` | `Duration` | `450ms` | Very slow animations; complex multi-step transitions, staggered reveals |

## Factories

| Factory | Description |
|---------|-------------|
| `LeafDuration.defaults()` | Creates the default duration scale (150, 250, 300, 450 ms) |

## Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith(...)` | `LeafDuration` | Returns a new instance with selectively overridden values |
| `lerp(a, b, t)` | `LeafDuration` (static) | Linearly interpolates between two `LeafDuration` instances by rounding millisecond values |

## Usage

### Access via Theme

```dart
final theme = LeafTheme.of(context);
final duration = theme.duration;

AnimatedContainer(
  duration: duration.normal,
  color: isSelected ? colors.primary : colors.surface,
  child: content,
)
```

### Access via Context Extension

```dart
final duration = context.leafDuration;

AnimatedOpacity(
  duration: duration.fast,
  opacity: isVisible ? 1.0 : 0.0,
  child: content,
)
```

### Custom Configuration

```dart
LeafThemeData.light().copyWith(
  duration: LeafDuration.defaults().copyWith(
    fast: Duration(milliseconds: 100),
    normal: Duration(milliseconds: 200),
  ),
)
```

### Common Patterns

```dart
final duration = context.leafDuration;

// Fade transition
AnimatedOpacity(
  duration: duration.fast,
  opacity: isVisible ? 1.0 : 0.0,
  child: widget,
)

// Slide-in panel
AnimatedSlide(
  duration: duration.slow,
  offset: isOpen ? Offset.zero : Offset(0, 1),
  child: panel,
)

// Color change on state
AnimatedContainer(
  duration: duration.normal,
  decoration: BoxDecoration(
    color: isActive
        ? context.leafColors.primary
        : context.leafColors.surface,
  ),
  child: content,
)
```

## Related

- [tokens-colors.md](tokens-colors.md) - Color tokens for animated color transitions
- [theme-data.md](theme-data.md) - Theme data that holds `LeafDuration`
- [theme-context.md](theme-context.md) - Context extension for `context.leafDuration`
