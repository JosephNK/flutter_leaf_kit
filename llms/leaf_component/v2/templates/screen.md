# Screen Templates

Base screen widgets that provide a standardized scaffold structure with SafeArea handling, PopScope integration, and keep-alive support via `AutomaticKeepAliveClientMixin`.

## API Reference

### LeafScreenStatefulWidget

An abstract `StatefulWidget` base class that optionally carries a tab index for bottom-tab integration. Subclass this and pair it with `LeafScreenState` to get a full-featured screen scaffold.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `index` | `LeafBottomTabIndex?` | No | `null` | Tab index for bottom-tab integration; when set, `didTabSelected` fires on re-selection |

### LeafScreenState\<T extends LeafScreenStatefulWidget\>

An abstract `State` base class with built-in `Scaffold`, platform-aware `PopScope` handling, and `AutomaticKeepAliveClientMixin`. Uses `Theme.of(context).platform` for web safety (avoids `Platform.isIOS`). Uses `LeafTheme` tokens for theming.

Mixes in `LeafScreenVariable` for overridable scaffold properties and `AutomaticKeepAliveClientMixin` for tab keep-alive.

#### Overridable Getters (from LeafScreenVariable)

| Getter | Type | Default | Description |
|--------|------|---------|-------------|
| `useSafeArea` | `bool` | `true` | Whether to wrap the body in a `SafeArea` |
| `safeAreaInsets` | `SafeAreaInsets` | `SafeAreaInsets.all()` | Which edges of the safe area are enabled |
| `resizeToAvoidBottomInset` | `bool?` | `null` | Controls `Scaffold.resizeToAvoidBottomInset` |
| `extendBodyBehindAppBar` | `bool` | `false` | Whether the body extends behind the app bar |
| `floatingActionButtonLocation` | `FloatingActionButtonLocation?` | `null` | FAB placement in the scaffold |
| `backgroundColor` | `Color?` | `null` | Background color; falls back to `LeafColors.background` |
| `drawerEdgeDragWidth` | `double?` | `null` | Width of the edge drag area for the drawer |
| `canPop` | `bool` | `true` | Whether `PopScope` allows navigation pop |
| `wantKeepAlive` | `bool` | `false` | Whether the widget state is kept alive in a `PageView` or `TabBarView` |

#### Overridable Build Methods (from LeafScreenBuild)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `buildScreen(context)` | `Widget?` | Override to bypass the default scaffold entirely; returns `null` by default |
| `buildAppBar(context, state)` | `PreferredSizeWidget?` | Builds the app bar; returns `null` by default |
| `buildBody(context, state)` | `Widget` | **Required** -- builds the main body content |
| `buildDrawer(context, state)` | `Widget?` | Builds the left drawer; returns `null` by default |
| `buildEndDrawer(context, state)` | `Widget?` | Builds the right drawer; returns `null` by default |
| `buildFloatingActionButton(context, state)` | `Widget?` | Builds the FAB; returns `null` by default |
| `buildBottomNavigationBar(context, state)` | `Widget?` | Builds the bottom navigation bar; returns `null` by default |
| `onDrawerChanged(context, isOpened)` | `void` | Called when the drawer open state changes |
| `onEndDrawerChanged(context, isOpened)` | `void` | Called when the end drawer open state changes |
| `onPopInvokedWithResult(context, didPop, result)` | `void` | Called when a pop is invoked (non-Apple platforms only) |
| `didTabSelected(context, index)` | `void` | Called when the user re-taps the currently selected bottom tab |

#### Key Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `buildScaffold(context, state, {key})` | `Widget` | Builds the full `Scaffold` with SafeArea body and optional `PopScope` on non-Apple platforms |
| `buildWithoutScaffold(context, state, {key})` | `Widget` | Builds the body with SafeArea but without `Scaffold` wrapping |

#### Platform Behavior

- **iOS / macOS**: `PopScope` is not applied (system back gesture is handled natively).
- **Android / others**: `PopScope` wraps the scaffold, controlled by the `canPop` getter.

### LeafScreenStatelessWidget

A minimal stateless screen wrapper. Wraps a child widget unchanged. Useful as a semantic marker for screen-level widgets in routing tables.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `child` | `Widget` | Yes | -- | The content widget to display |

### SafeAreaInsets

An immutable value object describing which edges of the `SafeArea` are enabled. **Not exported** from the barrel file (`index.dart`) to avoid `ambiguous_export` with V1's `SafeAreaInsets`. Import directly when needed.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `left` | `bool` | Yes | -- | Whether the left edge is enabled |
| `top` | `bool` | Yes | -- | Whether the top edge is enabled |
| `right` | `bool` | Yes | -- | Whether the right edge is enabled |
| `bottom` | `bool` | Yes | -- | Whether the bottom edge is enabled |

#### Named Constructors

| Constructor | Description |
|-------------|-------------|
| `SafeAreaInsets.all()` | All edges enabled (default) |
| `SafeAreaInsets.none()` | No edges enabled |
| `SafeAreaInsets.fromLTRB(left, top, right, bottom)` | LTRB convention with positional booleans |
| `SafeAreaInsets.only({left, top, right, bottom})` | Selectively enable edges; unspecified edges default to `false` |

#### Direct Import Path

```dart
import 'package:flutter_leaf_component/src/v2/templates/screen/model/safe_area_insets.dart';
```

## Usage

### Basic Screen

```dart
class HomeScreen extends LeafScreenStatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends LeafScreenState<HomeScreen> {
  @override
  Widget buildBody(BuildContext context, Object? state) {
    return const Center(child: Text('Hello, World!'));
  }
}
```

### Screen with AppBar and Custom SafeArea

```dart
class ProfileScreen extends LeafScreenStatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends LeafScreenState<ProfileScreen> {
  @override
  bool get useSafeArea => true;

  @override
  SafeAreaInsets get safeAreaInsets => const SafeAreaInsets.only(bottom: true);

  @override
  Color? get backgroundColor => Colors.white;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return AppBar(title: const Text('Profile'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return const Text('Profile content');
  }
}
```

### Keep-Alive Screen (for TabBarView / PageView)

```dart
class _KeepAliveScreenState extends LeafScreenState<KeepAliveScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return const Text('This state is preserved when switching tabs');
  }
}
```

### Screen with Bottom Tab Integration

```dart
class TabScreen extends LeafScreenStatefulWidget {
  const TabScreen({super.key, super.index});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends LeafScreenState<TabScreen> {
  @override
  void didTabSelected(BuildContext context, LeafBottomTabIndex index) {
    // Called when user re-taps the already selected tab
    // e.g., scroll to top
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return const Text('Tab content');
  }
}
```

### Stateless Screen Wrapper

```dart
// Useful as a semantic marker in routing tables
LeafScreenStatelessWidget(
  child: Center(child: Text('Simple screen')),
);
```

### Custom PopScope Handling

```dart
class _FormScreenState extends LeafScreenState<FormScreen> {
  @override
  bool get canPop => false; // Prevent back navigation

  @override
  void onPopInvokedWithResult(
    BuildContext context,
    bool didPop,
    dynamic result,
  ) {
    if (!didPop) {
      // Show discard confirmation dialog
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Discard changes?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Discard'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return const Text('Form content');
  }
}
```
