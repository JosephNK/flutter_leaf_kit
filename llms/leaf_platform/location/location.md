# Location

Singleton GPS location manager built on `geolocator` and a helper class for creating `Position` objects.

## API Reference

### LeafLocationManager

Access via `LeafLocationManager.shared`.

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `shared` | `LeafLocationManager` | Singleton instance |
| `streamPosition` | `StreamSubscription<Position>?` | Active position stream subscription |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `getCurrentPosition(bool useAccuracy, LocationAccuracy accuracy)` | `Future<Position>` | Gets current position; falls back to last known position when `useAccuracy` is `false` |
| `getLastKnownPosition()` | `Future<Position?>` | Returns the last known position without GPS query |
| `startLocationListen(LocationAccuracy accuracy, ValueChanged<Position> callback)` | `void` | Starts continuous position stream with 10m distance filter |
| `stopLocationListen()` | `void` | Cancels the active position stream |
| `requestPermissionLocation()` | `Future<bool>` | Requests location permission; returns `true` if granted |
| `requestCheckPermission()` | `Future<bool>` | Checks current permission status; returns `true` if granted |
| `isLocationServiceEnabled()` | `Future<bool>` | Whether the device location service is enabled |

### GeolocatorObject

Static helper for creating `Position` objects with minimal parameters.

| Method | Return Type | Description |
|--------|-------------|-------------|
| `pos(double latitude, double longitude)` | `Position` | Creates a `Position` with zeroed altitude, speed, heading, and accuracy |

## Usage

### Get Current Position

```dart
final position = await LeafLocationManager.shared.getCurrentPosition(
  true,
  LocationAccuracy.high,
);
print('${position.latitude}, ${position.longitude}');
```

### Listen to Location Updates

```dart
LeafLocationManager.shared.startLocationListen(
  LocationAccuracy.high,
  (Position position) {
    print('Moved to: ${position.latitude}, ${position.longitude}');
  },
);

// Stop listening
LeafLocationManager.shared.stopLocationListen();
```

### Check Permission

```dart
final granted = await LeafLocationManager.shared.requestCheckPermission();
if (!granted) {
  await LeafLocationManager.shared.requestPermissionLocation();
}
```

### Create Position Object

```dart
final pos = GeolocatorObject.pos(37.5665, 126.9780); // Seoul
```
