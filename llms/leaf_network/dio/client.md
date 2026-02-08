# LeafDioClient & LeafDioSharedClient

Dio HTTP client wrapper that configures converters, interceptors, and a typed service registry. `LeafDioSharedClient` provides a singleton wrapper around `LeafDioClient` for app-wide access.

## API Reference

### Typedef

| Typedef | Signature | Description |
|---------|-----------|-------------|
| `LeafDioInterceptorBuilder` | `List<Interceptor>? Function(Dio dio)` | Custom interceptor factory |

### LeafDioClient

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `dio` | `Dio` | Underlying Dio instance |
| `converter` | `LeafDioBuiltValueConverter` | JSON response converter |
| `errorConverter` | `LeafDioExceptionConverter` | Error response converter |
| `services` | `Map<Type, LeafDioServiceBase>` | Registered service map |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `init(...)` | `LeafDioClient` | Configure and return the client (see init parameters below) |
| `getService<ServiceType>()` | `ServiceType` | Retrieve a registered service by type |
| `getTemporarySavePath(fileName)` | `Future<String>` | Build temp directory path for file operations |
| `isExistFile({fileName})` | `Future<File?>` | Check if file exists in temp directory |
| `saveFile({fileName})` | `Future<File?>` | Get file from temp directory if it exists |
| `download(urlPath, {fileName, ...})` | `Future<Response?>` | Download file to temp directory |
| `resizeDownloadImage(uri, {targetWidth, targetHeight})` | `Future<Uint8List?>` | Download and resize image |
| `createCancelToken()` | `CancelToken` | Static factory for Dio cancel tokens |

#### init Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `baseUrl` | `Uri` | Yes | - | API base URL |
| `responseSerializers` | `Serializers` | Yes | - | BuiltValue serializers for response deserialization |
| `services` | `List<LeafDioServiceBase>` | Yes | - | Services to register |
| `interceptorBuilder` | `LeafDioInterceptorBuilder?` | No | `null` | Additional interceptors |
| `jsonUndefinedKey` | `LeafDioJsonUndefinedKey?` | No | `null` | JSON key mapping config |
| `connectTimeout` | `Duration` | No | `5 seconds` | Connection timeout |
| `receiveTimeout` | `Duration` | No | `60 seconds` | Receive timeout |
| `printMaxLength` | `int` | No | `2024` | Max length for debug log body |
| `onHeader` | `LeafDioOnHeader?` | No | `null` | Dynamic header provider |
| `getTemporaryDirectoryPath` | `Future<String> Function()?` | No | `null` | Temp directory path provider for file operations |

#### download Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `urlPath` | `String` | Yes | - | Download URL path |
| `fileName` | `String` | Yes | - | File name for saving |
| `onReceiveProgress` | `ProgressCallback?` | No | `null` | Download progress callback |
| `queryParameters` | `Map<String, dynamic>?` | No | `null` | Query parameters |
| `cancelToken` | `CancelToken?` | No | `null` | Cancel token |
| `deleteOnError` | `bool` | No | `true` | Delete incomplete file on error |
| `lengthHeader` | `String` | No | `Headers.contentLengthHeader` | Header for content length |
| `data` | `Object?` | No | `null` | Request body |
| `options` | `Options?` | No | `null` | Dio options |

### LeafDioSharedClient (Singleton)

#### Access

| Property | Type | Description |
|----------|------|-------------|
| `LeafDioSharedClient.shared` | `LeafDioSharedClient` | Singleton instance |
| `dioClient` | `LeafDioClient` | Underlying client |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `init(...)` | `void` | Initialize with same parameters as `LeafDioClient.init` |
| `getService<ServiceType>()` | `ServiceType` | Proxy to `dioClient.getService<ServiceType>()` |

## Usage

### Direct Client Setup

```dart
final client = LeafDioClient().init(
  baseUrl: Uri.parse('https://api.example.com'),
  responseSerializers: serializers,
  services: [UserService(), AuthService()],
  onHeader: () async => LeafDioRequestHeader.getHeaders(
    appVersion: '1.0.0',
    authorization: token,
  ),
);

final userService = client.getService<UserService>();
```

### Singleton Setup

```dart
LeafDioSharedClient.shared.init(
  baseUrl: Uri.parse('https://api.example.com'),
  responseSerializers: serializers,
  services: [UserService(), AuthService()],
);

final userService = LeafDioSharedClient.shared.getService<UserService>();
```

### File Download

```dart
final response = await client.download(
  '/files/report.pdf',
  fileName: 'report.pdf',
  onReceiveProgress: (received, total) {
    print('${(received / total * 100).toStringAsFixed(0)}%');
  },
);
```

### Image Resize Download

```dart
final bytes = await client.resizeDownloadImage(
  Uri.parse('https://cdn.example.com/image.png'),
  targetWidth: 200,
  targetHeight: 200,
);
```
