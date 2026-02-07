# LeafToast

A themed toast utility for showing brief messages and notifications. Provides two display modes: a simple platform toast via `fluttertoast` and a rich notification-style toast via `toastification`. Uses the Leaf design token system for styling.

## API Reference

### LeafToastType

Toast display duration type.

| Value | Maps To | Description |
|-------|---------|-------------|
| `lengthShort` | `Toast.LENGTH_SHORT` | Short duration toast |
| `lengthLong` | `Toast.LENGTH_LONG` | Long duration toast |

### LeafToastGravityType

Toast gravity (position) type.

| Value | Maps To | Description |
|-------|---------|-------------|
| `top` | `ToastGravity.TOP` | Show at top of screen |
| `center` | `ToastGravity.CENTER` | Show at center of screen |
| `bottom` | `ToastGravity.BOTTOM` | Show at bottom of screen |

### LeafToastNotificationType

Toastification notification type.

| Value | Description |
|-------|-------------|
| `info` | Informational notification |
| `warning` | Warning notification |
| `success` | Success notification |
| `error` | Error notification |

### LeafToastNotificationStyle

Toastification notification visual style.

| Value | Description |
|-------|-------------|
| `minimal` | Minimal design |
| `fillColored` | Filled colored background |
| `flatColored` | Flat colored style |
| `flat` | Flat style (default) |
| `simple` | Simple style with black background |

### LeafToast

A utility class with static `showToast` and `showNotification` methods. No instantiation needed.

#### LeafToast.showToast()

Shows a simple platform toast message.

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `message` | `String` | Yes | - | Toast message text |
| `toastType` | `LeafToastType` | No | `lengthShort` | Display duration |
| `gravity` | `LeafToastGravityType` | No | `bottom` | Screen position |
| `backgroundColor` | `Color?` | No | `null` | Toast background color |
| `textStyle` | `TextStyle?` | No | `null` | Message text style |

**Returns**: `Future<bool?>`

#### LeafToast.showNotification()

Shows a rich notification-style toast via toastification.

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `context` | `BuildContext` | Yes | - | Build context |
| `message` | `String` | Yes | - | Notification title text |
| `description` | `String?` | No | `null` | Description text below title |
| `type` | `LeafToastNotificationType?` | No | `null` | Notification type (info/warning/success/error) |
| `style` | `LeafToastNotificationStyle?` | No | `null` | Visual style |
| `alignment` | `Alignment?` | No | `null` | Screen alignment |
| `duration` | `Duration?` | No | `null` | Auto-close duration |
| `backgroundColor` | `Color?` | No | `null` | Background color |
| `textStyle` | `TextStyle?` | No | `null` | Title text style |
| `descriptionTextStyle` | `TextStyle?` | No | `null` | Description text style |
| `borderRadius` | `BorderRadiusGeometry?` | No | `null` | Border radius |
| `borderSide` | `BorderSide?` | No | `null` | Border side |
| `closeOnClick` | `bool` | No | `true` | Close when tapped |
| `dragToClose` | `bool` | No | `true` | Allow drag to dismiss |
| `showIcon` | `bool?` | No | `null` | Show notification type icon |

**Returns**: `ToastificationItem`

### Style Resolution

1. Widget parameter (e.g., `backgroundColor`)
2. Component theme (`theme.toastTheme?.backgroundColor`)
3. Hardcoded defaults

Default resolved values (showToast):
- `backgroundColor`: `Colors.black87`
- `textColor`: `Colors.white`
- `fontSize`: `16.0`

Default resolved values (showNotification):
- `style`: `LeafToastNotificationStyle.flat`
- `alignment`: `Alignment.topCenter`
- `duration`: `Duration(seconds: 5)`
- `showProgressBar`: `false`
- For `simple` style: black background, white text

## Usage

### Simple Toast

```dart
LeafToast.showToast(
  context,
  message: 'Item saved successfully',
);
```

### Toast with Options

```dart
LeafToast.showToast(
  context,
  message: 'Network error occurred',
  toastType: LeafToastType.lengthLong,
  gravity: LeafToastGravityType.center,
  backgroundColor: Colors.red,
  textStyle: TextStyle(color: Colors.white, fontSize: 14),
);
```

### Success Notification

```dart
LeafToast.showNotification(
  context,
  message: 'Profile Updated',
  description: 'Your profile changes have been saved.',
  type: LeafToastNotificationType.success,
);
```

### Error Notification

```dart
LeafToast.showNotification(
  context,
  message: 'Upload Failed',
  description: 'Please check your internet connection.',
  type: LeafToastNotificationType.error,
  style: LeafToastNotificationStyle.fillColored,
  duration: Duration(seconds: 8),
);
```

### Simple Style Notification

```dart
LeafToast.showNotification(
  context,
  message: 'New message received',
  style: LeafToastNotificationStyle.simple,
  alignment: Alignment.bottomCenter,
);
```

### Warning Notification with Custom Duration

```dart
LeafToast.showNotification(
  context,
  message: 'Low Storage',
  description: 'Your device storage is running low.',
  type: LeafToastNotificationType.warning,
  duration: Duration(seconds: 10),
  closeOnClick: true,
  dragToClose: true,
);
```
