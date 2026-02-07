# LeafSkeleton

A themed shimmer/skeleton loading placeholder widget that uses the `shimmer` package to create an animated loading effect. Commonly used as a placeholder while content is loading.

## API Reference

### LeafSkeleton

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `width` | `double?` | No | `null` | Width of the placeholder rectangle |
| `height` | `double?` | No | `null` | Height of the placeholder rectangle |
| `radius` | `double?` | No | `null` | Corner radius of the placeholder |
| `baseColor` | `Color?` | No | `null` | Base shimmer color (the "darker" shade) |
| `highlightColor` | `Color?` | No | `null` | Highlight shimmer color (the "lighter" sweep) |
| `baseOpacity` | `double?` | No | `null` | Opacity for the base color |
| `highlightOpacity` | `double?` | No | `null` | Opacity for the highlight color |
| `child` | `Widget?` | No | `null` | Custom child widget; replaces the default rectangle |

### Style Resolution
1. Widget parameter (e.g., `baseColor`)
2. Component theme (`theme.skeletonTheme?.baseColor`)
3. Global token (`colors.shimmerBase`)

| Property | Theme Key | Default |
|----------|-----------|---------|
| `baseColor` | `skeletonTheme?.baseColor` | `colors.shimmerBase` |
| `highlightColor` | `skeletonTheme?.highlightColor` | `colors.shimmerHighlight` |
| `baseOpacity` | `skeletonTheme?.baseOpacity` | `0.3` |
| `highlightOpacity` | `skeletonTheme?.highlightOpacity` | `0.1` |
| `radius` | `skeletonTheme?.radius` | `0.0` |

### Default Child
When `child` is `null`, renders a white `Container` with the specified `width`, `height`, and `borderRadius`.

## Usage

### Basic Rectangle Skeleton
```dart
LeafSkeleton(width: 200, height: 20)
```

### Rounded Skeleton
```dart
LeafSkeleton(
  width: 100,
  height: 100,
  radius: 50, // circle
)
```

### Text Line Skeleton
```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    LeafSkeleton(width: 250, height: 16, radius: 4),
    SizedBox(height: 8),
    LeafSkeleton(width: 180, height: 16, radius: 4),
    SizedBox(height: 8),
    LeafSkeleton(width: 220, height: 16, radius: 4),
  ],
)
```

### Card Skeleton with Custom Child
```dart
LeafSkeleton(
  child: Container(
    width: double.infinity,
    height: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
  ),
)
```

### Custom Shimmer Colors
```dart
LeafSkeleton(
  width: 150,
  height: 150,
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  baseOpacity: 0.5,
  highlightOpacity: 0.2,
  radius: 8,
)
```
