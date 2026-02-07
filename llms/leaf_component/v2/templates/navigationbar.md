# NavigationBar Template

Bottom tab bar navigation system consisting of a scaffold, tab bar, tab views, a unified controller, and supporting models. Provides an all-in-one bottom navigation layout with badge support, tab selection control, and state preservation via `IndexedStack`.

## API Reference

### LeafBottomTabBarScaffold

A scaffold that combines `LeafBottomTabBar` and `LeafBottomTabViews` into an all-in-one bottom tab bar navigation layout. On first build it initializes the controller with the provided tab items and selected index.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `controller` | `LeafBottomTabBarController` | Yes | -- | The controller managing tab selection and items |
| `tabItems` | `List<LeafBottomTabItem>` | Yes | -- | List of tab item configurations |
| `viewBuilder` | `LeafBottomTabViewsBuilder` | Yes | -- | Builder that creates child views from the current tab items |
| `selectedIndex` | `int` | No | `0` | Initially selected tab index |
| `deactivateIndexes` | `List<int>` | No | `const []` | Tab indexes that are disabled and cannot be selected |
| `appBar` | `PreferredSizeWidget?` | No | `null` | Optional app bar above the tab content |
| `backgroundColor` | `Color?` | No | `null` | Tab bar background color |
| `selectedColor` | `Color?` | No | `null` | Color for the selected tab icon and label |
| `unselectedColor` | `Color?` | No | `null` | Color for unselected tab icons and labels |
| `borderRadius` | `BorderRadius?` | No | `null` | Border radius for the tab bar container |
| `boxShadow` | `List<BoxShadow>?` | No | `null` | Shadow decoration for the tab bar container |
| `shape` | `NotchedShape?` | No | `null` | Notched shape for the `BottomAppBar` (e.g. for FAB notch) |
| `clipBehavior` | `Clip` | No | `Clip.none` | Clip behavior for the `BottomAppBar` |
| `padding` | `EdgeInsetsGeometry?` | No | `null` | Internal padding of the `BottomAppBar` |
| `height` | `double?` | No | `null` | Height of the `BottomAppBar` |
| `elevation` | `double?` | No | `null` | Elevation of the `BottomAppBar` |
| `notchMargin` | `double` | No | `4.0` | Margin around the notch shape |
| `showTabBar` | `bool` | No | `true` | Whether the bottom tab bar is visible |
| `onSelect` | `LeafBottomTabBarOnSelect?` | No | `null` | Async callback that determines whether a tab selection should be accepted |

### LeafBottomTabBar

A themed bottom navigation tab bar. Renders a horizontal row of tab items inside a `BottomAppBar`. Each item shows an icon, an optional label, and an optional badge.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `controller` | `LeafBottomTabBarController` | Yes | -- | The controller managing tab selection and items |
| `backgroundColor` | `Color?` | No | `null` | Tab bar background color |
| `selectedColor` | `Color?` | No | `null` | Color for the selected tab |
| `unselectedColor` | `Color?` | No | `null` | Color for unselected tabs |
| `borderRadius` | `BorderRadius?` | No | `null` | Border radius for the tab bar |
| `boxShadow` | `List<BoxShadow>?` | No | `null` | Shadow decoration |
| `shape` | `NotchedShape?` | No | `null` | Notched shape for `BottomAppBar` |
| `clipBehavior` | `Clip` | No | `Clip.none` | Clip behavior |
| `padding` | `EdgeInsetsGeometry?` | No | `null` | Internal padding |
| `height` | `double?` | No | `null` | Tab bar height |
| `elevation` | `double?` | No | `null` | Tab bar elevation |
| `notchMargin` | `double` | No | `4.0` | Margin around the notch |
| `visible` | `bool` | No | `true` | Whether the tab bar is visible |
| `onTap` | `LeafBottomTabBarOnTap?` | No | `null` | Callback fired when a tab item is tapped |
| `onSelect` | `LeafBottomTabBarOnSelect?` | No | `null` | Async callback to accept or reject tab selection |

#### Style Resolution Order

1. Explicit widget parameters
2. `LeafNavigationBarThemeData` from the nearest `LeafTheme`
3. Global tokens (`LeafColors`)

### LeafBottomTabViews

Displays the content view for the currently selected tab. Uses `IndexedStack` to preserve each tab's state while only showing the currently selected one.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `controller` | `LeafBottomTabBarController` | Yes | -- | The controller managing tab selection |
| `builder` | `LeafBottomTabViewsBuilder` | Yes | -- | Builder that creates child views from the current tab items |

### LeafBottomTabBarController

A unified `ChangeNotifier` controller for the bottom tab bar navigation system. Manages tab selection, tab items, and badge updates.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `initialIndex` | `int` | No | `0` | The initially selected tab index |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `selectedIndex` | `int` | The currently selected tab index (getter and setter) |
| `previousIndex` | `int` | The previously selected tab index (read-only) |
| `tabItems` | `List<LeafBottomTabItem>` | The current list of tab items with selection states (read-only) |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `setItems(items, {selectedIndex})` | `void` | Initializes or replaces all tab items and sets the active index |
| `updateBadge({tabIndex, badgeCount})` | `void` | Updates the badge count for the tab at the given index |

### LeafBottomTabItem

Model representing a single bottom navigation tab. Holds the visual configuration (icons, label) and selection state for one tab in `LeafBottomTabBar`.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `tabIndex` | `LeafBottomTabIndex` | Yes | -- | The index state of this tab |
| `defaultIcon` | `Widget?` | Yes | -- | The icon displayed when the tab is not selected |
| `activeIcon` | `Widget?` | No | `null` | The icon displayed when the tab is selected; falls back to `defaultIcon` |
| `label` | `String?` | No | `null` | Text label displayed below the icon |
| `defaultLabelStyle` | `TextStyle?` | No | `null` | Text style for the label in unselected state |
| `activeLabelStyle` | `TextStyle?` | No | `null` | Text style for the label in selected state |
| `badgeCount` | `int` | No | `0` | Badge count to display; shown only when greater than 0 |
| `badgeAlignment` | `Alignment?` | No | `null` | Badge position relative to the icon; defaults to `Alignment(1.0, -1.4)` |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith(...)` | `LeafBottomTabItem` | Creates a copy with the given fields replaced |

### LeafBottomTabIndex

Represents the index state of a single bottom tab item.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `tabIndex` | `int` | Yes | -- | The positional index of this tab |
| `activeTabIndex` | `int` | No | `0` | The currently active tab index across all tabs |
| `isSelected` | `bool` | No | `false` | Whether this tab is currently selected |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith(...)` | `LeafBottomTabIndex` | Creates a copy with the given fields replaced |

### Type Aliases

```dart
/// Builder that creates child views from the current tab items.
typedef LeafBottomTabViewsBuilder = List<Widget> Function(
  List<LeafBottomTabItem> tabItems,
);

/// Callback fired when a tab item is tapped.
typedef LeafBottomTabBarOnTap = void Function(
  int selectedIndex,
  bool isAlreadyActive,
);

/// Callback that determines whether a tab selection should be accepted.
typedef LeafBottomTabBarOnSelect = Future<bool> Function(
  int selectedIndex,
  int? previousIndex,
  bool isAlreadyActive,
);
```

## Usage

### Basic Bottom Tab Navigation

```dart
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controller = LeafBottomTabBarController();

  final _tabItems = [
    LeafBottomTabItem(
      tabIndex: const LeafBottomTabIndex(tabIndex: 0),
      defaultIcon: const Icon(Icons.home_outlined),
      activeIcon: const Icon(Icons.home),
      label: 'Home',
    ),
    LeafBottomTabItem(
      tabIndex: const LeafBottomTabIndex(tabIndex: 1),
      defaultIcon: const Icon(Icons.search_outlined),
      activeIcon: const Icon(Icons.search),
      label: 'Search',
    ),
    LeafBottomTabItem(
      tabIndex: const LeafBottomTabIndex(tabIndex: 2),
      defaultIcon: const Icon(Icons.person_outlined),
      activeIcon: const Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LeafBottomTabBarScaffold(
      controller: _controller,
      tabItems: _tabItems,
      viewBuilder: (tabItems) => [
        const HomeView(),
        const SearchView(),
        const ProfileView(),
      ],
    );
  }
}
```

### With Badge Updates

```dart
// Update badge count on a specific tab
_controller.updateBadge(tabIndex: 1, badgeCount: 5);

// Clear badge
_controller.updateBadge(tabIndex: 1, badgeCount: 0);
```

### With Selection Control (Guard Navigation)

```dart
LeafBottomTabBarScaffold(
  controller: _controller,
  tabItems: _tabItems,
  deactivateIndexes: const [2], // Disable tab at index 2
  onSelect: (selectedIndex, previousIndex, isAlreadyActive) async {
    if (selectedIndex == 1 && !isLoggedIn) {
      // Show login dialog, return false to prevent tab switch
      await showLoginDialog(context);
      return false;
    }
    return true; // Allow tab switch
  },
  viewBuilder: (tabItems) => [
    const HomeView(),
    const SearchView(),
    const ProfileView(),
  ],
);
```

### Programmatic Tab Switching

```dart
// Switch to tab 2
_controller.selectedIndex = 2;

// Read previous tab index
final previous = _controller.previousIndex;
```

### Custom Styled Tab Bar

```dart
LeafBottomTabBarScaffold(
  controller: _controller,
  tabItems: _tabItems,
  selectedColor: Colors.blue,
  unselectedColor: Colors.grey,
  backgroundColor: Colors.white,
  elevation: 8.0,
  height: 60.0,
  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 8,
      offset: const Offset(0, -2),
    ),
  ],
  viewBuilder: (tabItems) => [
    const HomeView(),
    const SearchView(),
  ],
);
```

### Using Components Separately

```dart
// Use LeafBottomTabBar and LeafBottomTabViews independently
Scaffold(
  body: LeafBottomTabViews(
    controller: _controller,
    builder: (tabItems) => [
      const HomeView(),
      const SearchView(),
    ],
  ),
  bottomNavigationBar: LeafBottomTabBar(
    controller: _controller,
    selectedColor: Colors.blue,
    onTap: (index, isAlreadyActive) {
      if (isAlreadyActive) {
        // Scroll to top or refresh
      }
    },
  ),
);
```

### Tab Items with Custom Badge Alignment

```dart
LeafBottomTabItem(
  tabIndex: const LeafBottomTabIndex(tabIndex: 0),
  defaultIcon: const Icon(Icons.notifications_outlined),
  activeIcon: const Icon(Icons.notifications),
  label: 'Alerts',
  badgeCount: 3,
  badgeAlignment: const Alignment(0.8, -1.2),
  activeLabelStyle: const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
  ),
);
```
