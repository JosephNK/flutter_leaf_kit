import 'package:shared_preferences/shared_preferences.dart';

class LeafSharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }
}
