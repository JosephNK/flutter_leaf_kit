# LeafCalendarView

A full month-based calendar view with page-based month navigation, date selection, and external controller support. Features previous/next month navigation via arrows or swiping, date selection with visual feedback, and a custom cell builder for per-day content. Uses the Leaf design token system for styling.

## API Reference

### LeafCalendarController

External controller for programmatic navigation of `LeafCalendarView`. Uses a stream-based event system.

#### Methods

| Method | Description |
|--------|-------------|
| `goToToday()` | Jump to today and select today's date |
| `selectDate(DateTime dateTime)` | Select a specific date and navigate to its month |
| `goToMonth(DateTime dateTime)` | Navigate to the month containing the given date |
| `dispose()` | Release resources (call from host widget's dispose) |

#### Events (sealed class hierarchy)

| Event | Description |
|-------|-------------|
| `LeafCalendarTodayEvent` | Jump to today |
| `LeafCalendarSelectEvent(dateTime)` | Select a specific date |
| `LeafCalendarMonthEvent(dateTime)` | Jump to a specific month |

### LeafCalendarView

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `defaultDate` | `DateTime?` | No | `null` | Initially displayed and selected date |
| `minDate` | `DateTime?` | No | `null` | Earliest navigable month (default: January 1900) |
| `maxDate` | `DateTime?` | No | `null` | Latest navigable month (default: December 2200) |
| `controller` | `LeafCalendarController?` | No | `null` | External controller for programmatic navigation |
| `cellBuilder` | `LeafCalendarCellBuilder?` | No | `null` | Builder for custom content below each day number |
| `weekdays` | `List<String>?` | No | `null` | Custom weekday labels (length 7, starting Sunday) |
| `dayTextStyle` | `TextStyle?` | No | `null` | Text style for day numbers |
| `todayColor` | `Color?` | No | `null` | Background color for today's date circle |
| `selectedColor` | `Color?` | No | `null` | Border color for selected date |
| `holidayColor` | `Color?` | No | `null` | Color for Sunday labels and Sunday dates |
| `childAspectRatio` | `double` | No | `1.0` | Aspect ratio for day grid cells |
| `showToday` | `bool` | No | `true` | Whether to highlight today's date |
| `physics` | `ScrollPhysics?` | No | `null` | Page swipe physics |
| `onMonthChanged` | `LeafCalendarViewOnMonthChanged?` | No | `null` | Callback when displayed month changes |
| `onDateSelected` | `LeafCalendarViewOnDateSelected?` | No | `null` | Callback when a date is selected |
| `onTitleTap` | `VoidCallback?` | No | `null` | Callback when the month title is tapped |

#### Typedefs

| Typedef | Signature | Description |
|---------|-----------|-------------|
| `LeafCalendarViewOnMonthChanged` | `void Function(DateTime monthDate, DateTime? selectedDate)` | Month navigation callback |
| `LeafCalendarViewOnDateSelected` | `void Function(DateTime? selectedDate)` | Date selection callback |
| `LeafCalendarCellBuilder` | `Widget Function(BuildContext context, DateTime dateTime, Size size)` | Custom cell content builder |

### LeafCalendarMonthView

Month header with prev/next navigation arrows and a year.month label.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `dateTime` | `DateTime` | Yes | - | Currently displayed month |
| `onPrev` | `VoidCallback?` | No | `null` | Previous month button callback |
| `onNext` | `VoidCallback?` | No | `null` | Next month button callback |
| `onTitleTap` | `VoidCallback?` | No | `null` | Title tap callback |
| `titleTextStyle` | `TextStyle?` | No | `null` | Custom title text style |

### LeafCalendarWeekdayView

Displays a row of weekday labels (Sun-Sat) above the calendar grid.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `weekdays` | `List<String>?` | No | `['Sun','Mon','Tue','Wed','Thu','Fri','Sat']` | Custom weekday labels |
| `weekdayTextStyle` | `TextStyle?` | No | `null` | Text style for weekday labels |
| `holidayColor` | `Color?` | No | `null` | Color for Sunday label |

### LeafCalendarPageView

A month grid (7 columns) displaying day cells.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `pageDateTime` | `DateTime` | Yes | - | The month to render |
| `selectedDates` | `List<DateTime>` | Yes | - | Currently selected dates |
| `cellBuilder` | `LeafCalendarCellBuilder?` | No | `null` | Custom cell content builder |
| `dayTextStyle` | `TextStyle?` | No | `null` | Day number text style |
| `todayColor` | `Color?` | No | `null` | Today highlight color |
| `selectedColor` | `Color?` | No | `null` | Selected date border color |
| `holidayColor` | `Color?` | No | `null` | Sunday/holiday color |
| `childAspectRatio` | `double` | No | `1.0` | Cell aspect ratio |
| `showToday` | `bool` | No | `true` | Highlight today |
| `onSelected` | `ValueChanged<DateTime>?` | No | `null` | Date tap callback |
| `onSizeChanged` | `LeafCalendarPageViewOnSizeChanged?` | No | `null` | Grid size change callback |

### LeafCalendarPageCell

A single day cell inside the calendar month grid.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `dateTime` | `DateTime` | Yes | - | The date this cell represents |
| `selectedDates` | `List<DateTime>` | Yes | - | Currently selected dates |
| `cellBuilder` | `LeafCalendarCellBuilder?` | No | `null` | Custom content below day number |
| `weekday` | `int` | No | `-1` | Day of week (1=Mon, 7=Sun) |
| `isDisabled` | `bool` | No | `false` | Whether the day is outside current month |
| `showToday` | `bool` | No | `true` | Highlight today |
| `dayTextStyle` | `TextStyle?` | No | `null` | Day number text style |
| `todayColor` | `Color?` | No | `null` | Today background color |
| `selectedColor` | `Color?` | No | `null` | Selected border color |
| `holidayColor` | `Color?` | No | `null` | Sunday text color |
| `onSelected` | `ValueChanged<DateTime>?` | No | `null` | Tap callback |

### Style Resolution

1. Widget parameter (e.g., `todayColor`)
2. Component theme (`theme.calendarTheme?.todayColor`)
3. Global token (`colors.primary`, `colors.secondary`, `colors.error`)

Default resolved values:
- `todayColor`: `colors.primary`
- `selectedColor`: `colors.secondary`
- `holidayColor`: `colors.error`
- Today shows colored circle background with `colors.onPrimary` text
- Disabled days (outside month) show at 30% opacity

## Usage

### Basic

```dart
LeafCalendarView(
  defaultDate: DateTime.now(),
  onDateSelected: (date) {
    // handle date selection
  },
  onMonthChanged: (month, selectedDate) {
    // handle month navigation
  },
)
```

### With Controller

```dart
class _MyState extends State<MyWidget> {
  final _calendarController = LeafCalendarController();

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _calendarController.goToToday(),
          child: Text('Go to Today'),
        ),
        ElevatedButton(
          onPressed: () => _calendarController.selectDate(DateTime(2025, 12, 25)),
          child: Text('Go to Christmas'),
        ),
        LeafCalendarView(
          controller: _calendarController,
          onDateSelected: (date) {
            // handle selection
          },
          onMonthChanged: (month, selectedDate) {
            // handle month change
          },
        ),
      ],
    );
  }
}
```

### With Custom Cell Builder

```dart
LeafCalendarView(
  defaultDate: DateTime.now(),
  childAspectRatio: 0.8,
  cellBuilder: (context, dateTime, size) {
    final hasEvent = _events.containsKey(dateTime);
    if (!hasEvent) return SizedBox.shrink();
    return Center(
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      ),
    );
  },
  onDateSelected: (date) {
    // handle selection
  },
  onMonthChanged: (month, selectedDate) {
    // handle month change
  },
)
```

### Korean Weekday Labels

```dart
LeafCalendarView(
  weekdays: ['일', '월', '화', '수', '목', '금', '토'],
  onDateSelected: (date) {
    // handle selection
  },
  onMonthChanged: (month, selectedDate) {
    // handle month change
  },
)
```

### Custom Colors

```dart
LeafCalendarView(
  defaultDate: DateTime.now(),
  todayColor: Colors.blue,
  selectedColor: Colors.green,
  holidayColor: Colors.red,
  showToday: true,
  onDateSelected: (date) {
    // handle selection
  },
  onMonthChanged: (month, selectedDate) {
    // handle month change
  },
)
```
