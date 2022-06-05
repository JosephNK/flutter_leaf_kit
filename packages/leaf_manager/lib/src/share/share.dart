import 'package:share_plus/share_plus.dart';

class LeafShare {
  static Future<void> share(String link) async {
    await Share.share(link);
  }
}
