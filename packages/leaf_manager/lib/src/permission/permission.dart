import 'package:flutter/foundation.dart';
import 'package:leaf_common/leaf_common.dart';
import 'package:permission_handler/permission_handler.dart';

enum LFPermissionType { camera, photo, storage, location }

class LFPermission {
  // isGranted 안전하게 퍼미션 체크 후
  // 퍼미션이 없을 경우, request 요청!
  static Future<bool> requestSafePermissionStatus({
    required LFPermissionType permissionType,
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

  // Permission request 할 때
  // didChangeAppLifecycleState 함수 called!!
  static Future<bool> requestPermissionStatus({
    required LFPermissionType permissionType,
    required VoidCallback onNotPermission,
  }) async {
    PermissionStatus status = PermissionStatus.denied;
    try {
      switch (permissionType) {
        case LFPermissionType.camera:
          status = await Permission.camera.request();
          break;
        case LFPermissionType.photo:
          status = await Permission.photos.request();
          break;
        case LFPermissionType.storage:
          status = await Permission.storage.request();
          break;
        case LFPermissionType.location:
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
    required LFPermissionType permissionType,
  }) async {
    var isGranted = true;
    switch (permissionType) {
      case LFPermissionType.camera:
        isGranted = await Permission.camera.isGranted;
        break;
      case LFPermissionType.photo:
        isGranted = await Permission.photos.isGranted;
        break;
      case LFPermissionType.storage:
        isGranted = await Permission.storage.isGranted;
        break;
      case LFPermissionType.location:
        isGranted = await Permission.location.isGranted;
        break;
    }
    if (!isGranted) {
      return false;
    }
    return true;
  }
}
