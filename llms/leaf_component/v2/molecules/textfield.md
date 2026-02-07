# LeafTextField

A themed text field widget that resolves all colors and styles from the Leaf design token system. Uses `LeafTextFieldController` for programmatic control including set, clear, and reset operations.

## API Reference

### LeafTextFieldController

A `ChangeNotifier`-based controller for programmatic manipulation of `LeafTextField`.

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `controller` | `TextEditingController` | The underlying Flutter text editing controller |
| `status` | `LeafTextFieldStatus` | Current status of the controller |
| `value` | `String?` | The current text value |
| `text` | `String` | Getter for current text; setter triggers `setText` status |

#### Methods

| Method | Description |
|--------|-------------|
| `reset()` | Clears text and resets to initial state |
| `clear()` | Clears the text content |
| `none()` | Resets the status to `none` |
| `dispose()` | Disposes the underlying `TextEditingController` |

#### LeafTextFieldStatus

| Value | Description |
|-------|-------------|
| `none` | Idle state |
| `clear` | Clear the text field |
| `reset` | Reset the text field |
| `setText` | Set text to a new value |

### LeafTextField

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `controller` | `LeafTextFieldController` | Yes | - | Controller for programmatic text manipulation |
| `textStyle` | `TextStyle?` | No | `null` | Custom text style |
| `autofocus` | `bool` | No | `false` | Whether to autofocus on mount |
| `disabled` | `bool` | No | `false` | Disables the text field |
| `readOnly` | `bool` | No | `false` | Makes the text field read-only |
| `showCursor` | `bool?` | No | `null` | Whether to show the cursor |
| `enableClearButton` | `bool` | No | `true` | Shows a clear button when text is present |
| `onlyUnderline` | `bool` | No | `true` | Uses underline border instead of outline |
| `obscureText` | `bool` | No | `false` | Obscures text for passwords |
| `placeHolder` | `String?` | No | `null` | Placeholder/hint text |
| `focusNode` | `FocusNode?` | No | `null` | Custom focus node |
| `keyboardType` | `TextInputType` | No | `TextInputType.text` | Keyboard type |
| `textInputAction` | `TextInputAction` | No | `TextInputAction.done` | Keyboard action button |
| `textAlign` | `TextAlign` | No | `TextAlign.left` | Text alignment |
| `maxLength` | `int?` | No | `null` | Maximum character length |
| `minLines` | `int` | No | `1` | Minimum number of lines |
| `maxLines` | `int` | No | `1` | Maximum number of lines |
| `borderRadius` | `double?` | No | `null` | Border corner radius |
| `borderWidth` | `double?` | No | `null` | Border width |
| `contentPadding` | `EdgeInsets?` | No | `null` | Content padding |
| `backgroundColor` | `Color?` | No | `null` | Background color |
| `disabledBackgroundColor` | `Color?` | No | `null` | Background when disabled |
| `borderColor` | `Color?` | No | `null` | Border color |
| `focusBorderColor` | `Color?` | No | `null` | Border color when focused |
| `errorBorderColor` | `Color?` | No | `null` | Border color on error |
| `textColor` | `Color?` | No | `null` | Text color |
| `disabledTextColor` | `Color?` | No | `null` | Text color when disabled |
| `placeHolderColor` | `Color?` | No | `null` | Placeholder text color |
| `clearIconColor` | `Color?` | No | `null` | Clear button icon color |
| `disabledClearIconColor` | `Color?` | No | `null` | Clear icon color when disabled |
| `enableSuggestions` | `bool` | No | `true` | Enable keyboard suggestions |
| `autocorrect` | `bool` | No | `true` | Enable autocorrect |
| `prefixIcon` | `Widget?` | No | `null` | Widget before the input area |
| `suffixIcon` | `Widget?` | No | `null` | Widget after the input area |
| `clearIcon` | `Widget?` | No | `null` | Custom clear button icon |
| `counterWidget` | `Widget?` | No | `null` | Custom counter widget |
| `counterText` | `String?` | No | `null` | Counter text |
| `countTextStyle` | `TextStyle?` | No | `null` | Counter text style |
| `errorWidget` | `Widget?` | No | `null` | Custom error widget |
| `errorText` | `String?` | No | `null` | Error message text |
| `errorTextStyle` | `TextStyle?` | No | `null` | Error text style |
| `prefixIconConstraints` | `BoxConstraints?` | No | `null` | Constraints for prefix icon |
| `suffixIconConstraints` | `BoxConstraints?` | No | `null` | Constraints for suffix icon |
| `inputFormatters` | `List<TextInputFormatter>?` | No | `null` | Input formatters |
| `onTap` | `VoidCallback?` | No | `null` | Called when the field is tapped |
| `onFocusChanged` | `ValueChanged<bool>?` | No | `null` | Called when focus changes |
| `onChanged` | `ValueChanged<String>?` | No | `null` | Called when text changes |
| `onSubmitted` | `ValueChanged<String>?` | No | `null` | Called when text is submitted |
| `onEditingComplete` | `VoidCallback?` | No | `null` | Called when editing completes |
| `onClearPressed` | `VoidCallback?` | No | `null` | Called when clear button is pressed |

### Style Resolution

1. Widget parameter (e.g., `backgroundColor`)
2. Component theme (`theme.textFieldTheme?.backgroundColor`)
3. Global token (`colors.disabled`, `colors.onSurface`, `colors.divider`, etc.)

Default resolved values:
- `borderRadius`: `0.0`
- `borderWidth`: `1.0`
- `contentPadding`: `EdgeInsets.all(16.0)`
- `textStyle`: `theme.typography.bodyLarge` with normal font weight

## Usage

### Basic

```dart
final controller = LeafTextFieldController();

LeafTextField(
  controller: controller,
  placeHolder: 'Enter your name',
  onChanged: (value) {
    // handle text change
  },
)
```

### With Validation and Error

```dart
LeafTextField(
  controller: controller,
  placeHolder: 'Email address',
  keyboardType: TextInputType.emailAddress,
  maxLength: 100,
  errorText: 'Please enter a valid email',
  prefixIcon: Icon(Icons.email),
  onSubmitted: (value) {
    // handle submission
  },
)
```

### Password Field

```dart
LeafTextField(
  controller: controller,
  placeHolder: 'Password',
  obscureText: true,
  enableClearButton: false,
  onlyUnderline: false,
  borderRadius: 8.0,
)
```

### Multiline Text Area

```dart
LeafTextField(
  controller: controller,
  placeHolder: 'Write your message...',
  minLines: 3,
  maxLines: 5,
  onlyUnderline: false,
  borderRadius: 12.0,
)
```

### Programmatic Control

```dart
// Set text
controller.text = 'Hello World';

// Clear text
controller.clear();

// Reset to initial state
controller.reset();

// Read current text
final currentText = controller.text;
```
