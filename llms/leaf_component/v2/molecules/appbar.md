# LeafAppBar

A themed AppBar widget system that resolves all styles from the Leaf design token system. Includes companion widgets for title, back button, and action buttons. Implements `PreferredSizeWidget` for use with `Scaffold.appBar`.

**Important**: `LeafAppBar.title` takes a `Widget`, not a `String`. Use `LeafAppBarTitle` to create a text-based title.

## API Reference

### LeafAppBar

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `title` | `Widget?` | No | `null` | Title widget (use `LeafAppBarTitle` for text) |
| `titleSpacing` | `double?` | No | `null` | Spacing around the title |
| `leading` | `Widget?` | No | `null` | Leading widget (replaces auto back button) |
| `leadingWidth` | `double?` | No | `null` | Width of the leading area |
| `actions` | `List<Widget>?` | No | `null` | Action widgets on the right side |
| `backgroundColor` | `Color?` | No | `null` | AppBar background color |
| `backButtonColor` | `Color?` | No | `null` | Back button icon color |
| `bottomBorderColor` | `Color?` | No | `null` | Color of the bottom border line |
| `centerTitle` | `bool?` | No | `null` | Center the title (auto-detected per platform) |
| `automaticallyImplyLeading` | `bool` | No | `true` | Auto-show back button when route can pop |
| `shadowColor` | `Color?` | No | `Colors.transparent` | Shadow color |
| `bottom` | `PreferredSizeWidget?` | No | `null` | Widget below the AppBar (e.g., TabBar) |
| `actionsRightMargin` | `double?` | No | `null` | Right margin for actions area |
| `toolbarHeight` | `double?` | No | `null` | Custom toolbar height |
| `flexibleSpace` | `Widget?` | No | `null` | Flexible space widget |
| `elevation` | `double?` | No | `null` | Elevation shadow depth |
| `scrolledUnderElevation` | `double?` | No | `null` | Elevation when scrolled under |
| `primary` | `bool` | No | `true` | Whether this is the primary AppBar |
| `systemOverlayStyle` | `SystemUiOverlayStyle?` | No | `null` | Status bar style |
| `forceMaterialTransparency` | `bool` | No | `false` | Force transparent material |
| `excludeHeaderSemantics` | `bool` | No | `false` | Exclude from semantics |
| `toolbarOpacity` | `double` | No | `1.0` | Toolbar opacity |
| `bottomOpacity` | `double` | No | `1.0` | Bottom widget opacity |
| `onBackPressed` | `VoidCallback?` | No | `null` | Custom back button handler |

#### Constants

| Constant | Value | Description |
|----------|-------|-------------|
| `kLeafToolbarHeight` | `52.0` | Default toolbar height |

### LeafAppBarTitle

Title widget for `LeafAppBar`. Supports text, leading icon, and image modes.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `text` | `String?` | No | `null` | Title text |
| `leading` | `Widget?` | No | `null` | Widget before the title text |
| `image` | `Image?` | No | `null` | Image to display instead of text |
| `textColor` | `Color?` | No | `null` | Title text color |
| `textHeight` | `double?` | No | `null` | Line height for the title text |
| `textStyle` | `TextStyle?` | No | `null` | Custom text style |

### LeafAppBarBack

Back button widget for `LeafAppBar`. Resolves icon color from the theme.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `icon` | `IconData?` | No | `Icons.arrow_back_ios_new` | Back button icon |
| `color` | `Color?` | No | `null` | Icon color |
| `size` | `double?` | No | `null` | Icon size |
| `onPressed` | `VoidCallback?` | No | `null` | Tap callback |

### LeafAppBarAction

Action button widget for `LeafAppBar`. Displays either text or an icon.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `text` | `String?` | No | `null` | Action text label |
| `icon` | `Widget?` | No | `null` | Action icon widget |
| `textStyle` | `TextStyle?` | No | `null` | Text style for text label |
| `padding` | `EdgeInsets` | No | `EdgeInsets.all(8.0)` | Padding around the action |
| `margin` | `EdgeInsets?` | No | `null` | Margin around the action |
| `onPressed` | `VoidCallback?` | No | `null` | Tap callback |

### Style Resolution

1. Widget parameter (e.g., `backgroundColor`)
2. Component theme (`theme.appBarTheme?.backgroundColor`)
3. Global token (`colors.surface`, `colors.onSurface`)

Default resolved values:
- `backgroundColor`: `colors.surface`
- `backButtonColor`: `colors.onSurface`
- `toolbarHeight`: `kLeafToolbarHeight` (52.0)
- `centerTitle`: auto-detected (true on iOS/macOS, false otherwise)

## Usage

### Basic

```dart
LeafAppBar(
  title: LeafAppBarTitle(text: 'Home'),
)
```

### With Actions

```dart
LeafAppBar(
  title: LeafAppBarTitle(text: 'Settings'),
  actions: [
    LeafAppBarAction(
      icon: Icon(Icons.search),
      onPressed: () {
        // handle search
      },
    ),
    LeafAppBarAction(
      text: 'Save',
      onPressed: () {
        // handle save
      },
    ),
  ],
)
```

### Image Title

```dart
LeafAppBar(
  title: LeafAppBarTitle(
    image: Image.asset('assets/logo.png', height: 30),
  ),
)
```

### Custom Back Button

```dart
LeafAppBar(
  title: LeafAppBarTitle(text: 'Detail'),
  onBackPressed: () {
    // custom back navigation
  },
)
```

### With Bottom TabBar

```dart
LeafAppBar(
  title: LeafAppBarTitle(text: 'Tabs'),
  bottom: LeafTabBar(
    tabs: [
      Tab(text: 'Tab 1'),
      Tab(text: 'Tab 2'),
    ],
  ),
)
```

### Title with Leading Icon

```dart
LeafAppBar(
  title: LeafAppBarTitle(
    text: 'Profile',
    leading: Padding(
      padding: EdgeInsets.only(right: 8),
      child: Icon(Icons.person),
    ),
  ),
)
```
