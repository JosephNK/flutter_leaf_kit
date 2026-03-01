# LeafDeviceManager

Singleton manager for device information. Collects screen metrics (via `MediaQuery`), device model/OS details (via `device_info_plus`), and device identifier. Also provides image cache control and Android SDK version check.

## API Reference

### LeafDeviceManager

Access via `LeafDeviceManager.shared`.

#### Setup Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `ensureInitialized(BuildContext context, {String? androidId})` | `static Future<void>` | Initializes both media and device info |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `shared` | `LeafDeviceManager` | Singleton instance |
| `widowPadding` | `EdgeInsets` | Window padding (safe area insets) |
| `devicePixelRatio` | `double` | Device pixel ratio |
| `textScaleFactor` | `double` | Text scale factor |
| `statusBarHeight` | `double` | Status bar height from platform dispatcher |
| `deviceSize` | `Size` | Screen size |
| `deviceModel` | `String` | Device model name (e.g., `iPhone`, `Pixel 6`) |
| `deviceOSVersion` | `String` | OS version string (e.g., `iOS 17.0`, `Android 14 (SDK 34), Google`) |
| `deviceMachine` | `String` | Machine identifier (iOS only, e.g., `iPhone15,2`) |
| `deviceIdentifier` | `String` | Unique device ID (iOS: `identifierForVendor`, Android: `ANDROID_ID`) |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `getAndroidSdkInt()` | `Future<int>` | Returns Android SDK version; `0` on iOS |
| `getStatusBarHeight(BuildContext context)` | `double` | Status bar height from a specific context |
| `openAppSettings()` | `Future<bool>` | Opens system app settings via `permission_handler` |
| `cacheClear()` | `Future<void>` | Clears the global image cache |
| `checkMemory()` | `Future<void>` | Clears image cache if live image count >= 100 |
| `checkPlatformSdk()` | `Future<bool>` | Returns `true` on iOS or Android API >= 33 |

## Usage

### Initialize

```dart
await LeafDeviceManager.ensureInitialized(context);
```

### Read Device Info

```dart
final device = LeafDeviceManager.shared;
print(device.deviceModel);       // 'iPhone'
print(device.deviceOSVersion);   // 'iOS 17.0'
print(device.deviceIdentifier);  // 'XXXXXXXX-XXXX-...'
print(device.deviceSize);        // Size(390.0, 844.0)
```

### Cache Management

```dart
await LeafDeviceManager.shared.cacheClear();
await LeafDeviceManager.shared.checkMemory();
```

### Open System Settings

```dart
await LeafDeviceManager.shared.openAppSettings();
```
