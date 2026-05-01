# LeafDataItem

Shared data model used by selection-based components (CheckBox groups, Radio groups, BottomSheet item lists, etc.). Extends `Equatable` for value-based equality on `id` and `text`.

## API Reference

### LeafDataItem

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `id` | `dynamic` | Yes | - | Unique identifier for the item |
| `text` | `String` | Yes | - | Display text for the item |
| `option` | `dynamic` | No | `null` | Arbitrary extra data attached to the item |
| `color` | `LeafDataColorItem?` | No | `null` | Custom color overrides for normal/selected states |
| `leading` | `Widget?` | No | `null` | Leading widget (e.g., icon) displayed before the text |

#### Equality
Two `LeafDataItem` instances are equal when `id` and `text` match. The `option`, `color`, and `leading` fields are **not** compared.

### LeafDataColorItem

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `normal` | `Color?` | No | `null` | Color in the normal (unselected) state |
| `selected` | `Color?` | No | `null` | Color in the selected state |

#### Equality
Compares both `normal` and `selected` fields.

## Dependencies

- Extends `Equatable` from `flutter_leaf_core` (`leaf_core` package)
- Uses `hash2` from `flutter_leaf_core` for hash code generation
- Declared as `part of` the `model.dart` barrel file

## Usage

### Basic Item List
```dart
final items = [
  LeafDataItem(id: 1, text: 'Option A'),
  LeafDataItem(id: 2, text: 'Option B'),
  LeafDataItem(id: 3, text: 'Option C'),
];
```

### With Custom Colors
```dart
final items = [
  LeafDataItem(
    id: 'critical',
    text: 'Critical',
    color: LeafDataColorItem(
      normal: Colors.red.shade100,
      selected: Colors.red,
    ),
  ),
  LeafDataItem(
    id: 'normal',
    text: 'Normal',
    color: LeafDataColorItem(
      normal: Colors.grey.shade200,
      selected: Colors.blue,
    ),
  ),
];
```

### With Leading Widget
```dart
final items = [
  LeafDataItem(
    id: 'home',
    text: 'Home',
    leading: Icon(Icons.home, size: 20),
  ),
  LeafDataItem(
    id: 'settings',
    text: 'Settings',
    leading: Icon(Icons.settings, size: 20),
  ),
];
```

### With Extra Data
```dart
final items = [
  LeafDataItem(
    id: 1,
    text: 'Seoul',
    option: {'lat': 37.5665, 'lng': 126.9780},
  ),
];

// Access later
final coords = item.option as Map<String, double>;
```

### Used by Components
```dart
// CheckBox group
LeafCheckBoxGroup(
  items: items,
  selectedItems: selectedItems,
  onChanged: (selected) { ... },
);

// Radio group
LeafRadioGroup(
  items: items,
  selectedItem: currentItem,
  onChanged: (item) { ... },
);

// BottomSheet
LeafBottomSheet.show(
  context: context,
  items: items,
  onSelected: (item) { ... },
);
```
