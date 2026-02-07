# Image Widgets

A collection of image widgets covering various source types: asset files, network URLs with caching, in-memory bytes, and circular avatars. All image widgets share consistent error handling and placeholder behavior using `LeafSkeleton`.

## API Reference

### LeafAssetImage

Loads images from asset paths or `file://` URIs. Detects the URI scheme to choose between `Image.file` and `Image.asset`.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `uri` | `Uri?` | No | `null` | Asset path or file URI; `null`/empty shows error widget |
| `width` | `double?` | No | `null` | Image width |
| `height` | `double?` | No | `null` | Image height |
| `fit` | `BoxFit` | No | `BoxFit.cover` | How the image fits its bounds |
| `cacheWidth` | `int?` | No | `null` | Decoded cache width (memory optimization) |
| `cacheHeight` | `int?` | No | `null` | Decoded cache height |
| `filterQuality` | `FilterQuality` | No | `FilterQuality.low` | Rendering filter quality |
| `placeholderWidget` | `Widget?` | No | `null` | Custom loading placeholder; defaults to `LeafSkeleton` |
| `errorWidget` | `Widget?` | No | `null` | Custom error widget; defaults to `Icons.broken_image` |

#### Style Resolution
Error icon color: `theme.imageTheme?.errorColor` -> `colors.error`

---

### LeafCacheNetworkImage

A network image widget with disk and memory caching via the `cached_network_image` package.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `url` | `String?` | No | `null` | Network image URL; `null`/empty shows error widget |
| `width` | `double?` | No | `null` | Image width |
| `height` | `double?` | No | `null` | Image height |
| `fit` | `BoxFit` | No | `BoxFit.cover` | How the image fits its bounds |
| `cacheWidth` | `int?` | No | `null` | Memory cache width |
| `cacheHeight` | `int?` | No | `null` | Memory cache height |
| `filterQuality` | `FilterQuality` | No | `FilterQuality.low` | Rendering filter quality |
| `headers` | `Map<String, String>?` | No | `null` | HTTP headers for the request |
| `placeholderWidget` | `Widget?` | No | `null` | Custom loading placeholder; defaults to `LeafSkeleton` |
| `errorWidget` | `Widget?` | No | `null` | Custom error widget; defaults to `Icons.broken_image` |
| `cacheManager` | `BaseCacheManager?` | No | `null` | Custom cache manager instance |

#### Notes
- Fade animations are disabled (`Duration.zero`) for instant display once cached
- Uses `ValueKey(url)` to properly rebuild when the URL changes

---

### LeafCacheImage

A high-level image widget that automatically routes to `LeafCacheNetworkImage` for `http`/`https` URLs or `LeafAssetImage` for asset/file URIs. Optionally wraps with `ClipRRect` for rounded corners.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `uri` | `Uri?` | No | `null` | Image source URI (network URL, asset path, or file URI) |
| `width` | `double?` | No | `null` | Image width |
| `height` | `double?` | No | `null` | Image height |
| `fit` | `BoxFit` | No | `BoxFit.cover` | How the image fits its bounds |
| `cacheWidth` | `int?` | No | `null` | Decoded cache width |
| `cacheHeight` | `int?` | No | `null` | Decoded cache height |
| `filterQuality` | `FilterQuality` | No | `FilterQuality.low` | Rendering filter quality |
| `borderRadius` | `double?` | No | `null` | Corner radius for `ClipRRect` |
| `headers` | `Map<String, String>?` | No | `null` | HTTP headers (network only) |
| `placeholderWidget` | `Widget?` | No | `null` | Custom loading placeholder |
| `errorWidget` | `Widget?` | No | `null` | Custom error widget |
| `cacheManager` | `BaseCacheManager?` | No | `null` | Custom cache manager (network only) |

#### Style Resolution
Border radius: `theme.imageTheme?.borderRadius` -> `0.0`

#### Routing Logic
| URI Scheme | Delegates To |
|-----------|-------------|
| `http`, `https` | `LeafCacheNetworkImage` |
| `file`, asset path, `null` | `LeafAssetImage` |

---

### LeafMemoryImage

Renders an image from in-memory `Uint8List` byte data.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `bytes` | `Uint8List?` | No | `null` | Image byte data; `null`/empty shows error widget |
| `width` | `double?` | No | `null` | Image width |
| `height` | `double?` | No | `null` | Image height |
| `fit` | `BoxFit` | No | `BoxFit.cover` | How the image fits its bounds |
| `cacheWidth` | `int?` | No | `null` | Decoded cache width |
| `cacheHeight` | `int?` | No | `null` | Decoded cache height |
| `filterQuality` | `FilterQuality` | No | `FilterQuality.low` | Rendering filter quality |
| `placeholderWidget` | `Widget?` | No | `null` | Custom loading placeholder |
| `errorWidget` | `Widget?` | No | `null` | Custom error widget |

---

### LeafCircleAvatarImage

A circular avatar image supporting URL, bytes, or asset sources. The image is clipped into a circle using `ClipOval`, with optional border.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `url` | `String?` | No | `null` | Network image URL |
| `bytes` | `Uint8List?` | No | `null` | In-memory image bytes |
| `uri` | `Uri?` | No | `null` | Asset or file URI |
| `size` | `double` | No | `40.0` | Radius of the avatar (diameter = `size * 2`) |
| `borderColor` | `Color?` | No | `null` | Circle border color |
| `borderWidth` | `double` | No | `0.0` | Circle border width; `0` means no border |
| `fit` | `BoxFit` | No | `BoxFit.cover` | How the image fits the circle |
| `cacheWidth` | `int?` | No | `null` | Decoded cache width |
| `cacheHeight` | `int?` | No | `null` | Decoded cache height |
| `filterQuality` | `FilterQuality` | No | `FilterQuality.low` | Rendering filter quality |
| `headers` | `Map<String, String>?` | No | `null` | HTTP headers (network only) |
| `placeholderWidget` | `Widget?` | No | `null` | Custom loading placeholder |
| `errorWidget` | `Widget?` | No | `null` | Custom error widget |
| `cacheManager` | `BaseCacheManager?` | No | `null` | Custom cache manager (network only) |

#### Source Priority
1. `bytes` (if non-null and non-empty) -- uses `LeafMemoryImage`
2. `url` (if non-null and non-empty) -- uses `LeafCacheNetworkImage`
3. `uri` (fallback) -- uses `LeafAssetImage`

#### Style Resolution
Border color: `colors.divider` (default)

## Usage

### Asset Image
```dart
LeafAssetImage(
  uri: Uri.parse('assets/images/banner.png'),
  width: double.infinity,
  height: 200,
  fit: BoxFit.cover,
)
```

### Network Image with Caching
```dart
LeafCacheNetworkImage(
  url: 'https://example.com/photo.jpg',
  width: 300,
  height: 200,
  headers: {'Authorization': 'Bearer token'},
)
```

### Smart Image (Auto-Routes)
```dart
// Network URL
LeafCacheImage(
  uri: Uri.parse('https://example.com/photo.jpg'),
  width: 200,
  height: 200,
  borderRadius: 12,
)

// Asset path
LeafCacheImage(
  uri: Uri.parse('assets/images/logo.png'),
  width: 100,
  height: 100,
)
```

### Memory Image
```dart
LeafMemoryImage(
  bytes: imageBytes,
  width: 150,
  height: 150,
  fit: BoxFit.contain,
)
```

### Circle Avatar from URL
```dart
LeafCircleAvatarImage(
  url: 'https://example.com/avatar.jpg',
  size: 30, // 60x60 diameter
  borderColor: Colors.white,
  borderWidth: 2.0,
)
```

### Circle Avatar from Bytes
```dart
LeafCircleAvatarImage(
  bytes: userPhotoBytes,
  size: 40,
)
```

### Circle Avatar from Asset
```dart
LeafCircleAvatarImage(
  uri: Uri.parse('assets/images/default_avatar.png'),
  size: 24,
)
```

### Custom Error and Placeholder
```dart
LeafCacheImage(
  uri: Uri.parse('https://example.com/maybe-broken.jpg'),
  width: 200,
  height: 200,
  placeholderWidget: Center(child: CircularProgressIndicator()),
  errorWidget: Container(
    color: Colors.grey.shade200,
    child: Icon(Icons.image_not_supported),
  ),
)
```
