# LeafElevation

Shadow depth scale token class for layered UI. Provides both numeric elevation values (`double`) and pre-configured `BoxShadow` lists. Immutable with `copyWith()` and `lerp()` support.

## API Reference

### Constructor Parameters

All parameters are **required**.

#### Elevation Values
| Parameter | Type | Description |
|-----------|------|-------------|
| `none` | `double` | No elevation |
| `xs` | `double` | Extra small elevation |
| `sm` | `double` | Small elevation |
| `md` | `double` | Medium elevation |
| `lg` | `double` | Large elevation |
| `xl` | `double` | Extra large elevation |

#### Box Shadows
| Parameter | Type | Description |
|-----------|------|-------------|
| `shadowNone` | `List<BoxShadow>` | No shadow (empty list) |
| `shadowSm` | `List<BoxShadow>` | Small shadow (1 layer) |
| `shadowMd` | `List<BoxShadow>` | Medium shadow (2 layers) |
| `shadowLg` | `List<BoxShadow>` | Large shadow (2 layers) |

### Factory Constructors

| Factory | Description |
|---------|-------------|
| `LeafElevation.defaults()` | Default elevation scale with shadow presets |

### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith({...})` | `LeafElevation` | Returns a copy with the given fields replaced |
| `LeafElevation.lerp(a, b, t)` | `LeafElevation` | Linearly interpolates between two instances (shadows use `BoxShadow.lerpList`) |

## Default Scale

### Elevation Values
| Token | Value |
|-------|-------|
| `none` | 0.0 |
| `xs` | 1.0 |
| `sm` | 2.0 |
| `md` | 4.0 |
| `lg` | 8.0 |
| `xl` | 16.0 |

### Shadow Presets
| Token | Layers | Blur Radius | Offset | Color |
|-------|--------|-------------|--------|-------|
| `shadowNone` | 0 | - | - | - |
| `shadowSm` | 1 | 2.0 | (0, 1) | `#1A000000` |
| `shadowMd` | 2 | 5.0 / 2.0 | (0, 2) / (0, 1) | `#1A000000` / `#0D000000` |
| `shadowLg` | 2 | 10.0 / 4.0 | (0, 4) / (0, 2) | `#1A000000` / `#0D000000` |

## Usage

### Using Default Scale
```dart
final elevation = LeafElevation.defaults();
```

### Applying Elevation
```dart
final elevation = context.leafElevation;

// Using numeric value with Material elevation
Material(
  elevation: elevation.md,
  child: content,
);

// Using BoxShadow presets
Container(
  decoration: BoxDecoration(
    boxShadow: elevation.shadowLg,
    borderRadius: BorderRadius.circular(8),
  ),
  child: content,
);
```
