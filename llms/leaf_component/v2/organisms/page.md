# LeafPageView

A page view widget with built-in page indicators and optional auto-page rotation. Supports fade transitions between auto-paged slides and custom indicator builders. Uses `ExpandablePageView` for dynamic height and the Leaf design token system for indicator colors.

**Note**: When using `autoPage: true` in tests, set `autoPage: false` to avoid timer-related test flakiness.

## API Reference

### LeafPageView

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `children` | `List<Widget>` | Yes | - | Page content widgets |
| `initialPage` | `int` | No | `0` | Initially displayed page index |
| `autoPage` | `bool` | No | `false` | Enable automatic page rotation |
| `showIndicator` | `bool` | No | `true` | Show page indicator dots |
| `padding` | `EdgeInsets` | No | `EdgeInsets.zero` | Container padding |
| `margin` | `EdgeInsets` | No | `EdgeInsets.zero` | Container margin |
| `autoPageDuration` | `Duration?` | No | `null` | Duration between auto page transitions |
| `fadeTransitionDuration` | `Duration?` | No | `null` | Duration of fade transition animation |
| `indicatorActiveColor` | `Color?` | No | `null` | Color for the active page indicator |
| `indicatorInactiveColor` | `Color?` | No | `null` | Color for inactive page indicators |
| `indicatorBuilder` | `Widget Function(int total, double current)?` | No | `null` | Custom indicator builder |
| `onPageChanged` | `ValueChanged<double>?` | No | `null` | Callback with current page position |

### Style Resolution

1. Widget parameter (e.g., `indicatorActiveColor`)
2. Component theme (`theme.pageViewTheme?.indicatorActiveColor`)
3. Global token (`colors.primary`, `colors.inactive`)

Default resolved values:
- `indicatorActiveColor`: `colors.primary`
- `indicatorInactiveColor`: `colors.inactive`
- `autoPageDuration`: `Duration(seconds: 3)`
- `fadeTransitionDuration`: `Duration(milliseconds: 300)`

### Auto-Page Behavior

When `autoPage` is enabled:
1. After `autoPageDuration` elapses, the current page fades out
2. After `fadeTransitionDuration`, the next page is displayed
3. The new page fades in over `fadeTransitionDuration`
4. The timer restarts for the next transition
5. After the last page, it loops back to the first page

## Usage

### Basic

```dart
LeafPageView(
  children: [
    Container(color: Colors.red, child: Center(child: Text('Page 1'))),
    Container(color: Colors.green, child: Center(child: Text('Page 2'))),
    Container(color: Colors.blue, child: Center(child: Text('Page 3'))),
  ],
)
```

### Auto-Page Carousel

```dart
LeafPageView(
  autoPage: true,
  autoPageDuration: Duration(seconds: 5),
  fadeTransitionDuration: Duration(milliseconds: 500),
  children: [
    Image.asset('assets/banner1.png', fit: BoxFit.cover),
    Image.asset('assets/banner2.png', fit: BoxFit.cover),
    Image.asset('assets/banner3.png', fit: BoxFit.cover),
  ],
)
```

### With Page Change Callback

```dart
LeafPageView(
  children: [
    PageOne(),
    PageTwo(),
    PageThree(),
  ],
  onPageChanged: (page) {
    // page is a double (e.g., 0.0, 0.5, 1.0 during transition)
  },
)
```

### Custom Indicator

```dart
LeafPageView(
  indicatorBuilder: (total, current) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final isActive = index == current.round();
        return Container(
          width: isActive ? 20 : 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  },
  children: [
    Page1(),
    Page2(),
    Page3(),
  ],
)
```

### Without Indicator

```dart
LeafPageView(
  showIndicator: false,
  children: [
    OnboardingStep1(),
    OnboardingStep2(),
    OnboardingStep3(),
  ],
  onPageChanged: (page) {
    // track progress externally
  },
)
```

### With Custom Colors

```dart
LeafPageView(
  indicatorActiveColor: Colors.amber,
  indicatorInactiveColor: Colors.grey.shade300,
  padding: EdgeInsets.all(16),
  children: [
    CardWidget1(),
    CardWidget2(),
    CardWidget3(),
  ],
)
```
