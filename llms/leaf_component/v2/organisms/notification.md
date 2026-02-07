# LeafPushNotification

A themed push notification overlay widget that slides down from the top of the screen with animated opacity. Auto-dismisses after a configurable duration. Uses the Leaf design token system for styling and renders as an `OverlayEntry`.

## API Reference

### LeafPushNotification

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `title` | `String` | Yes | - | Notification title text |
| `body` | `String?` | No | `null` | Notification body text |
| `data` | `Map<String, dynamic>?` | No | `null` | Custom data payload |
| `onTap` | `ValueChanged<Map<String, dynamic>?>?` | No | `null` | Tap callback receiving the data payload |
| `icon` | `Widget?` | No | `null` | Custom icon widget |
| `boxDecoration` | `Decoration?` | No | `null` | Custom box decoration for the notification |
| `animationDuration` | `Duration?` | No | `null` | Slide-in/fade animation duration |
| `autoDismissDuration` | `Duration` | No | `Duration(seconds: 5)` | Auto-dismiss delay |
| `titleTextStyle` | `TextStyle?` | No | `null` | Title text style |
| `bodyTextStyle` | `TextStyle?` | No | `null` | Body text style |

#### Methods

| Method | Description |
|--------|-------------|
| `show(BuildContext context)` | Show the notification overlay |
| `closeOverlay()` | Manually remove the notification overlay |

### Style Resolution

1. Widget parameter (e.g., `boxDecoration`, `titleTextStyle`)
2. Component theme (`theme.notificationTheme?.boxDecoration`)
3. Hardcoded defaults

Default resolved values:
- `animationDuration`: `Duration(milliseconds: 450)`
- `boxDecoration`: Rounded rectangle (radius 20) with surface color and shadow
- `titleTextStyle`: `fontSize: 16.0`, `fontWeight: FontWeight.bold`, color from `colors.onSurface`
- `bodyTextStyle`: `fontSize: 14.0`, `fontWeight: FontWeight.normal`, color from `colors.onSurface`
- `icon`: `Icons.notifications` with `colors.onSurface` color, size `40.0`
- Internal fade-out timer: 3 seconds after slide-in completes

### Animation Behavior

1. The notification slides down from the top (0 to 50px offset) with opacity fade-in
2. After 3 seconds, the notification fades out
3. After the `autoDismissDuration` (default 5 seconds), the overlay entry is removed

## Usage

### Basic

```dart
final notification = LeafPushNotification(
  title: 'New Message',
  body: 'You have received a new message from John.',
);

notification.show(context);
```

### With Data Payload and Tap Handler

```dart
final notification = LeafPushNotification(
  title: 'Order Update',
  body: 'Your order #1234 has been shipped.',
  data: {'orderId': '1234', 'status': 'shipped'},
  onTap: (data) {
    // Navigate to order detail
    final orderId = data?['orderId'];
    Navigator.of(context).pushNamed('/orders/$orderId');
  },
);

notification.show(context);
```

### Custom Appearance

```dart
final notification = LeafPushNotification(
  title: 'Alert',
  body: 'System maintenance in 30 minutes.',
  icon: Icon(Icons.warning_amber, color: Colors.orange, size: 40),
  animationDuration: Duration(milliseconds: 600),
  autoDismissDuration: Duration(seconds: 10),
  titleTextStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  ),
  bodyTextStyle: TextStyle(
    fontSize: 14,
    color: Colors.grey.shade700,
  ),
  boxDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
);

notification.show(context);
```

### Manual Dismissal

```dart
final notification = LeafPushNotification(
  title: 'Processing',
  body: 'Upload in progress...',
  autoDismissDuration: Duration(seconds: 30),
);

notification.show(context);

// Later, when upload completes:
notification.closeOverlay();
```
