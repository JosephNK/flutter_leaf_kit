# Dio Interceptors

Two Dio interceptors: `LeafDioCurlInterceptor` for debug cURL logging and `LeafDioRequestInterceptor` for dynamic header injection and request body sanitization.

## API Reference

### LeafDioCurlInterceptor (extends InterceptorsWrapper)

Logs every request as a cURL command for debugging. Runs on both response and error.

#### Overridden Methods

| Method | Description |
|--------|-------------|
| `onResponse(response, handler)` | Log cURL and pass response through |
| `onError(err, handler)` | Log cURL and pass error through |

#### cURL Output Includes

- HTTP method
- Headers (excluding `Cookie`)
- Request body (JSON-encoded; FormData fields and files)
- Full request URI

### LeafDioRequestInterceptor (extends InterceptorsWrapper)

Injects dynamic headers and sanitizes request data (removes null/empty values).

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `onHeader` | `LeafDioOnHeader?` | No | `null` | Async header provider callback |

#### Typedef

| Typedef | Signature | Description |
|---------|-----------|-------------|
| `LeafDioOnHeader` | `Future<Map<String, dynamic>> Function()` | Returns headers to merge into every request |

#### Overridden Methods

| Method | Description |
|--------|-------------|
| `onRequest(options, handler)` | Merge headers, sanitize query params and body |

#### Request Sanitization

- Query parameters: null/empty values removed via `removeNullEmptyValue()`
- `FormData` body: fields with empty strings removed, files regrouped
- `Map<String, dynamic>` body: null/empty values removed

### LeafDioRequestInterceptorHelper (Extension)

Private helper extension on `LeafDioRequestInterceptor` for transforming `FormData` fields and files.

## Usage

### Auto-configured (via LeafDioClient)

Both interceptors are added automatically by `LeafDioClient.init`:

```dart
final client = LeafDioClient().init(
  baseUrl: Uri.parse('https://api.example.com'),
  responseSerializers: serializers,
  services: [MyService()],
  onHeader: () async => {
    'Authorization': 'Bearer $token',
  },
);
```

### Custom Interceptors

```dart
final client = LeafDioClient().init(
  baseUrl: Uri.parse('https://api.example.com'),
  responseSerializers: serializers,
  services: [MyService()],
  interceptorBuilder: (dio) => [
    LogInterceptor(),
    RetryInterceptor(dio: dio),
  ],
);
```
