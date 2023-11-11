part of leaf_map;

class MapUtil {
  static bool isInsideCircle(LatLng point, Circle circle) {
    double distance = Geolocator.distanceBetween(
      point.latitude,
      point.longitude,
      circle.center.latitude,
      circle.center.longitude,
    );
    return distance <= circle.radius;
  }
}
