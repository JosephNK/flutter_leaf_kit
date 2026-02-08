import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LeafCookieStoreManager {
  static final LeafCookieStoreManager _instance =
      LeafCookieStoreManager._internal();

  static LeafCookieStoreManager get shared => _instance;

  LeafCookieStoreManager._internal();

  Map<String, String>? _header;

  // ignore: unnecessary_getters_setters
  Map<String, String>? get header {
    return _header;
  }

  // ignore: unnecessary_getters_setters
  set header(Map<String, String>? header) {
    _header = header;
  }

  Future<void> setCookie(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cookie', cookie);
  }

  Future<String?> getCookie() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cookie');
  }

  Future<void> removeCookie() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cookie');
  }

  Future<Map<String, String>> getHeader(dynamic uri) async {
    final cookie = await LeafCookieStoreManager.shared.getCookie();
    final header = <String, String>{};
    if (cookie != null) {
      header['cookie'] = cookie;
    }
    this.header = header;
    return header;
  }

  Future<void> setCookieByResponse(http.Response response) async {
    final rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      final index = rawCookie.indexOf(';');
      final cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      await LeafCookieStoreManager.shared.setCookie(cookie);
    }
  }
}
