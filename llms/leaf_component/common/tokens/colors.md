# LeafColors

Defines the complete color palette for the Leaf design system, providing semantic color tokens for brand identity, surfaces, backgrounds, states, interactive elements, and structural components. Supports both light and dark mode via factory constructors.

## Token Values

### Brand Colors

| Property | Type | Default (Light) | Default (Dark) | Description |
|----------|------|-----------------|----------------|-------------|
| `primary` | `Color` | `0xFF448AFF` | `0xFF82B1FF` | Primary brand color used for key actions and emphasis |
| `onPrimary` | `Color` | `0xFFFFFFFF` | `0xFF002F6C` | Content color displayed on top of the primary color |
| `secondary` | `Color` | `0xFF625B71` | `0xFFCCC2DC` | Secondary brand color for less prominent elements |
| `onSecondary` | `Color` | `0xFFFFFFFF` | `0xFF332D41` | Content color displayed on top of the secondary color |

### Surface Colors

| Property | Type | Default (Light) | Default (Dark) | Description |
|----------|------|-----------------|----------------|-------------|
| `surface` | `Color` | `0xFFFFFFFF` | `0xFF1E1E1E` | Surface color for cards, sheets, and menus |
| `onSurface` | `Color` | `0xFF1C1B1F` | `0xFFE6E1E5` | Content color displayed on surfaces |
| `surfaceVariant` | `Color` | `0xFFF5F5F5` | `0xFF2C2C2C` | Alternative surface color for visual differentiation |
| `onSurfaceVariant` | `Color` | `0xFF757575` | `0xFFCAC4D0` | Content color on surface variants |

### Background Colors

| Property | Type | Default (Light) | Default (Dark) | Description |
|----------|------|-----------------|----------------|-------------|
| `background` | `Color` | `0xFFFFFFFF` | `0xFF121212` | App-wide background color |
| `onBackground` | `Color` | `0xFF1C1B1F` | `0xFFE6E1E5` | Content color displayed on the background |

### State Colors

| Property | Type | Default (Light) | Default (Dark) | Description |
|----------|------|-----------------|----------------|-------------|
| `error` | `Color` | `0xFFE53935` | `0xFFEF9A9A` | Error state color for validation and alerts |
| `onError` | `Color` | `0xFFFFFFFF` | `0xFF601410` | Content color displayed on error surfaces |
| `success` | `Color` | `0xFF43A047` | `0xFFA5D6A7` | Success state color for confirmations |
| `warning` | `Color` | `0xFFFFA726` | `0xFFFFCC80` | Warning state color for cautionary messages |
| `info` | `Color` | `0xFF29B6F6` | `0xFF81D4FA` | Informational state color |

### Interactive Colors

| Property | Type | Default (Light) | Default (Dark) | Description |
|----------|------|-----------------|----------------|-------------|
| `active` | `Color` | `0xFF448AFF` | `0xFF82B1FF` | Color for active/selected interactive elements |
| `inactive` | `Color` | `0xFF9E9E9E` | `0xFF757575` | Color for inactive interactive elements |
| `disabled` | `Color` | `0xFFBDBDBD` | `0xFF616161` | Color for disabled interactive elements |
| `focus` | `Color` | `0xFF448AFF` | `0xFF82B1FF` | Color indicating focused state |
| `hover` | `Color` | `0x14000000` | `0x14FFFFFF` | Color overlay for hover state |

### Structural Colors

| Property | Type | Default (Light) | Default (Dark) | Description |
|----------|------|-----------------|----------------|-------------|
| `divider` | `Color` | `0xFFE0E0E0` | `0xFF424242` | Color for dividers and separators |
| `shadow` | `Color` | `0x40000000` | `0x66000000` | Shadow color for elevation effects |
| `overlay` | `Color` | `0x8A000000` | `0xB3000000` | Overlay color for modals and scrims |
| `shimmerBase` | `Color` | `0xFFE0E0E0` | `0xFF424242` | Base color for shimmer loading effects |
| `shimmerHighlight` | `Color` | `0xFFF5F5F5` | `0xFF616161` | Highlight color for shimmer loading effects |

## Factories

| Factory | Description |
|---------|-------------|
| `LeafColors.light()` | Creates a color palette optimized for light mode |
| `LeafColors.dark()` | Creates a color palette optimized for dark mode |

## Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith(...)` | `LeafColors` | Returns a new instance with selectively overridden properties |
| `lerp(a, b, t)` | `LeafColors` (static) | Linearly interpolates between two `LeafColors` instances |

## Usage

### Access via Theme

```dart
final theme = LeafTheme.of(context);
final colors = theme.colors;

Container(
  color: colors.primary,
  child: Text('Hello', style: TextStyle(color: colors.onPrimary)),
)
```

### Access via Context Extension

```dart
final colors = context.leafColors;

Container(
  color: colors.surface,
  child: Text('Content', style: TextStyle(color: colors.onSurface)),
)
```

### Custom Configuration

```dart
LeafThemeData.light().copyWith(
  colors: LeafColors.light().copyWith(
    primary: Color(0xFF6200EE),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF03DAC6),
  ),
)
```

### Using State Colors

```dart
final colors = context.leafColors;

Icon(
  isError ? Icons.error : Icons.check_circle,
  color: isError ? colors.error : colors.success,
)
```

## Related

- [tokens-typography.md](tokens-typography.md) - Typography tokens
- [theme-data.md](theme-data.md) - Theme data that holds `LeafColors`
- [theme-context.md](theme-context.md) - Context extension for `context.leafColors`
