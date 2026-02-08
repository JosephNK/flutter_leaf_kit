# App Utilities

Four static utility classes for common app-level operations: badge count, sharing, app tracking transparency (iOS), and URL launching.

## API Reference

### LeafAppBadge

Static utility for managing the app icon badge count.

| Method | Return Type | Description |
|--------|-------------|-------------|
| `isSupported()` | `Future<bool>` | Whether the platform supports badge count |
| `updateCount(int count)` | `Future<void>` | Sets the badge count (no-op if unsupported) |
| `remove()` | `Future<void>` | Clears the badge count (sets to 0) |

### LeafShare

Static utility for sharing text, files, and URIs via the system share sheet. Returns `ShareResultStatus` from `share_plus`.

| Method | Return Type | Description |
|--------|-------------|-------------|
| `text(String text, {String? subject, Rect? sharePositionOrigin})` | `Future<ShareResultStatus>` | Shares text content |
| `files(List<XFile> files, {String? subject, String? text, Rect? sharePositionOrigin})` | `Future<ShareResultStatus>` | Shares files with optional text |
| `uri(Uri uri, {Rect? sharePositionOrigin})` | `Future<ShareResultStatus>` | Shares a URI |

### LeafTracking

Static utility for iOS App Tracking Transparency (ATT). Returns `TrackingStatus` from `app_tracking_transparency`.

| Method | Return Type | Description |
|--------|-------------|-------------|
| `requestAppTracking(BuildContext context)` | `Future<TrackingStatus>` | Requests tracking authorization on iOS; returns `notSupported` on Android |
| `getAdvertisingIdentifier()` | `Future<String?>` | Returns the iOS advertising identifier (IDFA); returns `null` on Android |

### LeafUrlLauncher

Static utility for opening URLs via the system.

| Method | Return Type | Description |
|--------|-------------|-------------|
| `launch(Uri url, {LaunchMode mode, WebViewConfiguration webViewConfiguration, String? webOnlyWindowName, bool checkCanUrl})` | `Future<bool>` | Opens a URL; optionally checks `canLaunchUrl` first |

#### launch Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `url` | `Uri` | required | URL to open |
| `mode` | `LaunchMode` | `platformDefault` | Launch mode (in-app, external, etc.) |
| `webViewConfiguration` | `WebViewConfiguration` | `const WebViewConfiguration()` | Web view configuration |
| `webOnlyWindowName` | `String?` | `null` | Window name for web platform |
| `checkCanUrl` | `bool` | `true` | Whether to check `canLaunchUrl` before launching |

## Usage

### Badge Count

```dart
if (await LeafAppBadge.isSupported()) {
  await LeafAppBadge.updateCount(5);
}
// Clear badge
await LeafAppBadge.remove();
```

### Share Text

```dart
final status = await LeafShare.text(
  'Check this out!',
  subject: 'Interesting link',
);
```

### Share Files

```dart
final status = await LeafShare.files(
  [XFile('/path/to/image.png')],
  text: 'Here is the photo',
);
```

### App Tracking (iOS)

```dart
final status = await LeafTracking.requestAppTracking(context);
if (status == TrackingStatus.authorized) {
  final idfa = await LeafTracking.getAdvertisingIdentifier();
}
```

### URL Launch

```dart
await LeafUrlLauncher.launch(
  Uri.parse('https://example.com'),
  mode: LaunchMode.externalApplication,
);
```
