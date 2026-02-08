# Map Utilities

Static utilities for Google Maps: geo-fence circle containment check and custom marker bitmap generation from `IconData`.

## API Reference

### MapUtil

Static utility for map geometry calculations.

| Method | Return Type | Description |
|--------|-------------|-------------|
| `isInsideCircle(LatLng point, Circle circle)` | `bool` | Returns `true` if the point is within the circle's radius using `Geolocator.distanceBetween` |

### MapMarkerBitmapIcon

Generates a custom circular map marker `BitmapDescriptor` from a Flutter `IconData`.

#### Constructor

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `markerSize` | `double` | Yes | Diameter of the marker in logical pixels |

The constructor pre-calculates stroke width, circle offset, fill radius, icon size, and icon offset from `markerSize`.

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `createBitmapDescriptorFromIconData(IconData iconData, Color iconColor, Color circleColor, Color backgroundColor)` | `Future<BitmapDescriptor>` | Renders a circular marker with icon to a PNG `BitmapDescriptor` |

## Usage

### Check Point in Circle

```dart
final isInside = MapUtil.isInsideCircle(
  LatLng(37.5665, 126.9780),
  Circle(
    circleId: CircleId('zone'),
    center: LatLng(37.5660, 126.9784),
    radius: 500, // meters
  ),
);
```

### Create Custom Marker

```dart
final marker = MapMarkerBitmapIcon(100.0);
final bitmap = await marker.createBitmapDescriptorFromIconData(
  Icons.location_on,
  Colors.white,
  Colors.blue,
  Colors.blueAccent,
);

final mapMarker = Marker(
  markerId: MarkerId('custom'),
  position: LatLng(37.5665, 126.9780),
  icon: bitmap,
);
```
