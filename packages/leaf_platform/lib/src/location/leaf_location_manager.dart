import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LeafLocationManager {
  static final LeafLocationManager _instance = LeafLocationManager._internal();

  static LeafLocationManager get shared => _instance;

  LeafLocationManager._internal();

  StreamSubscription<Position>? streamPosition;

  Future<Position> getCurrentPosition(
      bool useAccuracy, LocationAccuracy accuracy) async {
    if (!useAccuracy) {
      final position = await getLastKnownPosition();
      if (position != null) {
        return position;
      }
    }
    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: accuracy,
      ),
    );
    return position;
  }

  Future<Position?> getLastKnownPosition() async {
    final position = await Geolocator.getLastKnownPosition();
    return position;
  }

  void startLocationListen(
      LocationAccuracy accuracy, ValueChanged<Position> callback) async {
    stopLocationListen();

    streamPosition = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: 10,
      ),
    ).listen(
      (Position position) {
        callback.call(position);
      },
    );
  }

  void stopLocationListen() {
    if (streamPosition != null) {
      streamPosition!.cancel();
      streamPosition = null;
    }
  }

  Future<bool> requestPermissionLocation() async {
    final status = await Geolocator.requestPermission();
    final isDenied = _isDeniedStatus(status);
    return !isDenied;
  }

  Future<bool> requestCheckPermission() async {
    final status = await Geolocator.checkPermission();
    final isDenied = _isDeniedStatus(status);
    return !isDenied;
  }

  Future<bool> isLocationServiceEnabled() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    return enabled;
  }

  bool _isDeniedStatus(LocationPermission permission) {
    final isDenied = (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever);
    return isDenied;
  }
}

////////////////////////////////////////////////////////////////////////////////

class GeolocatorObject {
  static Position pos(double latitude, double longitude) {
    return Position(
      latitude: latitude,
      longitude: longitude,
      altitude: 0.0,
      altitudeAccuracy: 0.0,
      speedAccuracy: 0.0,
      heading: 0.0,
      headingAccuracy: 0.0,
      speed: 0.0,
      accuracy: 0.0,
      timestamp: DateTime.now(),
    );
  }
}
