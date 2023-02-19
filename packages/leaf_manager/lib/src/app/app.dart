import 'package:leaf_common/leaf_common.dart';

class LFAppManager {
  LFAppManager();

  String? get expiredDate => null; // '2021-06-04'

  int get imageQuality => 100;
  int get imageSaveAlbumQuality => 100;

  Duration get delayedDuration => const Duration(milliseconds: 100);

  // ExpireDate 체크 함수
  bool isExpire() {
    if (isEmpty(expiredDate)) {
      return false;
    }
    final now = DateTime.now();
    return now.isAfter(DateTime.parse(expiredDate!));
  }
}
