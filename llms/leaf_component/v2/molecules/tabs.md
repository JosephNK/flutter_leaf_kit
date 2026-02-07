# LeafTabBar & LeafTabView

A themed tab bar and tab view system that resolves colors and styles from the Leaf design token system. `LeafTabBar` wraps Flutter's `TabBar` and `LeafTabView` wraps `TabBarView`.

**Important**: Both widgets require a `DefaultTabController` ancestor in the widget tree (or an explicit `TabController`).

## API Reference

### LeafTabBar

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `tabs` | `List<Tab>` | Yes | - | The tab items to display |
| `controller` | `TabController?` | No | `null` | External tab controller |
| `isScrollable` | `bool` | No | `false` | Whether the tab bar scrolls horizontally |
| `labelColor` | `Color?` | No | `null` | Color for the selected tab label |
| `unselectedLabelColor` | `Color?` | No | `null` | Color for unselected tab labels |
| `labelStyle` | `TextStyle?` | No | `null` | Text style for the selected tab |
| `unselectedLabelStyle` | `TextStyle?` | No | `null` | Text style for unselected tabs |
| `indicatorColor` | `Color?` | No | `null` | Color of the selection indicator |
| `dividerColor` | `Color?` | No | `null` | Color of the bottom divider line |
| `indicatorPadding` | `EdgeInsets?` | No | `null` | Padding around the indicator |
| `labelPadding` | `EdgeInsets?` | No | `null` | Padding around each label |
| `overlayColor` | `WidgetStateProperty<Color?>?` | No | `null` | Overlay color on interaction |
| `indicatorSize` | `TabBarIndicatorSize?` | No | `null` | Indicator sizing mode |
| `onTap` | `ValueChanged<int>?` | No | `null` | Callback when a tab is tapped |

### LeafTabView

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `children` | `List<Widget>` | Yes | - | Content widgets for each tab |
| `controller` | `TabController?` | No | `null` | External tab controller |
| `physics` | `ScrollPhysics?` | No | `null` | Swipe scroll physics |

### Style Resolution (LeafTabBar)

1. Widget parameter (e.g., `labelColor`)
2. Component theme (`theme.tabBarTheme?.labelColor`)
3. Global token (`colors.primary`, `colors.inactive`, `colors.divider`)

Default resolved values:
- `labelColor`: `colors.primary`
- `unselectedLabelColor`: `colors.inactive`
- `indicatorColor`: `colors.primary`
- `dividerColor`: `colors.divider`

## Usage

### Basic

```dart
DefaultTabController(
  length: 3,
  child: Column(
    children: [
      LeafTabBar(
        tabs: [
          Tab(text: 'First'),
          Tab(text: 'Second'),
          Tab(text: 'Third'),
        ],
      ),
      Expanded(
        child: LeafTabView(
          children: [
            Center(child: Text('First Tab')),
            Center(child: Text('Second Tab')),
            Center(child: Text('Third Tab')),
          ],
        ),
      ),
    ],
  ),
)
```

### Scrollable Tabs

```dart
DefaultTabController(
  length: 7,
  child: Column(
    children: [
      LeafTabBar(
        isScrollable: true,
        tabs: List.generate(7, (i) => Tab(text: 'Tab ${i + 1}')),
      ),
      Expanded(
        child: LeafTabView(
          children: List.generate(
            7,
            (i) => Center(child: Text('Content ${i + 1}')),
          ),
        ),
      ),
    ],
  ),
)
```

### With AppBar

```dart
Scaffold(
  appBar: LeafAppBar(
    title: LeafAppBarTitle(text: 'Tabbed Page'),
    bottom: LeafTabBar(
      tabs: [
        Tab(text: 'Overview'),
        Tab(text: 'Details'),
      ],
    ),
  ),
  body: DefaultTabController(
    length: 2,
    child: LeafTabView(
      children: [
        OverviewPage(),
        DetailsPage(),
      ],
    ),
  ),
)
```

### With External Controller

```dart
class _MyState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LeafTabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'A'),
            Tab(text: 'B'),
            Tab(text: 'C'),
          ],
          onTap: (index) {
            // handle tab tap
          },
        ),
        Expanded(
          child: LeafTabView(
            controller: _tabController,
            children: [
              PageA(),
              PageB(),
              PageC(),
            ],
          ),
        ),
      ],
    );
  }
}
```

### Custom Styling

```dart
LeafTabBar(
  tabs: [Tab(text: 'Active'), Tab(text: 'Inactive')],
  labelColor: Colors.blue,
  unselectedLabelColor: Colors.grey,
  indicatorColor: Colors.blue,
  dividerColor: Colors.transparent,
  indicatorSize: TabBarIndicatorSize.label,
)
```
