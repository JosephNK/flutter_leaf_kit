# Extensions

Utility extension methods and helper classes for Color, String, Number, List, Map, Uri, MediaQuery, FocusNode, GlobalKey, and AssetImage.

## API Reference

### LeafExtColor (Class)

Static helper for color conversion.

| Method | Return Type | Description |
|--------|-------------|-------------|
| `LeafExtColor.hexToColor(String hex)` | `Color?` | Converts `#RRGGBB` hex string to `Color` |

### ColorHelper (Extension on Color)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `randomColor()` | `Color` | Returns a random color |

### StringPath (Extension on String)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `extension()` | `String` | File extension (e.g., `'.png'`) using `package:path` |
| `fileName()` | `String` | File name with extension using `package:path` |

### NumberInt (Extension on int)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `formatSize()` | `String` | Human-readable file size (e.g., `'1.50 MB'`) |
| `currency({Locale?, String? name, String? symbol, int? decimalDigits, String? customPattern})` | `String` | Formatted currency string |
| `simpleCurrency({Locale?, String? name, int? decimalDigits})` | `String` | Simplified currency format |
| `currencySymbol({Locale?, String? name, int? decimalDigits})` | `String` | Currency symbol only |

### SafeLookup (Extension on List\<E\>)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `getSafe(int index)` | `E?` | Returns element at index, or `null` if out of range |

### IterableExt (Extension on Iterable\<T\>)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `joinSeparator(T separator)` | `Iterable<T>` | Inserts separator between each element |

### RemoveMap (Extension on Map\<String, dynamic\>)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `removeNullEmptyValue()` | `void` | Removes entries with `null` values in-place |

### UriExt (Extension on Uri)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `appendPath(String path)` | `Uri` | Appends path segment; returns full URI if path is absolute HTTP |

### UriPath (Extension on Uri)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `extension()` | `String` | File extension from URI path |
| `fileName()` | `String` | File name from URI path |

### MediaQueryDataHelper (Extension on MediaQueryData)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `isVisibleKeyboard(BuildContext context)` | `bool` | Whether the soft keyboard is visible |

### LeafExtFocusNode (Class)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `LeafExtFocusNode.removeFocus(BuildContext context)` | `void` | Removes focus from current node (dismiss keyboard) |

### FocusNodeHelper (Extension on FocusNode)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `ensureVisibleRequestFocus({double alignment, Duration duration, Curve curve, ScrollPositionAlignmentPolicy alignmentPolicy})` | `Future<void>` | Requests focus and scrolls the node into view |

### GlobalKeyHelper (Extension on GlobalKey)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `ensureVisibleScroll({Duration delayDuration, Duration scrollDuration})` | `void` | Scrolls the widget into view after a delay |

### AssetImageHelper (Extension on AssetImage)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `getAsyncSize()` | `Future<Map<String, dynamic>>` | Resolves image and returns `{asset, width, height}` |

### ListAssetImageHelper (Extension on List\<AssetImage\>)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `getAsyncSizes()` | `Future<List<Map<String, dynamic>>>` | Resolves all images in parallel and returns sizes |

## Usage

### Color Conversion

```dart
final color = LeafExtColor.hexToColor('#448AFF');
```

### File Size Formatting

```dart
final size = 1536000.formatSize(); // '1.46 MB'
```

### Currency Formatting

```dart
final price = 15000.currency(
  locale: Locale('ko', 'KR'),
  symbol: '',
  decimalDigits: 0,
); // '15,000'
```

### Safe List Access

```dart
final items = ['a', 'b', 'c'];
items.getSafe(5); // null (no RangeError)
```

### Join with Separator

```dart
final widgets = [Text('A'), Text('B'), Text('C')];
final spaced = widgets.joinSeparator(SizedBox(width: 8));
```

### Remove Null Map Values

```dart
final params = <String, dynamic>{'name': 'Joe', 'age': null};
params.removeNullEmptyValue(); // {'name': 'Joe'}
```

### URI Path Manipulation

```dart
final base = Uri.parse('https://api.example.com');
final full = base.appendPath('/users/123');
```

### Dismiss Keyboard

```dart
LeafExtFocusNode.removeFocus(context);
```

### Scroll to Widget

```dart
final key = GlobalKey();
key.ensureVisibleScroll(delayDuration: Duration(milliseconds: 300));
```
