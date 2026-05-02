# Scroll Widgets

A unified set of scroll widgets (`LeafListView`, `LeafGridView`, `LeafAlignedGridView`, `LeafScrollView`) with platform-adaptive behavior, pull-to-refresh, infinite-scroll load-more, and programmatic scroll control. On iOS/macOS, uses Cupertino-style refresh controls; on other platforms, uses Material `RefreshIndicator`.

## API Reference

### LeafScrollController

Unified scroll controller for all Leaf scroll widgets. Provides stream-based commands for programmatic scroll control.

#### Methods

| Method | Parameters | Description |
|--------|-----------|-------------|
| `scrollToTop()` | `animated: false`, `animationDuration: 300ms` | Scroll to the top |
| `scrollToBottom()` | `animated: false`, `animationDuration: 300ms` | Scroll to the bottom |
| `scrollToPosition()` | `animated: false`, `position: double`, `animationDuration: 300ms` | Scroll to a specific position |
| `setLoadingState()` | `value: false` | Set the loading state |
| `dispose()` | - | Release resources |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `isLoading` | `bool` | Current loading state |
| `stream` | `Stream<LeafScrollControllerEvent>` | Event stream for scroll commands |

### LeafScrollInfoData

Immutable snapshot of scroll state passed to `onDidScroll` callbacks.

| Property | Type | Description |
|----------|------|-------------|
| `scrollNotification` | `ScrollNotification` | The raw scroll notification |
| `position` | `double` | Current scroll position |
| `maxScrollExtent` | `double` | Maximum scroll extent |
| `direction` | `ScrollDirection` | Current scroll direction |
| `isEdgeTop` | `bool` | Whether scrolled to the top edge |
| `isAppearTop` | `bool` | Whether near the top (within 10px) |

### LeafDisallowGlowBehavior

A `ScrollBehavior` that suppresses the overscroll glow indicator on Android.

### LeafScrollControlMixin

Mixin providing shared scroll control logic for stateful widgets. Handles scroll-to-top/bottom/position, pull-to-refresh, infinite scroll load-more, and scroll direction tracking. Load-more triggers at 95% of max scroll extent.

### Typedefs

| Typedef | Signature | Description |
|---------|-----------|-------------|
| `LeafScrollViewRefresh` | `Future<void> Function()` | Pull-to-refresh callback |
| `LeafScrollViewLoadMore` | `Future<void> Function()` | Infinite-scroll load-more callback |
| `LeafScrollViewDidScroll` | `void Function(LeafScrollInfoData)` | Scroll position callback |

### LeafRefreshStyle

Determines which refresh indicator style to use.

| Value | Description |
|-------|-------------|
| `auto` | Automatically selects based on platform (iOS/macOS → Cupertino, others → Material) |
| `cupertino` | Always uses `CupertinoSliverRefreshControl` |
| `material` | Always uses `RefreshIndicator` |

---

### LeafListView\<T\>

A unified list view with pull-to-refresh and infinite-scroll load-more support.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `builder` | `Widget Function(BuildContext, T, int)` | Yes | - | Item builder function |
| `items` | `List<T>` | Yes | - | List data |
| `separatorBuilder` | `IndexedWidgetBuilder?` | No | `null` | Separator builder inserted between data items only (skips header↔first item and last item↔load-more slot). Index `i` is the separator after `items[i]`. When non-null, uses `ListView.separated` (Material) / `SliverList.separated` (Cupertino). |
| `storageKey` | `Key?` | No | `null` | Page storage key |
| `controller` | `LeafScrollController?` | No | `null` | Programmatic scroll controller |
| `onRefresh` | `LeafScrollViewRefresh?` | No | `null` | Pull-to-refresh callback |
| `onLoadMore` | `LeafScrollViewLoadMore?` | No | `null` | Load-more callback |
| `onDidScroll` | `LeafScrollViewDidScroll?` | No | `null` | Scroll position callback |
| `header` | `Widget?` | No | `null` | Header widget above the list |
| `padding` | `EdgeInsets?` | No | `EdgeInsets.all(0)` | List padding |
| `physics` | `ScrollPhysics?` | No | `null` | Custom scroll physics |
| `keyboardDismissBehavior` | `ScrollViewKeyboardDismissBehavior` | No | `manual` | Keyboard dismiss mode |
| `disallowGlow` | `bool` | No | `false` | Suppress overscroll glow |
| `shrinkWrap` | `bool` | No | `false` | Shrink-wrap the list |
| `scrollable` | `bool` | No | `true` | Whether scrolling is enabled |
| `reverse` | `bool` | No | `false` | Reverse scroll direction |
| `enableTapUnFocus` | `bool` | No | `false` | Unfocus on tap |
| `hasReachedMax` | `bool` | No | `true` | Whether all data has been loaded |
| `refreshIndicatorBuilder` | `RefreshControlIndicatorBuilder?` | No | `null` | Custom Cupertino refresh indicator builder |
| `refreshStyle` | `LeafRefreshStyle` | No | `auto` | Refresh indicator style selection |

---

### LeafGridView\<T\>

A unified grid view with pull-to-refresh and load-more support.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `builder` | `Widget Function(BuildContext, T, int)` | Yes | - | Item builder function |
| `items` | `List<T>` | Yes | - | Grid data |
| `storageKey` | `Key?` | No | `null` | Page storage key |
| `controller` | `LeafScrollController?` | No | `null` | Programmatic scroll controller |
| `onRefresh` | `LeafScrollViewRefresh?` | No | `null` | Pull-to-refresh callback |
| `onLoadMore` | `LeafScrollViewLoadMore?` | No | `null` | Load-more callback |
| `onDidScroll` | `LeafScrollViewDidScroll?` | No | `null` | Scroll position callback |
| `gridDelegate` | `SliverGridDelegate?` | No | `null` | Grid layout delegate |
| `header` | `Widget?` | No | `null` | Header widget above the grid |
| `padding` | `EdgeInsets?` | No | `EdgeInsets.all(0)` | Grid padding |
| `physics` | `ScrollPhysics?` | No | `null` | Custom scroll physics |
| `disallowGlow` | `bool` | No | `false` | Suppress overscroll glow |
| `shrinkWrap` | `bool` | No | `false` | Shrink-wrap the grid |
| `scrollable` | `bool` | No | `true` | Whether scrolling is enabled |
| `reverse` | `bool` | No | `false` | Reverse scroll direction |
| `enableTapUnFocus` | `bool` | No | `false` | Unfocus on tap |
| `hasReachedMax` | `bool` | No | `true` | Whether all data has been loaded |
| `refreshIndicatorBuilder` | `RefreshControlIndicatorBuilder?` | No | `null` | Custom Cupertino refresh indicator builder |
| `refreshStyle` | `LeafRefreshStyle` | No | `auto` | Refresh indicator style selection |

Default grid delegate: `SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 1.5, crossAxisSpacing: 1.5)`

---

### LeafAlignedGridView\<T\>

A unified aligned grid view using `flutter_staggered_grid_view` with pull-to-refresh and load-more support. Items are aligned to fill available space.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `builder` | `Widget Function(BuildContext, T, int)` | Yes | - | Item builder function |
| `items` | `List<T>` | Yes | - | Grid data |
| `gridDelegate` | `SliverGridDelegateWithFixedCrossAxisCount` | Yes | - | Grid layout delegate |
| `storageKey` | `Key?` | No | `null` | Page storage key |
| `controller` | `LeafScrollController?` | No | `null` | Programmatic scroll controller |
| `onRefresh` | `LeafScrollViewRefresh?` | No | `null` | Pull-to-refresh callback |
| `onLoadMore` | `LeafScrollViewLoadMore?` | No | `null` | Load-more callback |
| `onDidScroll` | `LeafScrollViewDidScroll?` | No | `null` | Scroll position callback |
| `header` | `Widget?` | No | `null` | Header widget above the grid |
| `padding` | `EdgeInsets?` | No | `EdgeInsets.all(0)` | Grid padding |
| `physics` | `ScrollPhysics?` | No | `null` | Custom scroll physics |
| `keyboardDismissBehavior` | `ScrollViewKeyboardDismissBehavior` | No | `manual` | Keyboard dismiss mode |
| `disallowGlow` | `bool` | No | `false` | Suppress overscroll glow |
| `shrinkWrap` | `bool` | No | `false` | Shrink-wrap the grid |
| `scrollable` | `bool` | No | `true` | Whether scrolling is enabled |
| `enableTapUnFocus` | `bool` | No | `false` | Unfocus on tap |
| `hasReachedMax` | `bool` | No | `true` | Whether all data has been loaded |
| `refreshIndicatorBuilder` | `RefreshControlIndicatorBuilder?` | No | `null` | Custom Cupertino refresh indicator builder |
| `refreshStyle` | `LeafRefreshStyle` | No | `auto` | Refresh indicator style selection |

---

### LeafScrollView

A unified scroll view wrapper for a single child with pull-to-refresh support.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `child` | `Widget` | Yes | - | Content widget |
| `storageKey` | `Key?` | No | `null` | Page storage key |
| `controller` | `LeafScrollController?` | No | `null` | Programmatic scroll controller |
| `onRefresh` | `LeafScrollViewRefresh?` | No | `null` | Pull-to-refresh callback |
| `onDidScroll` | `LeafScrollViewDidScroll?` | No | `null` | Scroll position callback |
| `dragKeyboardHide` | `bool` | No | `false` | Dismiss keyboard on drag |
| `physics` | `ScrollPhysics?` | No | `null` | Custom scroll physics |
| `padding` | `EdgeInsets?` | No | `null` | Content padding |
| `disallowGlow` | `bool` | No | `false` | Suppress overscroll glow |
| `shrinkWrap` | `bool` | No | `false` | Shrink-wrap the scroll view |
| `scrollable` | `bool` | No | `true` | Whether scrolling is enabled |
| `enableTapUnFocus` | `bool` | No | `false` | Unfocus on tap |
| `reverse` | `bool` | No | `false` | Reverse scroll direction |
| `refreshIndicatorBuilder` | `RefreshControlIndicatorBuilder?` | No | `null` | Custom Cupertino refresh indicator builder |
| `refreshStyle` | `LeafRefreshStyle` | No | `auto` | Refresh indicator style selection |

## Usage

### Basic List View

```dart
LeafListView<String>(
  items: ['Apple', 'Banana', 'Cherry'],
  builder: (context, item, index) {
    return ListTile(title: Text(item));
  },
)
```

### List View with Separators

Provide `separatorBuilder` to insert a widget between data items. Separators
are skipped around the header and the trailing load-more slot, so they appear
only between actual items. The index passed to the builder is the data-item
index — the separator after `items[i]` receives `i`.

```dart
LeafListView<String>(
  items: items,
  builder: (context, item, index) {
    return ListTile(title: Text(item));
  },
  separatorBuilder: (context, index) => const Divider(height: 1),
)
```

### List View with Pull-to-Refresh and Load-More

```dart
LeafListView<Post>(
  items: posts,
  hasReachedMax: hasReachedMax,
  header: Text('Latest Posts', style: TextStyle(fontSize: 24)),
  builder: (context, post, index) {
    return PostCard(post: post);
  },
  onRefresh: () async {
    await fetchPosts(page: 1);
  },
  onLoadMore: () async {
    await fetchPosts(page: currentPage + 1);
  },
  onDidScroll: (scrollData) {
    // track scroll position
  },
)
```

### Grid View

```dart
LeafGridView<Photo>(
  items: photos,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 2,
    crossAxisSpacing: 2,
  ),
  builder: (context, photo, index) {
    return Image.network(photo.thumbnailUrl, fit: BoxFit.cover);
  },
  onRefresh: () async {
    await refreshPhotos();
  },
)
```

### Aligned Grid View

```dart
LeafAlignedGridView<Product>(
  items: products,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
  ),
  hasReachedMax: hasReachedMax,
  builder: (context, product, index) {
    return ProductCard(product: product);
  },
  onRefresh: () async {
    await refreshProducts();
  },
  onLoadMore: () async {
    await loadMoreProducts();
  },
)
```

### Scroll View with Refresh

```dart
LeafScrollView(
  onRefresh: () async {
    await refreshData();
  },
  dragKeyboardHide: true,
  child: Column(
    children: [
      ProfileHeader(),
      PostsList(),
      Footer(),
    ],
  ),
)
```

### Programmatic Scroll Control

```dart
class _MyState extends State<MyWidget> {
  final _scrollController = LeafScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _scrollController.scrollToTop(animated: true),
              child: Text('Top'),
            ),
            ElevatedButton(
              onPressed: () => _scrollController.scrollToBottom(animated: true),
              child: Text('Bottom'),
            ),
            ElevatedButton(
              onPressed: () => _scrollController.scrollToPosition(
                animated: true,
                position: 500.0,
              ),
              child: Text('Position 500'),
            ),
          ],
        ),
        Expanded(
          child: LeafListView<String>(
            controller: _scrollController,
            items: items,
            builder: (context, item, index) {
              return ListTile(title: Text(item));
            },
          ),
        ),
      ],
    );
  }
}
```

### Custom Refresh Style and Indicator

```dart
// Force Cupertino-style refresh on all platforms
LeafListView<String>(
  items: items,
  refreshStyle: LeafRefreshStyle.cupertino,
  onRefresh: () async {
    await refreshData();
  },
  builder: (context, item, index) {
    return ListTile(title: Text(item));
  },
)

// Custom refresh indicator builder (Cupertino only)
LeafListView<String>(
  items: items,
  refreshStyle: LeafRefreshStyle.cupertino,
  refreshIndicatorBuilder: (context, refreshState, pulledExtent, triggerDistance, extent) {
    final progress = (pulledExtent / triggerDistance).clamp(0.0, 1.0);
    return Center(
      child: refreshState == RefreshIndicatorMode.refresh
          ? const CupertinoActivityIndicator(radius: 14)
          : Opacity(
              opacity: progress,
              child: const Icon(CupertinoIcons.arrow_down),
            ),
    );
  },
  onRefresh: () async {
    await refreshData();
  },
  builder: (context, item, index) {
    return ListTile(title: Text(item));
  },
)
```

### Suppress Overscroll Glow

```dart
LeafListView<String>(
  items: items,
  disallowGlow: true,
  builder: (context, item, index) {
    return ListTile(title: Text(item));
  },
)
```
