# LeafDioRequestHeader

Static utility for building standard HTTP request headers with device OS, app version, authorization, and user agent. Includes pre-defined content-type header constants.

## API Reference

### Constants

| Constant | Value | Description |
|----------|-------|-------------|
| `leafContentTypeJsonHeader` | `{'content-type': 'application/json'}` | JSON content type header |
| `leafContentTypeMultipartHeader` | `{'content-type': 'multipart/form-data'}` | Multipart content type header |

### Typedefs

| Typedef | Signature | Description |
|---------|-----------|-------------|
| `LeafDioDeviceOSHeader` | `Map<String, String> Function(String os)` | Custom device OS header builder |
| `LeafDioVersionHeader` | `Map<String, String> Function(String version)` | Custom version header builder |
| `LeafDioAuthorizationHeader` | `Map<String, String> Function(String authorization)` | Custom authorization header builder |
| `LeafDioOnHeader` | `Future<Map<String, dynamic>> Function()` | Async header provider (defined in interceptor) |
| `LeafDioInterceptorBuilder` | `List<Interceptor>? Function(Dio dio)` | Custom interceptor factory (defined in client) |

### LeafDioRequestHeader

#### Static Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `getHeaders({...})` | `Map<String, dynamic>` | Build headers map |

#### getHeaders Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `appVersion` | `String` | Yes | - | App version string |
| `authorization` | `String?` | No | `null` | Authorization token |
| `userAgent` | `String?` | No | `null` | Custom user agent |
| `deviceOSHeader` | `LeafDioDeviceOSHeader?` | No | `null` | Override default `X-LEAF-DEVICE-OS` header |
| `versionHeader` | `LeafDioVersionHeader?` | No | `null` | Override default `X-LEAF-APP-VERSION` header |
| `authorizationHeader` | `LeafDioAuthorizationHeader?` | No | `null` | Override default `Authorization` header |

#### Default Headers

| Header | Value |
|--------|-------|
| `X-LEAF-DEVICE-OS` | Platform name in uppercase (e.g., `ANDROID`, `IOS`) |
| `X-LEAF-APP-VERSION` | Provided `appVersion` value |
| `Authorization` | Provided `authorization` value (if non-empty) |
| `User-Agent` | Provided `userAgent` value (if set) |

## Usage

### Basic Headers

```dart
final headers = LeafDioRequestHeader.getHeaders(
  appVersion: '1.2.0',
  authorization: 'Bearer eyJ...',
);
// {'X-LEAF-DEVICE-OS': 'IOS', 'X-LEAF-APP-VERSION': '1.2.0', 'Authorization': 'Bearer eyJ...'}
```

### Custom Header Keys

```dart
final headers = LeafDioRequestHeader.getHeaders(
  appVersion: '1.2.0',
  authorization: 'Bearer eyJ...',
  deviceOSHeader: (os) => {'X-Device-Platform': os},
  versionHeader: (version) => {'X-App-Version': version},
  authorizationHeader: (auth) => {'X-Auth-Token': auth},
);
```

### With LeafDioClient

```dart
LeafDioSharedClient.shared.init(
  baseUrl: Uri.parse('https://api.example.com'),
  responseSerializers: serializers,
  services: [MyService()],
  onHeader: () async => LeafDioRequestHeader.getHeaders(
    appVersion: AppInfo.version,
    authorization: await AuthStore.getToken(),
  ),
);
```
