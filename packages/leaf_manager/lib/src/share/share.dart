import 'package:share_plus/share_plus.dart';

class LFShareManager {
  static final LFShareManager _instance = LFShareManager._internal();

  static LFShareManager get shared => _instance;

  LFShareManager._internal();

  Future<void> share(String link) async {
    await Share.share(link);
  }
}
