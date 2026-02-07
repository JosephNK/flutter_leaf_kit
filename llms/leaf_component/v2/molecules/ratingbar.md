# LeafRatingBar

A themed star-rating bar widget that wraps `flutter_rating_bar` with the Leaf 3-level cascade theming system. Supports full, half, and empty star states with customizable colors and sizing.

## API Reference

### LeafRatingBar

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `itemCount` | `int` | Yes | - | Total number of rating items (stars) |
| `onRatingUpdate` | `ValueChanged<double>` | Yes | - | Callback when the rating value changes |
| `ratingWidget` | `RatingWidget?` | No | `null` | Custom widget set for full/half/empty states |
| `initialRating` | `double` | No | `0.0` | Initial rating value |
| `minRating` | `double` | No | `0.0` | Minimum allowed rating |
| `itemPadding` | `EdgeInsets?` | No | `null` | Padding around each rating item |
| `itemSize` | `double?` | No | `null` | Size of each rating item |
| `tapOnlyMode` | `bool` | No | `false` | Only allow tap gestures (no drag) |
| `updateOnDrag` | `bool` | No | `false` | Update rating while dragging |
| `ignoreGestures` | `bool` | No | `false` | Disable all gestures (read-only mode) |
| `allowHalfRating` | `bool` | No | `true` | Allow half-star ratings |
| `ratedColor` | `Color?` | No | `null` | Color for filled/rated stars |
| `unratedColor` | `Color?` | No | `null` | Color for empty/unrated stars |

### Style Resolution

1. Widget parameter (e.g., `ratedColor`)
2. Component theme (`theme.ratingBarTheme?.ratedColor`)
3. Global token (`colors.warning` for rated, `colors.inactive` for unrated)

Default resolved values:
- `ratedColor`: `colors.warning`
- `unratedColor`: `colors.inactive`
- `itemSize`: `40.0`
- `itemPadding`: horizontal spacing from `ratingTheme?.spacing ?? 0.0`

## Usage

### Basic

```dart
LeafRatingBar(
  itemCount: 5,
  initialRating: 3.0,
  onRatingUpdate: (rating) {
    // handle rating change
  },
)
```

### Read-Only Display

```dart
LeafRatingBar(
  itemCount: 5,
  initialRating: 4.5,
  ignoreGestures: true,
  onRatingUpdate: (_) {},
)
```

### Custom Appearance

```dart
LeafRatingBar(
  itemCount: 5,
  initialRating: 2.0,
  itemSize: 30.0,
  allowHalfRating: false,
  ratedColor: Colors.amber,
  unratedColor: Colors.grey.shade300,
  onRatingUpdate: (rating) {
    // handle rating
  },
)
```

### Custom Rating Widgets

```dart
LeafRatingBar(
  itemCount: 5,
  initialRating: 3.5,
  ratingWidget: RatingWidget(
    full: Icon(Icons.favorite, color: Colors.red),
    half: Icon(Icons.favorite, color: Colors.red.shade200),
    empty: Icon(Icons.favorite_border, color: Colors.grey),
  ),
  onRatingUpdate: (rating) {
    // handle rating
  },
)
```
