# LeafTheme

`InheritedWidget`-based theme propagation for the Leaf design system. Wraps a `LeafThemeData` and makes it available to all descendant widgets via `BuildContext`.

## API Reference

### LeafTheme

#### Constructor Parameters
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `key` | `Key?` | No | Widget key |
| `data` | `LeafThemeData` | Yes | Theme configuration to propagate |
| `child` | `Widget` | Yes | Child widget tree |

#### Static Methods
| Method | Return Type | Description |
|--------|-------------|-------------|
| `LeafTheme.of(context)` | `LeafThemeData` | Returns the nearest `LeafThemeData`. Falls back to `LeafThemeData.light()` if no ancestor `LeafTheme` is found. |
| `LeafTheme.maybeOf(context)` | `LeafThemeData?` | Returns the nearest `LeafThemeData`, or `null` if none exists. |

#### Rebuild Behavior
`updateShouldNotify` returns `true` when `data != oldWidget.data`, triggering rebuilds of dependent widgets when any token or component theme changes.

### LeafThemeDataExtension

A `ThemeExtension<LeafThemeDataExtension>` wrapper that integrates `LeafThemeData` into Flutter's `ThemeData.extensions` system. This allows using the Leaf theme alongside the standard Material theme.

#### Constructor Parameters
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `data` | `LeafThemeData` | Yes | The `LeafThemeData` to embed |

#### Methods
| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith({data})` | `LeafThemeDataExtension` | Returns a copy with optionally replaced data |
| `lerp(other, t)` | `LeafThemeDataExtension` | Interpolates via `LeafThemeData.lerp` for animated theme transitions |

## Usage

### Basic Setup (InheritedWidget)
```dart
LeafTheme(
  data: LeafThemeData.light(),
  child: MaterialApp(
    home: MyHomePage(),
  ),
);
```

### Dark Theme
```dart
LeafTheme(
  data: LeafThemeData.dark(),
  child: MaterialApp(
    home: MyHomePage(),
  ),
);
```

### Accessing the Theme
```dart
// Static method
final theme = LeafTheme.of(context);
final colors = theme.colors;
final typography = theme.typography;

// Null-safe access
final theme = LeafTheme.maybeOf(context);
if (theme != null) {
  // use theme
}
```

### Flutter ThemeData Integration
```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      LeafThemeDataExtension(data: LeafThemeData.light()),
    ],
  ),
  darkTheme: ThemeData.dark().copyWith(
    extensions: [
      LeafThemeDataExtension(data: LeafThemeData.dark()),
    ],
  ),
);
```

### Nested Theme Override
```dart
LeafTheme(
  data: LeafThemeData.light(),
  child: Scaffold(
    body: LeafTheme(
      data: LeafThemeData.light().copyWith(
        colors: LeafColors.light().copyWith(primary: Colors.purple),
      ),
      child: PurpleSection(),
    ),
  ),
);
```

## Source Files

| File | Class |
|------|-------|
| `leaf_theme.dart` | `LeafTheme` (InheritedWidget) |
| `leaf_theme_extension.dart` | `LeafThemeDataExtension` (ThemeExtension) |
