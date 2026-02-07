# LeafChip / LeafChips

A themed chip widget with toggle state. `LeafChip` is a single toggleable chip, while `LeafChips` manages selection state across a list of `LeafDataItem` entries with single-select or multi-select modes.

## API Reference

### LeafChip

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `text` | `String` | Yes | - | Chip label text |
| `selected` | `bool` | No | `false` | Initial selected state |
| `defaultColor` | `Color?` | No | `null` | Color when unselected (text and background at 40% alpha) |
| `selectedColor` | `Color?` | No | `null` | Color when selected (text at full alpha, background at 50% alpha) |
| `padding` | `EdgeInsets?` | No | `null` | Internal padding |
| `borderRadius` | `double?` | No | `null` | Corner radius |
| `onPressed` | `ValueChanged<bool>?` | No | `null` | Callback with the new selection state |

#### Style Resolution
1. Widget parameter (e.g., `defaultColor`)
2. Component theme (`theme.chipTheme?.defaultColor`)
3. Global token (`colors.onSurface`)

| Property | Theme Key | Default |
|----------|-----------|---------|
| `defaultColor` | `chipTheme?.defaultColor` | `colors.onSurface` |
| `selectedColor` | `chipTheme?.selectedColor` | `colors.primary` |
| `padding` | `chipTheme?.padding` | `EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0)` |
| `borderRadius` | `chipTheme?.borderRadius` | `50.0` |

#### Color Behavior
| State | Background | Text Color |
|-------|-----------|------------|
| Unselected | `defaultColor` at 40% alpha | `defaultColor` at full alpha |
| Selected | `selectedColor` at 50% alpha | `selectedColor` at full alpha |

---

### LeafChips

A group of `LeafChip` widgets with single or multi-select support, driven by `LeafDataItem` list.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `items` | `List<LeafDataItem>` | Yes | - | All available chip options |
| `values` | `List<LeafDataItem>?` | No | `null` | Initially selected items |
| `direction` | `Axis` | No | `Axis.horizontal` | Layout direction of the `Wrap` |
| `multiple` | `bool` | No | `true` | Multi-select (`true`) or single-select (`false`) |
| `onChanged` | `LeafChipsOnChanged?` | No | `null` | Callback: `void Function(List<LeafDataItem> items, LeafDataItem changedItem)` |

#### Layout
Uses `Wrap` with `spacing: 10.0` and `runSpacing: 6.0`.

#### Per-Item Colors
Each `LeafDataItem` can have a `LeafDataColorItem` with `normal` and `selected` colors, which are passed to the individual `LeafChip` as `defaultColor` and `selectedColor`.

## Usage

### Single Chip
```dart
LeafChip(
  text: 'Flutter',
  selected: isSelected,
  onPressed: (selected) => setState(() => isSelected = selected),
)
```

### Styled Chip
```dart
LeafChip(
  text: 'Tag',
  selected: true,
  selectedColor: Colors.blue,
  defaultColor: Colors.grey,
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  borderRadius: 8.0,
  onPressed: (selected) {},
)
```

### Multi-Select Chips
```dart
final items = [
  LeafDataItem(id: 1, text: 'Dart'),
  LeafDataItem(id: 2, text: 'Flutter'),
  LeafDataItem(id: 3, text: 'Swift'),
];

LeafChips(
  items: items,
  values: selectedTags,
  multiple: true,
  onChanged: (allSelected, changedItem) {
    setState(() => selectedTags = allSelected);
  },
)
```

### Single-Select Chips
```dart
LeafChips(
  items: items,
  values: selectedCategory != null ? [selectedCategory!] : [],
  multiple: false,
  onChanged: (selected, changedItem) {
    setState(() => selectedCategory = selected.isNotEmpty ? selected.first : null);
  },
)
```

### Chips with Per-Item Colors
```dart
final items = [
  LeafDataItem(
    id: 1,
    text: 'High',
    color: LeafDataColorItem(normal: Colors.red.shade200, selected: Colors.red),
  ),
  LeafDataItem(
    id: 2,
    text: 'Low',
    color: LeafDataColorItem(normal: Colors.green.shade200, selected: Colors.green),
  ),
];

LeafChips(items: items, multiple: false, onChanged: (_, _) {})
```
