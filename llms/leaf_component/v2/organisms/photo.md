# Photo Components

A set of photo album and photo grid components for selecting photos from the device gallery. Uses the `photo_manager` package for accessing device media and includes an LRU cache for thumbnail performance. Consists of `LeafPhotoAlbum` (album selector), `LeafPhotoListView` (photo grid with selection), `LeafImageLruCache` (thumbnail cache), and `LeafPhotoAlbumRequest` (permission mixin).

## API Reference

### LeafImageLruCache

A static LRU (Least Recently Used) image cache for `AssetEntity` thumbnails. Maximum capacity is 500 entries.

#### Static Methods

| Method | Parameters | Return | Description |
|--------|-----------|--------|-------------|
| `getData` | `AssetEntity entity, [int size = 64]` | `Uint8List?` | Get cached thumbnail data |
| `setData` | `AssetEntity entity, int size, Uint8List data` | `void` | Store thumbnail data |
| `clearCache` | - | `void` | Clear all cached entries |
| `length` | - | `int` | Number of cached entries (getter) |

### LeafPhotoAlbumRequest

A mixin that provides photo album asset loading via `photo_manager`. Handles permission requests and opens system settings if permission is denied.

#### Methods

| Method | Parameters | Return | Description |
|--------|-----------|--------|-------------|
| `requestAssetPaths` | `RequestType type` | `Future<List<AssetPathEntity>>` | Load album list with permission handling |

### LeafPhotoAlbum

A photo album selector that displays available albums in a horizontal scroll row with expandable/collapsible toggle.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `type` | `RequestType` | Yes | - | Asset type filter (image, video, etc.) |
| `selectedAssetPath` | `AssetPathEntity?` | No | `null` | Currently selected album |
| `recentAlbumLabel` | `String?` | No | `null` | Custom label for "Recent" album |
| `titleTextStyle` | `TextStyle?` | No | `null` | Album title text style |
| `albumNameStyle` | `TextStyle?` | No | `null` | Album name label style |
| `albumThumbnailSize` | `double` | No | `72.0` | Size of album thumbnail previews |
| `onAlbumSelected` | `ValueChanged<AssetPathEntity>?` | No | `null` | Callback when an album is selected |

### LeafPhotoListView

A paginated photo grid that displays thumbnails from an `AssetPathEntity`. Supports single and multi-selection with a configurable limit. Pages are loaded on demand (50 items per page).

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `assetPath` | `AssetPathEntity?` | Yes | - | Album to display photos from |
| `selectionLimit` | `int` | No | `3` | Maximum number of selectable photos |
| `padding` | `EdgeInsets` | No | `EdgeInsets.zero` | Grid padding |
| `initialSelection` | `List<AssetEntity>` | No | `[]` | Initially selected photos |
| `checkedIcon` | `Widget?` | No | `null` | Custom checked state icon |
| `uncheckedIcon` | `Widget?` | No | `null` | Custom unchecked state icon |
| `selectedBorderColor` | `Color?` | No | `null` | Border color for selected items |
| `crossAxisCount` | `int` | No | `3` | Number of columns in the grid |
| `spacing` | `double` | No | `3.0` | Spacing between grid items |
| `onSelectionChanged` | `LeafPhotoSelectionChanged?` | No | `null` | Selection change callback |
| `onLimitError` | `LeafPhotoLimitError?` | No | `null` | Called when selection limit is exceeded |

#### Typedefs

| Typedef | Signature | Description |
|---------|-----------|-------------|
| `LeafPhotoSelectionChanged` | `void Function(List<AssetEntity> selectedEntities)` | Selection change callback |
| `LeafPhotoLimitError` | `void Function(Exception error, int limit)` | Limit exceeded callback |

### Selection Behavior

- **Single selection** (`selectionLimit: 1`): Tapping a selected photo deselects it. Tapping an unselected photo selects only that photo.
- **Multi selection** (`selectionLimit > 1`): Tapping adds/removes from selection. When limit is reached, `onLimitError` fires.

### Default Appearance

- Checked icon: `Icons.check_box` in `Colors.blueAccent`
- Unchecked icon: `Icons.check_box_outline_blank` in grey
- Selected border: 3px `Colors.blueAccent` border
- Video items show duration in bottom-right corner

## Usage

### Basic Album and Photo Selector

```dart
class _PhotoPickerState extends State<PhotoPicker> {
  AssetPathEntity? _selectedAlbum;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LeafPhotoAlbum(
          type: RequestType.image,
          selectedAssetPath: _selectedAlbum,
          recentAlbumLabel: 'All Photos',
          onAlbumSelected: (album) {
            setState(() => _selectedAlbum = album);
          },
        ),
        Expanded(
          child: LeafPhotoListView(
            assetPath: _selectedAlbum,
            selectionLimit: 5,
            crossAxisCount: 4,
            onSelectionChanged: (selected) {
              // handle selected photos
            },
            onLimitError: (error, limit) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Maximum $limit photos allowed')),
              );
            },
          ),
        ),
      ],
    );
  }
}
```

### Single Selection Mode

```dart
LeafPhotoListView(
  assetPath: album,
  selectionLimit: 1,
  onSelectionChanged: (selected) {
    if (selected.isNotEmpty) {
      // handle single selected photo
      final photo = selected.first;
    }
  },
)
```

### Custom Selection Icons

```dart
LeafPhotoListView(
  assetPath: album,
  selectionLimit: 3,
  checkedIcon: Icon(Icons.check_circle, color: Colors.green),
  uncheckedIcon: Icon(Icons.radio_button_unchecked, color: Colors.white),
  selectedBorderColor: Colors.green,
  onSelectionChanged: (selected) {
    // handle selection
  },
)
```

### Video Albums

```dart
LeafPhotoAlbum(
  type: RequestType.video,
  onAlbumSelected: (album) {
    // load video thumbnails
  },
)
```

### Using the Mixin Directly

```dart
class _MyState extends State<MyWidget> with LeafPhotoAlbumRequest {
  Future<void> _loadAlbums() async {
    final albums = await requestAssetPaths(RequestType.image);
    // use albums
  }
}
```

### Cache Management

```dart
// Clear cache when leaving photo picker
@override
void dispose() {
  LeafImageLruCache.clearCache();
  super.dispose();
}
```
