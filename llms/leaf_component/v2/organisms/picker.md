# LeafDatePicker & LeafTimePicker

Themed inline picker card widgets with expandable calendar/time wheel. Each displays a compact card showing the selected value, and tapping it expands to reveal an inline picker. `LeafDatePicker` uses Flutter's `CalendarDatePicker` and `LeafTimePicker` uses `CupertinoDatePicker` in time mode. Both use the Leaf design token system for styling.

## API Reference

### LeafDatePicker

A themed date picker card with expandable inline calendar.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `label` | `Widget?` | No | `null` | Label widget above the date (defaults to `Text('Date')`) |
| `icon` | `Widget?` | No | `null` | Trailing icon widget (defaults to `Icon(Icons.calendar_today)`) |
| `dateTextStyle` | `TextStyle?` | No | `null` | Text style for the displayed date |
| `activeColor` | `Color?` | No | `null` | Border color when expanded |
| `backgroundColor` | `Color?` | No | `null` | Card background color |
| `borderRadius` | `BorderRadius?` | No | `null` | Card border radius |
| `initialDate` | `DateTime?` | No | `null` | Initial selected date (defaults to now) |
| `firstDate` | `DateTime?` | No | `null` | Earliest selectable date (defaults to 1900) |
| `lastDate` | `DateTime?` | No | `null` | Latest selectable date (defaults to 2100) |
| `onChanged` | `ValueChanged<DateTime>?` | No | `null` | Called when a date is selected |

### LeafTimePicker

A themed time picker card with expandable inline Cupertino time wheel.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `label` | `Widget?` | No | `null` | Label widget above the time (defaults to `Text('Time')`) |
| `icon` | `Widget?` | No | `null` | Trailing icon widget (defaults to `Icon(Icons.access_time)`) |
| `timeTextStyle` | `TextStyle?` | No | `null` | Text style for the displayed time |
| `activeColor` | `Color?` | No | `null` | Border color when expanded |
| `backgroundColor` | `Color?` | No | `null` | Card background color |
| `borderRadius` | `BorderRadius?` | No | `null` | Card border radius |
| `initialTime` | `DateTime?` | No | `null` | Initial selected time (defaults to now) |
| `minuteInterval` | `int` | No | `5` | Minute picker interval |
| `use24hFormat` | `bool` | No | `false` | Use 24-hour format |
| `onChanged` | `ValueChanged<DateTime>?` | No | `null` | Called when the time changes |

### Style Resolution

1. Widget parameter (e.g., `activeColor`, `backgroundColor`)
2. Component theme (`theme.pickerTheme?.activeColor`, `theme.pickerTheme?.backgroundColor`)
3. Global token (`colors.primary`, `colors.surface`)

Default resolved values:
- `activeColor`: `colors.primary`
- `backgroundColor`: `colors.surface`
- `borderRadius`: `BorderRadius.circular(12.0)`
- Date format: `MM.DD YYYY` (e.g., `01.15 2025`)
- Time format: `HH:MM AM/PM` (12h) or `HH:MM` (24h)

### Expand/Collapse Behavior

Both widgets work as toggle cards:
- **Collapsed**: Shows the label, formatted value, and icon in a compact row
- **Expanded**: Shows the above plus a divider and the inline picker
- The border color changes to `activeColor` when expanded and `transparent` when collapsed
- Expanded height: 320px (date picker), 201px (time picker)

## Usage

### Basic Date Picker

```dart
LeafDatePicker(
  initialDate: DateTime.now(),
  onChanged: (date) {
    // handle date selection
  },
)
```

### Date Picker with Range

```dart
LeafDatePicker(
  label: Text('Birthday', style: TextStyle(fontSize: 12, color: Colors.grey)),
  initialDate: DateTime(1990, 1, 1),
  firstDate: DateTime(1900),
  lastDate: DateTime.now(),
  onChanged: (date) {
    // handle birthday selection
  },
)
```

### Basic Time Picker

```dart
LeafTimePicker(
  initialTime: DateTime.now(),
  onChanged: (time) {
    // handle time selection
  },
)
```

### 24-Hour Time Picker

```dart
LeafTimePicker(
  label: Text('Meeting Time'),
  initialTime: DateTime.now(),
  use24hFormat: true,
  minuteInterval: 15,
  onChanged: (time) {
    // handle time selection
  },
)
```

### Date and Time Together

```dart
Column(
  children: [
    LeafDatePicker(
      label: Text('Start Date'),
      initialDate: DateTime.now(),
      activeColor: Colors.blue,
      onChanged: (date) {
        setState(() => _startDate = date);
      },
    ),
    SizedBox(height: 16),
    LeafTimePicker(
      label: Text('Start Time'),
      initialTime: DateTime.now(),
      activeColor: Colors.blue,
      minuteInterval: 5,
      onChanged: (time) {
        setState(() => _startTime = time);
      },
    ),
  ],
)
```

### Custom Appearance

```dart
LeafDatePicker(
  label: Text('Event Date', style: TextStyle(color: Colors.purple)),
  icon: Icon(Icons.event, color: Colors.purple),
  activeColor: Colors.purple,
  backgroundColor: Colors.purple.shade50,
  borderRadius: BorderRadius.circular(20),
  dateTextStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.purple.shade900,
  ),
  onChanged: (date) {
    // handle selection
  },
)
```
