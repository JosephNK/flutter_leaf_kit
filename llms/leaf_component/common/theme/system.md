# LeafTheme

An `InheritedWidget` that propagates `LeafThemeData` down the widget tree, making design tokens and component themes accessible to all descendant widgets. This is the entry point for providing the Leaf design system theme to your application.

## API Reference

### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | -- | Standard Flutter widget key |
| `data` | `LeafThemeData` | Yes | -- | The theme data to propagate to descendants |
| `child` | `Widget` | Yes | -- | The widget subtree that receives this theme |

### Static Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `of(BuildContext context)` | `LeafThemeData` | Retrieves the nearest `LeafThemeData` from the widget tree. Returns `LeafThemeData.light()` if no `LeafTheme` ancestor is found. |
| `maybeOf(BuildContext context)` | `LeafThemeData?` | Retrieves the nearest `LeafThemeData` from the widget tree, or `null` if no `LeafTheme` ancestor exists. |

### Rebuild Behavior

| Method | Return Type | Description |
|--------|-------------|-------------|
| `updateShouldNotify(LeafTheme oldWidget)` | `bool` | Returns `true` when `data != oldWidget.data`, triggering rebuilds of dependent widgets |

## Usage

### Basic Setup

```dart
LeafTheme(
  data: LeafThemeData.light(),
  child: MaterialApp(
    home: MyHomePage(),
  ),
)
```

### Dark Mode Setup

```dart
LeafTheme(
  data: LeafThemeData.dark(),
  child: MaterialApp(
    home: MyHomePage(),
  ),
)
```

### Dynamic Theme Switching

```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return LeafTheme(
      data: _isDark ? LeafThemeData.dark() : LeafThemeData.light(),
      child: MaterialApp(
        home: MyHomePage(
          onToggleTheme: () => setState(() => _isDark = !_isDark),
        ),
      ),
    );
  }
}
```

### Accessing Theme in Widgets

```dart
// Using the static method (always safe, returns light theme as fallback)
final theme = LeafTheme.of(context);
final colors = theme.colors;
final typography = theme.typography;

// Using maybeOf (returns null if no LeafTheme ancestor)
final theme = LeafTheme.maybeOf(context);
if (theme != null) {
  // Use theme
}
```

### Nested Theme Override

```dart
LeafTheme(
  data: LeafThemeData.light(),
  child: Column(
    children: [
      Text('Light themed'),
      LeafTheme(
        data: LeafThemeData.dark(),
        child: Text('Dark themed section'),
      ),
    ],
  ),
)
```

### Custom Theme with Component Overrides

```dart
LeafTheme(
  data: LeafThemeData.light().copyWith(
    colors: LeafColors.light().copyWith(
      primary: Color(0xFF6200EE),
    ),
    buttonTheme: LeafButtonThemeData(
      backgroundColor: Color(0xFF6200EE),
    ),
  ),
  child: MaterialApp(
    home: MyHomePage(),
  ),
)
```

## Related

- [theme-data.md](theme-data.md) - The `LeafThemeData` class that `LeafTheme` propagates
- [theme-context.md](theme-context.md) - `BuildContext` extensions for convenient theme access
- [tokens-colors.md](tokens-colors.md) - Color tokens available through the theme
- [tokens-typography.md](tokens-typography.md) - Typography tokens available through the theme
