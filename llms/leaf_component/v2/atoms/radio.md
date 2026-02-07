# LeafRadio / LeafRadioGroup

A themed radio button widget with customizable icons and optional label text. `LeafRadio` is a single toggle, while `LeafRadioGroup` manages single-select state across a list of `LeafDataItem` entries.

## API Reference

### LeafRadio

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `leading` | `Widget?` | No | `null` | Widget displayed before the text label |
| `activeIcon` | `Widget?` | No | `null` | Custom selected icon; defaults to `Icons.radio_button_checked` |
| `inactiveIcon` | `Widget?` | No | `null` | Custom unselected icon; defaults to `Icons.radio_button_off` |
| `value` | `bool` | No | `false` | Current selected state |
| `text` | `String?` | No | `null` | Label text |
| `textStyle` | `TextStyle?` | No | `null` | Label text style |
| `align` | `LeafRadioAlign` | No | `LeafRadioAlign.left` | Icon position relative to label (`left` or `right`) |
| `mainAxisAlignment` | `MainAxisAlignment` | No | `MainAxisAlignment.start` | Row alignment |
| `activeColor` | `Color?` | No | `null` | Selected icon color |
| `inactiveColor` | `Color?` | No | `null` | Unselected icon color |
| `onChanged` | `ValueChanged<bool>?` | No | `null` | Callback with the new selected state |

#### Style Resolution
1. Widget parameter (e.g., `activeColor`)
2. Component theme (`theme.radioTheme?.activeColor`)
3. Global token (`colors.primary`)

| Property | Theme Key | Default |
|----------|-----------|---------|
| `activeColor` | `radioTheme?.activeColor` | `colors.primary` |
| `inactiveColor` | `radioTheme?.inactiveColor` | `colors.inactive` |

### LeafRadioAlign (Enum)

| Value | Description |
|-------|-------------|
| `left` | Icon on the left, label on the right |
| `right` | Label on the left, icon on the right |

---

### LeafRadioGroup

A single-select group of `LeafRadio` widgets driven by a list of `LeafDataItem`. Selecting one item automatically deselects any previously selected item.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `items` | `List<LeafDataItem>` | Yes | - | All available options |
| `value` | `LeafDataItem?` | No | `null` | Initially selected item |
| `direction` | `Axis` | No | `Axis.vertical` | Layout direction (`Wrap` direction) |
| `align` | `LeafRadioAlign` | No | `LeafRadioAlign.left` | Icon alignment for all radios |
| `mainAxisAlignment` | `MainAxisAlignment` | No | `MainAxisAlignment.start` | Row alignment for each radio |
| `runSpacing` | `double` | No | `0.0` | Vertical spacing between items |
| `onChanged` | `LeafRadioGroupOnChanged?` | No | `null` | Callback: `void Function(LeafDataItem item, bool checked)` |

### Selection Behavior
- Selection is based on `LeafDataItem.id` equality
- Tapping the currently selected item deselects it (`checked: false`)
- Tapping a different item selects it and deselects the previous one

## Usage

### Single Radio
```dart
LeafRadio(
  text: 'Option A',
  value: isSelected,
  onChanged: (selected) => setState(() => isSelected = selected),
)
```

### Radio with Custom Icons
```dart
LeafRadio(
  activeIcon: Icon(Icons.check_circle, color: Colors.green),
  inactiveIcon: Icon(Icons.circle_outlined, color: Colors.grey),
  text: 'Custom radio',
  value: isSelected,
  onChanged: (selected) {},
)
```

### Radio Group
```dart
final items = [
  LeafDataItem(id: 'male', text: 'Male'),
  LeafDataItem(id: 'female', text: 'Female'),
  LeafDataItem(id: 'other', text: 'Other'),
];

LeafRadioGroup(
  items: items,
  value: selectedGender,
  direction: Axis.vertical,
  runSpacing: 8.0,
  onChanged: (item, checked) {
    setState(() => selectedGender = checked ? item : null);
  },
)
```

### Horizontal Radio Group
```dart
LeafRadioGroup(
  items: items,
  value: selectedItem,
  direction: Axis.horizontal,
  onChanged: (item, checked) {
    setState(() => selectedItem = checked ? item : null);
  },
)
```
