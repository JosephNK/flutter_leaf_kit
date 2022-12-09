import 'package:http/http.dart' as http;

import '../preferences/preferences.dart';

class CookieStoreManager {
  static final CookieStoreManager _instance = CookieStoreManager._internal();

  static CookieStoreManager get shared => _instance;

  CookieStoreManager._internal();

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
    await LeafSharedPreferences.setString('cookie', cookie);
  }

  Future<String?> getCookie() async {
    return LeafSharedPreferences.getString('cookie');
  }

  Future<void> removeCookie() async {
    await LeafSharedPreferences.remove('cookie');
  }

  Future<Map<String, String>> getHeader(dynamic uri) async {
    final cookie = await CookieStoreManager.shared.getCookie();
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
      await CookieStoreManager.shared.setCookie(cookie);
    }
  }
}
