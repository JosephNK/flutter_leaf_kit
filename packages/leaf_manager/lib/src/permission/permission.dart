import 'package:flutter/foundation.dart';
import 'package:leaf_common/leaf_common.dart';
import 'package:permission_handler/permission_handler.dart';

class LFPermission {
  // isGranted 안전하게 퍼미션 체크 후
  // 퍼미션이 없을 경우, request 요청!
  static Future<bool> requestSafePermissionStatus({
    required Permission permission,
    required ValueChanged<PermissionStatus> onNotPermission,
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
  static Future<bool> requestPermissionStatus({
    required Permission permission,
    required ValueChanged<PermissionStatus> onNotPermission,
  }) async {
    PermissionStatus status = PermissionStatus.denied;
    try {
      status = await permission.request();
    } catch (e) {
      Logging.e('[RequestPermission] e => $e');
    }
    if (status != PermissionStatus.granted) {
      onNotPermission.call(status);
      return false;
    }
    return true;
  }

  // 상태만 체크하는 함수이기에
  // didChangeAppLifecycleState 함수 호출 하지 않음.
  static Future<bool> isGrantedPermission({
    required Permission permission,
  }) async {
    var isGranted = await permission.isGranted;
    if (!isGranted) {
      return false;
    }
    return true;
  }
}
