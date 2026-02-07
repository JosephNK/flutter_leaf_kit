# LeafCheckBox / LeafCheckBoxGroup

A themed checkbox widget with customizable icons and optional label text. `LeafCheckBox` is a single toggle, while `LeafCheckBoxGroup` manages multi-select state across a list of `LeafDataItem` entries.

## API Reference

### LeafCheckBox

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `leading` | `Widget?` | No | `null` | Widget displayed before the text label |
| `activeIcon` | `Widget?` | No | `null` | Custom checked icon; defaults to `Icons.check_box` |
| `inactiveIcon` | `Widget?` | No | `null` | Custom unchecked icon; defaults to `Icons.check_box_outline_blank` |
| `value` | `bool` | No | `false` | Current checked state |
| `text` | `String?` | No | `null` | Label text |
| `textStyle` | `TextStyle?` | No | `null` | Label text style |
| `runSpacing` | `double?` | No | `null` | Gap between icon and text |
| `align` | `LeafCheckBoxAlign` | No | `LeafCheckBoxAlign.left` | Icon position relative to label (`left` or `right`) |
| `mainAxisAlignment` | `MainAxisAlignment` | No | `MainAxisAlignment.start` | Row alignment |
| `activeColor` | `Color?` | No | `null` | Checked icon color |
| `inactiveColor` | `Color?` | No | `null` | Unchecked icon color |
| `onChanged` | `ValueChanged<bool>?` | No | `null` | Callback with the new checked state |

#### Style Resolution
1. Widget parameter (e.g., `activeColor`)
2. Component theme (`theme.checkBoxTheme?.activeColor`)
3. Global token (`colors.primary`)

| Property | Theme Key | Default |
|----------|-----------|---------|
| `activeColor` | `checkBoxTheme?.activeColor` | `colors.primary` |
| `inactiveColor` | `checkBoxTheme?.inactiveColor` | `colors.inactive` |
| `runSpacing` | `checkBoxTheme?.runSpacing` | `4.0` |

### LeafCheckBoxAlign (Enum)

| Value | Description |
|-------|-------------|
| `left` | Icon on the left, label on the right |
| `right` | Label on the left, icon on the right |

---

### LeafCheckBoxGroup

A multi-select group of `LeafCheckBox` widgets driven by a list of `LeafDataItem`.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `items` | `List<LeafDataItem>` | Yes | - | All available options |
| `values` | `List<LeafDataItem>?` | No | `null` | Initially selected items |
| `direction` | `Axis` | No | `Axis.vertical` | Layout direction (`Wrap` direction) |
| `align` | `LeafCheckBoxAlign` | No | `LeafCheckBoxAlign.left` | Icon alignment for all checkboxes |
| `mainAxisAlignment` | `MainAxisAlignment` | No | `MainAxisAlignment.start` | Row alignment for each checkbox |
| `runSpacing` | `double` | No | `0.0` | Vertical spacing between items |
| `onChanged` | `LeafCheckBoxGroupOnChanged?` | No | `null` | Callback: `void Function(List<LeafDataItem> items, LeafDataItem changedItem)` |

### LeafDataItem

Used for item identity in group widgets.

| Field | Type | Description |
|-------|------|-------------|
| `id` | `dynamic` | Unique identifier |
| `text` | `String` | Display label |
| `option` | `dynamic?` | Optional extra data |
| `color` | `LeafDataColorItem?` | Per-item color |
| `leading` | `Widget?` | Leading widget |

## Usage

### Single CheckBox
```dart
LeafCheckBox(
  text: 'Accept terms',
  value: isAccepted,
  onChanged: (checked) => setState(() => isAccepted = checked),
)
```

### CheckBox with Custom Icons
```dart
LeafCheckBox(
  activeIcon: Icon(Icons.check_circle, color: Colors.green),
  inactiveIcon: Icon(Icons.circle_outlined, color: Colors.grey),
  text: 'Option A',
  value: isSelected,
  onChanged: (checked) => setState(() => isSelected = checked),
)
```

### Right-Aligned CheckBox
```dart
LeafCheckBox(
  text: 'Right-aligned',
  align: LeafCheckBoxAlign.right,
  value: isChecked,
  onChanged: (checked) {},
)
```

### CheckBox Group
```dart
final items = [
  LeafDataItem(id: 1, text: 'Apple'),
  LeafDataItem(id: 2, text: 'Banana'),
  LeafDataItem(id: 3, text: 'Cherry'),
];

LeafCheckBoxGroup(
  items: items,
  values: selectedItems,
  direction: Axis.vertical,
  runSpacing: 8.0,
  onChanged: (allSelected, changedItem) {
    setState(() => selectedItems = allSelected);
  },
)
```
