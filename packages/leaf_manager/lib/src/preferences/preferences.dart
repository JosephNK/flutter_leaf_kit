import 'package:shared_preferences/shared_preferences.dart';

class LeafSharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  /// Set
  ///
  static Future<bool> setString(
    String key,
    String value,
  ) async {
    final prefs = await getInstance();
    return await prefs.setString(key, value);
  }

  static Future<bool> setBool(
    String key,
    bool value,
  ) async {
    final prefs = await getInstance();
    return await prefs.setBool(key, value);
  }

  static Future<bool> setInt(
    String key,
    int value,
  ) async {
    final prefs = await getInstance();
    return await prefs.setInt(key, value);
  }

  static Future<bool> setDouble(
    String key,
    double value,
  ) async {
    final prefs = await getInstance();
    return await prefs.setDouble(key, value);
  }

  /// Get
  ///
  static Future<String?> getString(String key) async {
    final prefs = await getInstance();
    return prefs.getString(key);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await getInstance();
    return prefs.getBool(key);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await getInstance();
    return prefs.getInt(key);
  }

  static Future<double?> getDouble(String key) async {
    final prefs = await getInstance();
    return prefs.getDouble(key);
  }

  static Future<bool> remove(String key) async {
    final prefs = await getInstance();
    return prefs.remove(key);
  }
}
