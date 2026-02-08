# LeafCookieStoreManager

Singleton manager for persisting and retrieving cookies via `SharedPreferences`. Extracts `set-cookie` from HTTP responses and attaches stored cookies to outgoing requests.

## API Reference

### LeafCookieStoreManager (Singleton)

#### Access

| Property | Type | Description |
|----------|------|-------------|
| `LeafCookieStoreManager.shared` | `LeafCookieStoreManager` | Singleton instance |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `header` | `Map<String, String>?` | Last built header map (get/set) |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `setCookie(String cookie)` | `Future<void>` | Persist cookie string to SharedPreferences |
| `getCookie()` | `Future<String?>` | Retrieve stored cookie string |
| `removeCookie()` | `Future<void>` | Remove stored cookie |
| `getHeader(dynamic uri)` | `Future<Map<String, String>>` | Build header map with stored cookie |
| `setCookieByResponse(http.Response response)` | `Future<void>` | Extract and store cookie from `set-cookie` header |

## Usage

### Store Cookie from Response

```dart
final response = await http.get(Uri.parse('https://api.example.com/login'));
await LeafCookieStoreManager.shared.setCookieByResponse(response);
```

### Attach Cookie to Request

```dart
final headers = await LeafCookieStoreManager.shared.getHeader(uri);
final response = await http.get(uri, headers: headers);
```

### Clear Cookie on Logout

```dart
await LeafCookieStoreManager.shared.removeCookie();
```
