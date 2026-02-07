# LeafBottomSheet

A themed bottom sheet that shows a list of action items. Automatically adapts to the platform: on iOS/macOS it displays a `CupertinoActionSheet`, and on other platforms it shows a Material `showModalBottomSheet`. Uses the Leaf design token system for consistent styling.

## API Reference

### LeafBottomSheetItem\<T\>

An immutable data model for bottom sheet action items.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `T?` | No | `null` | Unique identifier for the item |
| `title` | `String` | Yes | - | Display text for the item |
| `enabled` | `bool` | No | `true` | Whether the item is interactive |

### LeafBottomSheet

A utility class with a static `show` method. No instantiation needed.

#### LeafBottomSheet.show()

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `items` | `List<LeafBottomSheetItem<T>>` | Yes | - | List of action items |
| `selectedItem` | `LeafBottomSheetItem<T>?` | No | `null` | Currently selected item (highlighted) |
| `activeColor` | `Color?` | No | `null` | Color for the selected item text |
| `inactiveColor` | `Color?` | No | `null` | Color for unselected item text |
| `itemTextStyle` | `TextStyle?` | No | `null` | Base text style for items |
| `cancelText` | `String?` | No | `null` | Cancel button text (iOS only) |
| `onTap` | `ValueChanged<LeafBottomSheetItem<T>>?` | No | `null` | Item tap callback |
| `onClose` | `VoidCallback?` | No | `null` | Sheet dismissed callback (Material only) |

### Style Resolution

1. Widget parameter (e.g., `activeColor`)
2. Component theme (`theme.bottomSheetTheme?.activeColor`)
3. Global token (`colors.primary`, `colors.onSurface`)

Default resolved values:
- `activeColor`: `colors.primary`
- `inactiveColor`: `colors.onSurface`
- `cancelText`: `'Cancel'`
- Base text style: `fontSize: 18.0`, `fontWeight: FontWeight.normal`
- Selected item: `fontWeight: FontWeight.w500` with active color
- Unselected item: `fontWeight: FontWeight.normal` with inactive color

### Platform Behavior

| Platform | Presentation |
|----------|-------------|
| iOS / macOS | `CupertinoActionSheet` with cancel button |
| Android / Others | `showModalBottomSheet` with `ListTile` items |

## Usage

### Basic

```dart
LeafBottomSheet.show<String>(
  context,
  items: [
    LeafBottomSheetItem(key: 'edit', title: 'Edit'),
    LeafBottomSheetItem(key: 'share', title: 'Share'),
    LeafBottomSheetItem(key: 'delete', title: 'Delete'),
  ],
  onTap: (item) {
    switch (item.key) {
      case 'edit':
        // handle edit
        break;
      case 'share':
        // handle share
        break;
      case 'delete':
        // handle delete
        break;
    }
  },
);
```

### With Selected Item

```dart
LeafBottomSheet.show<String>(
  context,
  items: [
    LeafBottomSheetItem(key: 'newest', title: 'Newest First'),
    LeafBottomSheetItem(key: 'oldest', title: 'Oldest First'),
    LeafBottomSheetItem(key: 'popular', title: 'Most Popular'),
  ],
  selectedItem: LeafBottomSheetItem(key: 'newest', title: 'Newest First'),
  onTap: (item) {
    // handle sort order change
  },
);
```

### With Disabled Items

```dart
LeafBottomSheet.show<String>(
  context,
  items: [
    LeafBottomSheetItem(key: 'copy', title: 'Copy'),
    LeafBottomSheetItem(key: 'paste', title: 'Paste', enabled: false),
    LeafBottomSheetItem(key: 'cut', title: 'Cut'),
  ],
  onTap: (item) {
    // handle action
  },
);
```

### With Enum Keys

```dart
enum ActionType { camera, gallery, document }

LeafBottomSheet.show<ActionType>(
  context,
  items: [
    LeafBottomSheetItem(key: ActionType.camera, title: 'Take Photo'),
    LeafBottomSheetItem(key: ActionType.gallery, title: 'Choose from Gallery'),
    LeafBottomSheetItem(key: ActionType.document, title: 'Select Document'),
  ],
  cancelText: 'Dismiss',
  onTap: (item) {
    // item.key is ActionType
  },
  onClose: () {
    // sheet was dismissed
  },
);
```
