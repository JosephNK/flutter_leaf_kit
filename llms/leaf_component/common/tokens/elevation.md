# LeafElevation

Defines elevation levels and pre-configured box shadows for the Leaf design system. Combines numeric elevation values (for Material `elevation` properties) with `BoxShadow` lists (for `Container` and `DecoratedBox` usage).

## Token Values

### Elevation Levels

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `none` | `double` | `0.0` | No elevation; flat surface |
| `xs` | `double` | `1.0` | Extra small elevation; subtle lift |
| `sm` | `double` | `2.0` | Small elevation; cards at rest |
| `md` | `double` | `4.0` | Medium elevation; raised cards, dropdowns |
| `lg` | `double` | `8.0` | Large elevation; modals, dialogs |
| `xl` | `double` | `16.0` | Extra large elevation; navigation drawers |

### Box Shadows

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `shadowNone` | `List<BoxShadow>` | `[]` | No shadow |
| `shadowSm` | `List<BoxShadow>` | 1 shadow: blur 2.0, offset (0,1) | Small shadow for subtle depth |
| `shadowMd` | `List<BoxShadow>` | 2 shadows: blur 5.0 + blur 2.0 | Medium shadow for cards |
| `shadowLg` | `List<BoxShadow>` | 2 shadows: blur 10.0 + blur 4.0 | Large shadow for floating elements |

### Shadow Details

**shadowSm:**
- `BoxShadow(color: 0x1A000000, blurRadius: 2.0, offset: Offset(0, 1))`

**shadowMd:**
- `BoxShadow(color: 0x1A000000, blurRadius: 5.0, offset: Offset(0, 2))`
- `BoxShadow(color: 0x0D000000, blurRadius: 2.0, offset: Offset(0, 1))`

**shadowLg:**
- `BoxShadow(color: 0x1A000000, blurRadius: 10.0, offset: Offset(0, 4))`
- `BoxShadow(color: 0x0D000000, blurRadius: 4.0, offset: Offset(0, 2))`

## Factories

| Factory | Description |
|---------|-------------|
| `LeafElevation.defaults()` | Creates the default elevation scale and shadow presets |

## Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith(...)` | `LeafElevation` | Returns a new instance with selectively overridden values. Shadow lists are stored as unmodifiable copies. |
| `lerp(a, b, t)` | `LeafElevation` (static) | Linearly interpolates elevation values and shadow lists between two instances |

## Usage

### Access via Theme

```dart
final theme = LeafTheme.of(context);
final elevation = theme.elevation;

Material(
  elevation: elevation.md,
  child: content,
)
```

### Access via Context Extension

```dart
final elevation = context.leafElevation;

Container(
  decoration: BoxDecoration(
    color: context.leafColors.surface,
    borderRadius: BorderRadius.circular(context.leafRadius.md),
    boxShadow: elevation.shadowMd,
  ),
  child: content,
)
```

### Custom Configuration

```dart
LeafThemeData.light().copyWith(
  elevation: LeafElevation.defaults().copyWith(
    md: 6.0,
    shadowMd: [
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 8.0,
        offset: Offset(0, 4),
      ),
    ],
  ),
)
```

### Card Pattern

```dart
final elevation = context.leafElevation;
final radius = context.leafRadius;
final colors = context.leafColors;

Container(
  decoration: BoxDecoration(
    color: colors.surface,
    borderRadius: BorderRadius.circular(radius.lg),
    boxShadow: elevation.shadowSm,
  ),
  padding: EdgeInsets.all(context.leafSpacing.xl),
  child: content,
)
```

## Related

- [tokens-colors.md](tokens-colors.md) - Shadow and overlay colors
- [tokens-radius.md](tokens-radius.md) - Border radius tokens often paired with elevation
- [theme-data.md](theme-data.md) - Theme data that holds `LeafElevation`
- [theme-context.md](theme-context.md) - Context extension for `context.leafElevation`
