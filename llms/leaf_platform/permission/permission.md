# LeafPermissionManager

Singleton permission manager built on `permission_handler`. Automatically adapts `Permission.photos` to `Permission.storage` on Android API <= 32.

## API Reference

### LeafPermissionManager

Access via `LeafPermissionManager.shared`.

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `requestPermission(Permission permission)` | `Future<bool>` | Requests permission; opens app settings if permanently denied; returns `true` if granted |
| `requestSafePermissionStatus({required Permission permission, required ValueChanged<PermissionStatus> onNotPermission})` | `Future<bool>` | Checks grant status first, then requests only if needed |
| `requestPermissionStatus({required Permission permission, required ValueChanged<PermissionStatus> onNotPermission})` | `Future<bool>` | Requests permission and calls `onNotPermission` callback if denied |
| `isGrantedPermission({required Permission permission})` | `Future<bool>` | Checks whether a permission is currently granted (no request dialog) |

#### Android SDK Adaptation

On Android, `Permission.photos` is automatically converted to `Permission.storage` when the device SDK version is <= 32 (Android 12 and below). This handles the Android 13+ granular media permission model transparently.

## Usage

### Simple Permission Request

```dart
final granted = await LeafPermissionManager.shared.requestPermission(
  Permission.camera,
);
if (granted) {
  // Camera access available
}
```

### Safe Permission Check + Request

```dart
final granted = await LeafPermissionManager.shared.requestSafePermissionStatus(
  permission: Permission.photos,
  onNotPermission: (status) {
    if (status == PermissionStatus.permanentlyDenied) {
      // Show dialog to guide user to settings
    }
  },
);
```

### Check Without Requesting

```dart
final isGranted = await LeafPermissionManager.shared.isGrantedPermission(
  permission: Permission.location,
);
```
