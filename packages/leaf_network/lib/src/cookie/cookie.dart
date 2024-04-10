part of '../../leaf_network.dart';

class LFCookieStoreManager {
  static final LFCookieStoreManager _instance =
      LFCookieStoreManager._internal();

  static LFCookieStoreManager get shared => _instance;

  LFCookieStoreManager._internal();

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
    await LFSharedPreferencesManager.shared.setString('cookie', cookie);
  }

  Future<String?> getCookie() async {
    return LFSharedPreferencesManager.shared.getString('cookie');
  }

  Future<void> removeCookie() async {
    await LFSharedPreferencesManager.shared.remove('cookie');
  }

  Future<Map<String, String>> getHeader(dynamic uri) async {
    final cookie = await LFCookieStoreManager.shared.getCookie();
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
      await LFCookieStoreManager.shared.setCookie(cookie);
    }
  }
}
