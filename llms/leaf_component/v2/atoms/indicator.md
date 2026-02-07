# LeafIndicator / LeafPageCircleIndicator / LeafPageRectIndicator

Loading indicator and page position indicator widgets. `LeafIndicator` is a platform-adaptive loading spinner, while `LeafPageCircleIndicator` and `LeafPageRectIndicator` show current page position with animated dots.

## API Reference

### LeafIndicator

A platform-adaptive loading indicator: `CupertinoActivityIndicator` on Apple platforms, `CircularProgressIndicator` on others.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `padding` | `EdgeInsets?` | No | `null` | Outer padding |
| `size` | `LeafIndicatorSize` | No | `LeafIndicatorSize.medium` | Size preset |
| `strokeWidth` | `double?` | No | `null` | Stroke width for Material indicator |

#### LeafIndicatorSize (Enum)

| Value | Material Size | Cupertino Radius |
|-------|--------------|-----------------|
| `small` | 20.0 | 10.0 |
| `medium` | 30.0 | 15.0 |
| `large` | 40.0 | 25.0 |

#### Style Resolution
1. Widget parameter (e.g., `padding`)
2. Component theme (`theme.indicatorTheme?.padding`)
3. Hardcoded default

| Property | Theme Key | Default |
|----------|-----------|---------|
| `padding` | `indicatorTheme?.padding` | `EdgeInsets.zero` |
| `strokeWidth` | `indicatorTheme?.strokeWidth` | `2.0` |

---

### LeafPageCircleIndicator

A circle-dot page indicator with animated transitions. Supports an optional `decrease` style where dots shrink as they get further from the active index.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `total` | `int` | Yes | - | Total number of pages |
| `current` | `double` | Yes | - | Current page position (supports fractional values for smooth scrolling) |
| `margin` | `EdgeInsets` | No | `EdgeInsets.zero` | Outer margin |
| `activeColor` | `Color?` | No | `null` | Active dot color |
| `inactiveColor` | `Color?` | No | `null` | Inactive dot color |
| `size` | `double` | No | `4.0` | Dot diameter |
| `indicatorStyle` | `LeafPageCircleIndicatorStyle` | No | `LeafPageCircleIndicatorStyle.none` | Dot sizing behavior |

#### LeafPageCircleIndicatorStyle (Enum)
| Value | Description |
|-------|-------------|
| `none` | All dots same size |
| `decrease` | Dots shrink progressively further from the active dot |

#### Style Resolution
1. Widget parameter (e.g., `activeColor`)
2. Global token (`colors.primary` / `colors.inactive`)

---

### LeafPageRectIndicator

A rectangle-style page indicator where the active dot expands to a wider rectangle (16.0 width) and inactive dots stay as small squares (4.0 width).

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `total` | `int` | Yes | - | Total number of pages |
| `current` | `double` | Yes | - | Current page position |
| `margin` | `EdgeInsets` | No | `EdgeInsets.zero` | Outer margin |
| `activeColor` | `Color?` | No | `null` | Active indicator color |
| `inactiveColor` | `Color?` | No | `null` | Inactive indicator color |

#### Style Resolution
1. Widget parameter (e.g., `activeColor`)
2. Global token (`colors.primary` / `colors.inactive`)

## Usage

### Loading Indicator
```dart
LeafIndicator()
```

### Large Loading Indicator with Padding
```dart
LeafIndicator(
  size: LeafIndicatorSize.large,
  padding: EdgeInsets.all(16),
  strokeWidth: 3.0,
)
```

### Circle Page Indicator
```dart
LeafPageCircleIndicator(
  total: 5,
  current: currentPage,
  size: 8.0,
  activeColor: Colors.blue,
  inactiveColor: Colors.grey,
)
```

### Circle Indicator with Decreasing Dots
```dart
LeafPageCircleIndicator(
  total: 10,
  current: currentPage,
  size: 10.0,
  indicatorStyle: LeafPageCircleIndicatorStyle.decrease,
)
```

### Rectangle Page Indicator
```dart
LeafPageRectIndicator(
  total: 4,
  current: currentPage,
  margin: EdgeInsets.symmetric(vertical: 12),
  activeColor: Colors.deepPurple,
)
```

### With PageView Integration
```dart
// In a PageView's onPageChanged or using a PageController listener:
PageView(
  controller: pageController,
  children: pages,
);

// Below the PageView:
ValueListenableBuilder<double>(
  valueListenable: pageNotifier,
  builder: (context, page, _) => LeafPageCircleIndicator(
    total: pages.length,
    current: page,
  ),
)
```
