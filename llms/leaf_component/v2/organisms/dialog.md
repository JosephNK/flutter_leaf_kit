# LeafAlertDialog & Picker Dialogs

A comprehensive dialog system with static show methods for alerts, confirmations, and various picker dialogs (radio, checkbox, chip, calendar date, calendar time, between-date, and between-time). All dialogs use the Leaf design token system for consistent theming.

## API Reference

### LeafAlertDialog

A themed alert dialog with static `show` and `confirm` methods.

#### LeafAlertDialog.show()

Shows an alert dialog with a single OK button.

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `message` | `String` | Yes | - | Dialog message text |
| `title` | `String?` | No | `null` | Dialog title |
| `autoPop` | `bool` | No | `true` | Auto-dismiss on button press |
| `barrierDismissible` | `bool` | No | `true` | Dismiss by tapping outside |
| `visibleCloseButton` | `bool` | No | `false` | Show close (X) button |
| `expandableButton` | `bool` | No | `false` | Expand OK button to full width |
| `titleStyle` | `TextStyle?` | No | `null` | Title text style |
| `messageStyle` | `TextStyle?` | No | `null` | Message text style |
| `okText` | `String?` | No | `null` | OK button text |
| `okTextStyle` | `TextStyle?` | No | `null` | OK button text style |
| `okTextBackgroundColor` | `Color?` | No | `null` | OK button background |
| `okTextBorderColor` | `Color?` | No | `null` | OK button border color |
| `okTextPadding` | `EdgeInsets?` | No | `null` | OK button padding |
| `onOK` | `VoidCallback?` | No | `null` | OK button callback |

#### LeafAlertDialog.confirm()

Shows a confirmation dialog with Cancel and OK buttons.

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `message` | `String` | Yes | - | Dialog message text |
| `title` | `String?` | No | `null` | Dialog title |
| `autoPop` | `bool` | No | `true` | Auto-dismiss on button press |
| `barrierDismissible` | `bool` | No | `true` | Dismiss by tapping outside |
| `titleStyle` | `TextStyle?` | No | `null` | Title text style |
| `messageStyle` | `TextStyle?` | No | `null` | Message text style |
| `okText` | `String?` | No | `null` | OK button text |
| `okTextStyle` | `TextStyle?` | No | `null` | OK button text style |
| `okTextBackgroundColor` | `Color?` | No | `null` | OK button background |
| `okTextBorderColor` | `Color?` | No | `null` | OK button border color |
| `okTextPadding` | `EdgeInsets?` | No | `null` | OK button padding |
| `cancelText` | `String?` | No | `null` | Cancel button text |
| `cancelTextStyle` | `TextStyle?` | No | `null` | Cancel button text style |
| `cancelTextBackgroundColor` | `Color?` | No | `null` | Cancel button background |
| `cancelTextBorderColor` | `Color?` | No | `null` | Cancel button border color |
| `cancelTextPadding` | `EdgeInsets?` | No | `null` | Cancel button padding |
| `onCancel` | `VoidCallback?` | No | `null` | Cancel button callback |
| `onOK` | `VoidCallback?` | No | `null` | OK button callback |

### LeafDialogTitle

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `text` | `String` | Yes | - | Title text |
| `textStyle` | `TextStyle?` | No | `null` | Custom text style |
| `maxLines` | `int` | No | `2` | Maximum lines |

### LeafDialogMessage

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `text` | `String` | Yes | - | Message text |
| `textStyle` | `TextStyle?` | No | `null` | Custom text style |
| `maxLines` | `int` | No | `5` | Maximum lines |

### LeafDialogOKButton / LeafDialogCancelButton

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `autoPop` | `bool` | No | `true` | Auto-dismiss dialog on press |
| `text` | `String?` | No | `null` | Button text (defaults: 'OK' / 'Cancel') |
| `textStyle` | `TextStyle?` | No | `null` | Button text style |
| `backgroundColor` | `Color?` | No | `null` | Button background color |
| `borderColor` | `Color?` | No | `null` | Button border color |
| `padding` | `EdgeInsets?` | No | `null` | Button padding |
| `onPressed` | `VoidCallback?` | No | `null` | Press callback |

### LeafRadioPickerDialog

A picker dialog with radio (single-select) selection using `LeafRadioGroup`.

#### LeafRadioPickerDialog.show()

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `items` | `List<LeafDataItem>` | Yes | - | Selectable items |
| `value` | `LeafDataItem` | Yes | - | Currently selected value |
| `title` | `String?` | No | `null` | Dialog title |
| `message` | `String?` | No | `null` | Dialog message |
| `onCancel` | `VoidCallback?` | No | `null` | Cancel callback |
| `onOK` | `ValueChanged<LeafDataItem>?` | No | `null` | OK callback with selected item |
| *(plus all standard button styling parameters)* | | | | |

### LeafCheckboxPickerDialog

A picker dialog with checkbox (multi-select) selection using `LeafCheckBoxGroup`.

#### LeafCheckboxPickerDialog.show()

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `items` | `List<LeafDataItem>` | Yes | - | Selectable items |
| `values` | `List<LeafDataItem>?` | No | `null` | Currently selected values |
| `title` | `String?` | No | `null` | Dialog title |
| `onOK` | `ValueChanged<List<LeafDataItem>>?` | No | `null` | OK callback with selected items |
| *(plus all standard button styling parameters)* | | | | |

### LeafChipPickerDialog

A picker dialog with chip selection (single or multi-select) using `LeafChips`.

#### LeafChipPickerDialog.show()

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `items` | `List<LeafDataItem>` | Yes | - | Selectable items |
| `values` | `List<LeafDataItem>?` | No | `null` | Currently selected values |
| `multiple` | `bool` | No | `true` | Allow multiple selection |
| `title` | `String?` | No | `null` | Dialog title |
| `onOK` | `ValueChanged<List<LeafDataItem>>?` | No | `null` | OK callback with selected items |
| *(plus all standard button styling parameters)* | | | | |

### LeafCalendarDatePickerDialog

A dialog with Flutter's built-in `CalendarDatePicker` for single date selection.

#### LeafCalendarDatePickerDialog.show()

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `date` | `DateTime?` | No | `null` | Initial selected date |
| `firstDate` | `DateTime?` | No | `null` | Earliest selectable date |
| `lastDate` | `DateTime?` | No | `null` | Latest selectable date |
| `activeColor` | `Color?` | No | `null` | Active/selected color |
| `okText` | `String?` | No | `null` | OK button text |
| `okTextStyle` | `TextStyle?` | No | `null` | OK button text style |
| `okTextBackgroundColor` | `Color?` | No | `null` | OK button background |
| `okTextBorderColor` | `Color?` | No | `null` | OK button border |
| `okTextPadding` | `EdgeInsets?` | No | `null` | OK button padding |
| `onOK` | `ValueChanged<DateTime>?` | No | `null` | OK callback with selected date |

### LeafCalendarTimePickerDialog

A dialog with `CupertinoDatePicker` in time mode for time selection.

#### LeafCalendarTimePickerDialog.show()

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `time` | `DateTime?` | No | `null` | Initial time |
| `okText` | `String?` | No | `null` | OK button text |
| `okTextStyle` | `TextStyle?` | No | `null` | OK button text style |
| `okTextBackgroundColor` | `Color?` | No | `null` | OK button background |
| `okTextBorderColor` | `Color?` | No | `null` | OK button border |
| `okTextPadding` | `EdgeInsets?` | No | `null` | OK button padding |
| `onOK` | `ValueChanged<DateTime>?` | No | `null` | OK callback with selected time |

### LeafCalendarBetweenDatePickerDialog

A dialog for selecting a date within a start/end date range.

#### LeafCalendarBetweenPickerSelect (enum)

| Value | Description |
|-------|-------------|
| `none` | No specific selection mode |
| `start` | Selecting start date |
| `end` | Selecting end date |

#### LeafCalendarBetweenDatePickerDialog.show()

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `pickerSelect` | `LeafCalendarBetweenPickerSelect` | Yes | - | Selection mode |
| `startDate` | `DateTime?` | No | `null` | Initial start date |
| `endDate` | `DateTime?` | No | `null` | Initial end date |
| `firstDate` | `DateTime?` | No | `null` | Earliest selectable date |
| `lastDate` | `DateTime?` | No | `null` | Latest selectable date |
| `activeColor` | `Color?` | No | `null` | Active selection color |
| `inactiveColor` | `Color?` | No | `null` | Inactive label color |
| `startText` | `String` | No | `'Start'` | Start label text |
| `endText` | `String` | No | `'End'` | End label text |
| `validStartMessage` | `String` | No | `'Please set the start date before the end date'` | Validation message |
| `validEndMessage` | `String` | No | `'Please set the end date after the start date'` | Validation message |
| `onOK` | `void Function(LeafCalendarBetweenPickerSelect, DateTime)?` | No | `null` | OK callback |
| *(plus standard OK button styling parameters)* | | | | |

### LeafCalendarBetweenTimePickerDialog

A dialog for selecting a time within a start/end time range using `CupertinoDatePicker` in time mode.

#### LeafCalendarBetweenTimePickerDialog.show()

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `pickerSelect` | `LeafCalendarBetweenPickerSelect` | Yes | - | Selection mode |
| `startTime` | `DateTime?` | No | `null` | Initial start time |
| `endTime` | `DateTime?` | No | `null` | Initial end time |
| `activeColor` | `Color?` | No | `null` | Active selection color |
| `inactiveColor` | `Color?` | No | `null` | Inactive label color |
| `startText` | `String` | No | `'Start'` | Start label text |
| `endText` | `String` | No | `'End'` | End label text |
| `validStartMessage` | `String` | No | `'Please set the start time before the end time'` | Validation message |
| `validEndMessage` | `String` | No | `'Please set the end time after the start time'` | Validation message |
| `okText` | `String?` | No | `null` | OK button text |
| `onOK` | `void Function(LeafCalendarBetweenPickerSelect, DateTime)?` | No | `null` | OK callback |

### Style Resolution

1. Widget parameter (e.g., `okTextBackgroundColor`)
2. Component theme (`theme.dialogTheme?.okTextBackgroundColor`)
3. Global token / hardcoded defaults

Default resolved values:
- OK button background: `colors.primary`
- Cancel button background: `Colors.grey.withValues(alpha: 0.5)`
- OK text: `'OK'`
- Cancel text: `'Cancel'`
- Button border radius: `10.0`
- Button padding: `EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0)`

## Usage

### Simple Alert

```dart
LeafAlertDialog.show(
  context,
  title: 'Notice',
  message: 'Your changes have been saved.',
  onOK: () {
    // handle OK
  },
);
```

### Confirmation Dialog

```dart
LeafAlertDialog.confirm(
  context,
  title: 'Delete Item',
  message: 'Are you sure you want to delete this item?',
  okText: 'Delete',
  cancelText: 'Keep',
  onOK: () {
    // handle delete
  },
  onCancel: () {
    // handle cancel
  },
);
```

### Radio Picker Dialog

```dart
LeafRadioPickerDialog.show(
  context,
  title: 'Select Language',
  items: [
    LeafDataItem(key: 'en', value: 'English'),
    LeafDataItem(key: 'ko', value: 'Korean'),
    LeafDataItem(key: 'ja', value: 'Japanese'),
  ],
  value: LeafDataItem(key: 'en', value: 'English'),
  onOK: (selected) {
    // handle selection
  },
);
```

### Checkbox Picker Dialog

```dart
LeafCheckboxPickerDialog.show(
  context,
  title: 'Select Interests',
  items: [
    LeafDataItem(key: '1', value: 'Sports'),
    LeafDataItem(key: '2', value: 'Music'),
    LeafDataItem(key: '3', value: 'Travel'),
  ],
  values: [LeafDataItem(key: '1', value: 'Sports')],
  onOK: (selected) {
    // handle selections
  },
);
```

### Chip Picker Dialog

```dart
LeafChipPickerDialog.show(
  context,
  title: 'Select Tags',
  items: [
    LeafDataItem(key: '1', value: 'Flutter'),
    LeafDataItem(key: '2', value: 'Dart'),
    LeafDataItem(key: '3', value: 'iOS'),
  ],
  multiple: true,
  onOK: (selected) {
    // handle selections
  },
);
```

### Calendar Date Picker Dialog

```dart
LeafCalendarDatePickerDialog.show(
  context,
  date: DateTime.now(),
  firstDate: DateTime(2020),
  lastDate: DateTime(2030),
  onOK: (selectedDate) {
    // handle date selection
  },
);
```

### Calendar Time Picker Dialog

```dart
LeafCalendarTimePickerDialog.show(
  context,
  time: DateTime.now(),
  onOK: (selectedTime) {
    // handle time selection
  },
);
```

### Between Date Picker Dialog

```dart
LeafCalendarBetweenDatePickerDialog.show(
  context,
  pickerSelect: LeafCalendarBetweenPickerSelect.start,
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 7)),
  onOK: (select, dateTime) {
    // handle date range selection
  },
);
```

### Between Time Picker Dialog

```dart
LeafCalendarBetweenTimePickerDialog.show(
  context,
  pickerSelect: LeafCalendarBetweenPickerSelect.start,
  startTime: DateTime.now(),
  endTime: DateTime.now().add(Duration(hours: 2)),
  onOK: (select, dateTime) {
    // handle time range selection
  },
);
```
