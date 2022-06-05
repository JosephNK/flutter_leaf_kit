import 'package:flutter/foundation.dart';
import 'package:leaf_common/leaf_common.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionType { camera, photo, storage, location }

class LeafPermission {
  // isGranted로 안전하게 퍼미션 체크 후
  // 퍼미션이 없을 경우, request 요청!
  static Future<bool> requestSafePermissionStatus({
    required PermissionType permissionType,
    required VoidCallback onNotPermission,
  }) async {
    final isGranted = await isGrantedPermission(
      permissionType: permissionType,
    );
    if (!isGranted) {
      return await requestPermissionStatus(
        permissionType: permissionType,
        onNotPermission: onNotPermission,
      );
    }
    return true;
  }

  // Permisssion request 할 때
  // didChangeAppLifecycleState 함수 called!!
  static Future<bool> requestPermissionStatus({
    required PermissionType permissionType,
    required VoidCallback onNotPermission,
  }) async {
    PermissionStatus status = PermissionStatus.denied;
    try {
      switch (permissionType) {
        case PermissionType.camera:
          status = await Permission.camera.request();
          break;
        case PermissionType.photo:
          status = await Permission.photos.request();
          break;
        case PermissionType.storage:
          status = await Permission.storage.request();
          break;
        case PermissionType.location:
          status = await Permission.location.request();
          break;
      }
    } catch (e) {
      Logging.e('[RequestPermission] e => $e');
    }
    if (status != PermissionStatus.granted) {
      onNotPermission.call();
      return false;
    }
    return true;
  }

  // 상태만 체크하는 함수이기에
  // didChangeAppLifecycleState 함수 호출 하지 않음.
  static Future<bool> isGrantedPermission({
    required PermissionType permissionType,
  }) async {
    var isGranted = true;
    switch (permissionType) {
      case PermissionType.camera:
        isGranted = await Permission.camera.isGranted;
        break;
      case PermissionType.photo:
        isGranted = await Permission.photos.isGranted;
        break;
      case PermissionType.storage:
        isGranted = await Permission.storage.isGranted;
        break;
      case PermissionType.location:
        isGranted = await Permission.location.isGranted;
        break;
    }
    if (!isGranted) {
      return false;
    }
    return true;
  }
}
