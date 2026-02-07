# LeafColors

Semantic color token class for the Leaf design system. Provides named color slots organized by purpose: brand, surface, background, state, interactive, and specific UI elements. Immutable with `copyWith()` and `lerp()` support for animated theme transitions.

## API Reference

### Constructor Parameters

All parameters are **required** `Color` values.

#### Brand
| Parameter | Description |
|-----------|-------------|
| `primary` | Main brand color |
| `onPrimary` | Content color on primary |
| `secondary` | Secondary brand color |
| `onSecondary` | Content color on secondary |

#### Surface
| Parameter | Description |
|-----------|-------------|
| `surface` | Card, AppBar, sheet surfaces |
| `onSurface` | Content color on surface |
| `surfaceVariant` | Alternative surface (e.g., hover background) |
| `onSurfaceVariant` | Content color on surface variant |

#### Background
| Parameter | Description |
|-----------|-------------|
| `background` | Page/scaffold background |
| `onBackground` | Content color on background |

#### State
| Parameter | Description |
|-----------|-------------|
| `error` | Error state color |
| `onError` | Content color on error |
| `success` | Success state color |
| `warning` | Warning state color |
| `info` | Informational state color |

#### Interactive
| Parameter | Description |
|-----------|-------------|
| `active` | Active/selected state |
| `inactive` | Inactive/unselected state |
| `disabled` | Disabled state |
| `focus` | Focus ring color |
| `hover` | Hover overlay color |

#### Specific
| Parameter | Description |
|-----------|-------------|
| `divider` | Divider/border line color |
| `shadow` | Shadow color |
| `overlay` | Modal overlay color |
| `shimmerBase` | Skeleton shimmer base color |
| `shimmerHighlight` | Skeleton shimmer highlight color |

### Factory Constructors

| Factory | Description |
|---------|-------------|
| `LeafColors.light()` | Light theme preset (primary: `#448AFF`) |
| `LeafColors.dark()` | Dark theme preset (primary: `#82B1FF`) |

### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith({...})` | `LeafColors` | Returns a copy with the given fields replaced |
| `LeafColors.lerp(a, b, t)` | `LeafColors` | Linearly interpolates between two `LeafColors` instances |

## Light Preset Values

| Token | Hex |
|-------|-----|
| `primary` | `#448AFF` |
| `onPrimary` | `#FFFFFF` |
| `secondary` | `#625B71` |
| `onSecondary` | `#FFFFFF` |
| `surface` | `#FFFFFF` |
| `onSurface` | `#1C1B1F` |
| `surfaceVariant` | `#F5F5F5` |
| `onSurfaceVariant` | `#757575` |
| `background` | `#FFFFFF` |
| `onBackground` | `#1C1B1F` |
| `error` | `#E53935` |
| `success` | `#43A047` |
| `warning` | `#FFA726` |
| `info` | `#29B6F6` |
| `active` | `#448AFF` |
| `inactive` | `#9E9E9E` |
| `disabled` | `#BDBDBD` |
| `divider` | `#E0E0E0` |
| `shadow` | `#40000000` |
| `overlay` | `#8A000000` |
| `shimmerBase` | `#E0E0E0` |
| `shimmerHighlight` | `#F5F5F5` |

## Dark Preset Values

| Token | Hex |
|-------|-----|
| `primary` | `#82B1FF` |
| `onPrimary` | `#002F6C` |
| `secondary` | `#CCC2DC` |
| `onSecondary` | `#332D41` |
| `surface` | `#1E1E1E` |
| `onSurface` | `#E6E1E5` |
| `surfaceVariant` | `#2C2C2C` |
| `onSurfaceVariant` | `#CAC4D0` |
| `background` | `#121212` |
| `onBackground` | `#E6E1E5` |
| `error` | `#EF9A9A` |
| `success` | `#A5D6A7` |
| `warning` | `#FFCC80` |
| `info` | `#81D4FA` |
| `active` | `#82B1FF` |
| `inactive` | `#757575` |
| `disabled` | `#616161` |
| `divider` | `#424242` |
| `shadow` | `#66000000` |
| `overlay` | `#B3000000` |
| `shimmerBase` | `#424242` |
| `shimmerHighlight` | `#616161` |

## Usage

### Using Preset
```dart
final colors = LeafColors.light();
final darkColors = LeafColors.dark();
```

### Custom Colors
```dart
final colors = LeafColors.light().copyWith(
  primary: Color(0xFF6200EE),
  onPrimary: Color(0xFFFFFFFF),
);
```

### Accessing via Theme
```dart
final colors = LeafTheme.of(context).colors;
// or
final colors = context.leafColors;

Container(color: colors.primary);
Text('Hello', style: TextStyle(color: colors.onSurface));
```
