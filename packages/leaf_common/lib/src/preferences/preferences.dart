part of lf_common;

class LFSharedPreferences {
  static final LFSharedPreferences _instance = LFSharedPreferences._internal();

  static LFSharedPreferences get shared => _instance;

  LFSharedPreferences._internal();

  Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  /// Set
  ///
  Future<bool> setString(
    String key,
    String value,
  ) async {
    final prefs = await getInstance();
    return await prefs.setString(key, value);
  }

  Future<bool> setBool(
    String key,
    bool value,
  ) async {
    final prefs = await getInstance();
    return await prefs.setBool(key, value);
  }

  Future<bool> setInt(
    String key,
    int value,
  ) async {
    final prefs = await getInstance();
    return await prefs.setInt(key, value);
  }

  Future<bool> setDouble(
    String key,
    double value,
  ) async {
    final prefs = await getInstance();
    return await prefs.setDouble(key, value);
  }

  /// Get
  ///
  Future<String?> getString(String key) async {
    final prefs = await getInstance();
    return prefs.getString(key);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await getInstance();
    return prefs.getBool(key);
  }

  Future<int?> getInt(String key) async {
    final prefs = await getInstance();
    return prefs.getInt(key);
  }

  Future<double?> getDouble(String key) async {
    final prefs = await getInstance();
    return prefs.getDouble(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await getInstance();
    return prefs.remove(key);
  }
}
