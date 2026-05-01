# LeafDate & LeafDateDateTime

Date manipulation wrapper built on Jiffy with lunar/solar calendar conversion support. Includes a `DateTime` extension for common date comparisons and month arithmetic.

## API Reference

### LeafDate

#### Factory Constructors

| Factory | Parameters | Description |
|---------|------------|-------------|
| `LeafDate.now()` | `{bool isUtc = false}` | Current date/time |
| `LeafDate.parseFromString()` | `String string, {bool isUtc = false}` | Parse from date string |
| `LeafDate.parseFromMicrosecondsSinceEpoch()` | `int microsecondsSinceEpoch, {bool isUtc = false}` | Parse from epoch microseconds |
| `LeafDate.parseFromList()` | `List<int> list, {bool isUtc = false}` | Parse from `[year, month, day, ...]` list |
| `LeafDate.parseFromDateTime()` | `DateTime dateTime` | Wrap a `DateTime` |
| `LeafDate.parseFromJiffy()` | `Jiffy jiffy` | Wrap a `Jiffy` instance |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `jiffy` | `Jiffy` | Underlying Jiffy instance |
| `dateTime` | `DateTime` | Underlying DateTime |
| `microsecond` | `int` | Microsecond (0–999) |
| `microsecondsSinceEpoch` | `int` | Microseconds since epoch |
| `millisecond` | `int` | Millisecond (0–999) |
| `millisecondsSinceEpoch` | `int` | Milliseconds since epoch |
| `second` | `int` | Second (0–59) |
| `minute` | `int` | Minute (0–59) |
| `hour` | `int` | Hour (0–23) |
| `date` | `int` | Day of month (1–31) |

#### Conversion Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `toLocal()` | `DateTime` | Convert to local timezone |
| `toUtc()` | `DateTime` | Convert to UTC |
| `format(String? format)` | `String` | Format with pattern (e.g., `'yyyy-MM-dd'`) |
| `toLunar()` | `Jiffy` | Convert to lunar calendar |
| `toSolarFromLunar()` | `Jiffy` | Convert lunar date back to solar |
| `toLunarFormat(String format)` | `String` | Format as lunar date |
| `toSolarFromLunarFormat(String format)` | `String` | Format lunar-to-solar date |

#### Manipulation Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `add({...})` | `LeafDate` | Add duration (microseconds through years) |
| `subtract({...})` | `LeafDate` | Subtract duration (microseconds through years) |

Both `add` and `subtract` accept named parameters: `microseconds`, `milliseconds`, `seconds`, `minutes`, `hours`, `days`, `weeks`, `months`, `years` (all default to `0`).

#### Query Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `isBefore(LeafDate other, {Unit unit})` | `bool` | Is before other |
| `isAfter(LeafDate other, {Unit unit})` | `bool` | Is after other |
| `isSame(LeafDate other, {Unit unit})` | `bool` | Is same as other |
| `isSameOrAfter(LeafDate other, {Unit unit})` | `bool` | Is same or after |
| `isSameOrBefore(LeafDate other, {Unit unit})` | `bool` | Is same or before |
| `isBetween(LeafDate from, LeafDate to, {Unit unit})` | `bool` | Is between two dates |
| `diff(LeafDate other, {Unit unit, bool asFloat})` | `num` | Difference between dates |

### LeafDateDateTime (Extension on DateTime)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `isToday()` | `bool` | Whether this date is today |
| `isSameDateTime(DateTime other, {bool onlyDate = false})` | `bool` | Compare dates; `onlyDate: true` ignores time |
| `addMonths(int months)` | `DateTime` | Add months with day clamping for short months |

## Usage

### Basic Date Creation

```dart
final now = LeafDate.now();
final utcNow = LeafDate.now(isUtc: true);
final parsed = LeafDate.parseFromString('2024-01-15');
final fromDt = LeafDate.parseFromDateTime(DateTime(2024, 6, 1));
```

### Formatting

```dart
final date = LeafDate.now();
print(date.format('yyyy-MM-dd')); // 2024-01-15
print(date.format('HH:mm:ss'));   // 14:30:00
```

### Lunar Calendar

```dart
final date = LeafDate.parseFromString('2024-02-10');
print(date.toLunarFormat('yyyy-MM-dd')); // lunar date
```

### Date Manipulation

```dart
final date = LeafDate.now();
date.add(days: 7, hours: 3);
date.subtract(months: 1);
```

### Query

```dart
final a = LeafDate.parseFromString('2024-01-01');
final b = LeafDate.parseFromString('2024-12-31');
final now = LeafDate.now();

now.isBetween(a, b); // true if now is in 2024
a.diff(b, unit: Unit.day); // difference in days
```

### DateTime Extension

```dart
final dt = DateTime(2024, 1, 31);
dt.isToday();              // false
dt.addMonths(1);           // 2024-02-29 (clamped)
dt.isSameDateTime(other, onlyDate: true);
```
