import 'package:flutter/foundation.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class LFPermissionManager {
  static final LFPermissionManager _instance = LFPermissionManager._internal();
  static LFPermissionManager get shared => _instance;
  LFPermissionManager._internal();

  // isGranted 안전 하게 퍼미션 체크 후
  // 퍼미션 없을 경우, request 요청!
  Future<bool> requestSafePermissionStatus({
    required ph.Permission permission,
    required ValueChanged<ph.PermissionStatus> onNotPermission,
  }) async {
    final isGranted = await isGrantedPermission(
      permission: permission,
    );
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
    ph.PermissionStatus status = ph.PermissionStatus.denied;
    try {
      status = await permission.request();
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
  Future<bool> isGrantedPermission({
    required ph.Permission permission,
  }) async {
    var isGranted = await permission.isGranted;
    if (!isGranted) {
      return false;
    }
    return true;
  }
}
