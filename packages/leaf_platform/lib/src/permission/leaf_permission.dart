import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class LeafPermissionManager {
  static final LeafPermissionManager _instance =
      LeafPermissionManager._internal();
  static LeafPermissionManager get shared => _instance;
  LeafPermissionManager._internal();

  Future<bool> requestPermission(ph.Permission permission) async {
    final updatePermission = await _permissionForceChange(permission);
    final isGranted = await updatePermission.isGranted;
    if (!isGranted) {
      try {
        ph.PermissionStatus status = await updatePermission.request();
        if (status == ph.PermissionStatus.permanentlyDenied) {
          ph.openAppSettings();
          return false;
        }
        if (status != ph.PermissionStatus.granted) {
          return false;
        }
      } catch (e) {
        return false;
      }
    }
    return true;
  }

  // isGranted 안전 하게 퍼미션 체크 후
  // 퍼미션 없을 경우, request 요청!
  Future<bool> requestSafePermissionStatus({
    required ph.Permission permission,
    required ValueChanged<ph.PermissionStatus> onNotPermission,
  }) async {
    final isGranted = await isGrantedPermission(permission: permission);
    if (!isGranted) {
      return await requestPermissionStatus(
        permission: permission,
        onNotPermission: onNotPermission,
      );
    }
    return true;
  }

  // Permission request 할 때
  // didChangeAppLifecycleState 함수 called!!
  Future<bool> requestPermissionStatus({
    required ph.Permission permission,
    required ValueChanged<ph.PermissionStatus> onNotPermission,
  }) async {
    final updatePermission = await _permissionForceChange(permission);
    ph.PermissionStatus status = ph.PermissionStatus.denied;
    try {
      status = await updatePermission.request();
    } catch (e) {
      Logging.e('[RequestPermission] e => $e');
    }
    if (status != ph.PermissionStatus.granted) {
      onNotPermission.call(status);
      return false;
    }
    return true;
  }

  // 상태만 체크 하는 함수 이기에
  // didChangeAppLifecycleState 함수 호출 하지 않음.
  Future<bool> isGrantedPermission({required ph.Permission permission}) async {
    final updatePermission = await _permissionForceChange(permission);
    var isGranted = await updatePermission.isGranted;
    if (!isGranted) {
      return false;
    }
    return true;
  }

  // Android 13 (API level 33) 이상에서는 사진, 비디오, 오디오에 대한 별도의 권한이 필요합니다.
  // Android 12 (API level 32) 이하에서는 저장소 권한이 필요
  // https://github.com/Baseflow/flutter-permission-handler/issues/944#issuecomment-1291033783
  Future<ph.Permission> _permissionForceChange(ph.Permission permission) async {
    if (Platform.isAndroid && permission == ph.Permission.photos) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        /// use [Permissions.storage.status]
        return ph.Permission.storage;
      } else {
        /// use [Permissions.photos.status]
        return ph.Permission.photos;
      }
    }
    return permission;
  }
}
