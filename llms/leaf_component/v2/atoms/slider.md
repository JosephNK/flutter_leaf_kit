# LeafSlider / LeafRangeSlider

Themed slider widgets that wrap Flutter's `Slider` and `RangeSlider` with three-level cascade theming and automatic label display.

## API Reference

### LeafSlider

A single-value slider with auto-generated label from the current integer value.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `value` | `double` | Yes | - | Current slider value |
| `min` | `double` | No | `0` | Minimum value |
| `max` | `double` | No | `1` | Maximum value |
| `label` | `String?` | No | `null` | Custom label; when `null`, auto-generates from integer value |
| `divisions` | `int?` | No | `null` | Number of discrete divisions |
| `activeColor` | `Color?` | No | `null` | Active track color |
| `inactiveColor` | `Color?` | No | `null` | Inactive track color |
| `thumbColor` | `Color?` | No | `null` | Thumb color |
| `onChanged` | `ValueChanged<double>?` | No | `null` | Callback with the new value |

#### Style Resolution
1. Widget parameter (e.g., `activeColor`)
2. Component theme (`theme.sliderTheme?.activeTrackColor`)
3. Global token (`colors.primary`)

| Property | Theme Key | Default |
|----------|-----------|---------|
| `activeColor` | `sliderTheme?.activeTrackColor` | `colors.primary` |
| `inactiveColor` | `sliderTheme?.inactiveTrackColor` | `colors.inactive` |
| `thumbColor` | `sliderTheme?.thumbColor` | `colors.primary` |

---

### LeafRangeSlider

A range slider with two thumbs and auto-generated labels from the current integer values.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `values` | `RangeValues` | Yes | - | Current range (start, end) |
| `min` | `double` | No | `0` | Minimum value |
| `max` | `double` | No | `1` | Maximum value |
| `labels` | `RangeLabels?` | No | `null` | Custom labels; when `null`, auto-generates from integer values |
| `divisions` | `int?` | No | `null` | Number of discrete divisions |
| `activeColor` | `Color?` | No | `null` | Active track color |
| `inactiveColor` | `Color?` | No | `null` | Inactive track color |
| `onChanged` | `ValueChanged<RangeValues>?` | No | `null` | Callback with the new range values |

#### Style Resolution
1. Widget parameter (e.g., `activeColor`)
2. Component theme (`theme.sliderTheme?.activeTrackColor`)
3. Global token (`colors.primary`)

| Property | Theme Key | Default |
|----------|-----------|---------|
| `activeColor` | `sliderTheme?.activeTrackColor` | `colors.primary` |
| `inactiveColor` | `sliderTheme?.inactiveTrackColor` | `colors.inactive` |

## Usage

### Basic Slider
```dart
LeafSlider(
  value: volume,
  min: 0,
  max: 100,
  onChanged: (value) => setState(() => volume = value),
)
```

### Slider with Divisions and Custom Label
```dart
LeafSlider(
  value: temperature,
  min: 16,
  max: 30,
  divisions: 14,
  label: '${temperature.toInt()}\u00B0C',
  activeColor: Colors.orange,
  onChanged: (value) => setState(() => temperature = value),
)
```

### Range Slider
```dart
LeafRangeSlider(
  values: priceRange,
  min: 0,
  max: 1000,
  divisions: 20,
  onChanged: (values) => setState(() => priceRange = values),
)
```

### Range Slider with Custom Labels
```dart
LeafRangeSlider(
  values: ageRange,
  min: 18,
  max: 65,
  divisions: 47,
  labels: RangeLabels(
    '${ageRange.start.toInt()} yrs',
    '${ageRange.end.toInt()} yrs',
  ),
  activeColor: Colors.teal,
  onChanged: (values) => setState(() => ageRange = values),
)
```
