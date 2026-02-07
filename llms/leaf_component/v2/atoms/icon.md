# LeafIcons

A universal icon widget that supports multiple asset types including `IconData`, `Icon`, `AssetBytesLoader` (compiled SVG), and `SvgPicture`. Provides a unified API for rendering icons regardless of their source format.

## API Reference

### LeafIcons

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `asset` | `Object` | Yes | - | The icon asset (positional). Accepts `IconData`, `Icon`, `AssetBytesLoader`, or `SvgPicture` |
| `key` | `Key?` | No | `null` | Widget key |
| `color` | `Color?` | No | `null` | Icon tint color; applied as `ColorFilter` for SVG types |
| `width` | `double?` | No | `null` | Icon width; used as `size` for `IconData`/`Icon` types |
| `height` | `double?` | No | `null` | Icon height; only applies to SVG asset types |

#### Static Methods
| Method | Returns | Description |
|--------|---------|-------------|
| `updateColor(LeafIcons icon, {required Color? color})` | `Widget` | Creates a copy of the given icon with an updated color |

### Asset Type Behavior
| Asset Type | Rendering | Color Application |
|------------|-----------|-------------------|
| `IconData` | `Icon` widget | `color` parameter |
| `Icon` | `Icon` widget (extracts `icon` property) | `color` parameter |
| `AssetBytesLoader` | `SvgPicture` | `ColorFilter.mode(color, BlendMode.srcIn)` |
| `SvgPicture` | `SvgPicture` (extracts `bytesLoader`) | `ColorFilter.mode(color, BlendMode.srcIn)` |
| Other | `SizedBox` fallback | N/A |

### Style Resolution
This widget does not use the Leaf theme system. Colors are passed directly as parameters.

## Usage

### IconData
```dart
LeafIcons(Icons.home, color: Colors.blue, width: 24)
```

### SVG Asset (compiled with vector_graphics)
```dart
LeafIcons(
  AssetBytesLoader('assets/icons/logo.svg.vec'),
  color: Colors.red,
  width: 32,
  height: 32,
)
```

### Update Color of Existing Icon
```dart
final icon = LeafIcons(Icons.star, color: Colors.grey, width: 20);
final highlighted = LeafIcons.updateColor(icon, color: Colors.amber);
```
