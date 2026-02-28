# LeafDioServiceBase & LeafDioService

Abstract base class for Dio services and a concrete implementation with typed GET/POST/PUT/PATCH/DELETE methods that automatically convert responses and errors via BuiltValue converters.

## API Reference

### LeafDioServiceBase (abstract)

Base class that holds references injected by `LeafDioClient.init`.

| Property | Type | Description |
|----------|------|-------------|
| `dio` | `Dio` | Dio instance (set by client) |
| `converter` | `LeafDioBuiltValueConverter` | JSON response converter (set by client) |
| `errorConverter` | `LeafDioExceptionConverter` | Error converter (set by client) |

### LeafDioService (extends LeafDioServiceBase)

#### Methods

All methods return `Future<LeafDioResponse<R, E>>` and accept two type parameters: `R` (response type) and `E` (error body type).

| Method | Description |
|--------|-------------|
| `get<R, E>(path, {...})` | HTTP GET request |
| `post<R, E>(path, {...})` | HTTP POST request |
| `put<R, E>(path, {...})` | HTTP PUT request |
| `patch<R, E>(path, {...})` | HTTP PATCH request |
| `delete<R, E>(path, {...})` | HTTP DELETE request |

#### Common Parameters (all methods)

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `path` | `String` | Yes | - | Request path |
| `data` | `Object?` | No | `null` | Request body |
| `queryParameters` | `Map<String, dynamic>?` | No | `null` | Query parameters |
| `options` | `Options?` | No | `null` | Dio options |
| `cancelToken` | `CancelToken?` | No | `null` | Cancel token |
| `errorParser` | `LeafDioErrorParser?` | No | `null` | Custom error parser for status-code-specific error deserialization |

#### Additional Parameters

| Parameter | Available in | Type | Description |
|-----------|-------------|------|-------------|
| `onReceiveProgress` | GET, POST, PUT, PATCH | `ProgressCallback?` | Receive progress callback |
| `onSendProgress` | POST, PUT, PATCH | `ProgressCallback?` | Send progress callback |

#### Error Handling

- `DioException` is caught and converted via `errorConverter.convertDioException<R, E>(e, errorParser: errorParser)`
- If `errorParser` is provided, it is called first to parse the error body; returns `null` to fall back to generic `E` deserialization
- HTTP error status codes (400, 401, 404, etc.) are mapped to typed `LeafHttpException` subclasses
- Other exceptions are rethrown

## Usage

### Custom Service

```dart
class UserService extends LeafDioService {
  Future<LeafDioResponse<User>> getUser(int id) {
    return get<User, Null>('/users/$id');
  }

  Future<LeafDioResponse<User>> createUser(Map<String, dynamic> data) {
    return post<User, Null>('/users', data: data);
  }

  Future<LeafDioResponse<User>> updateUser(int id, Map<String, dynamic> data) {
    return put<User, Null>('/users/$id', data: data);
  }

  Future<LeafDioResponse<User>> patchUser(int id, Map<String, dynamic> data) {
    return patch<User, Null>('/users/$id', data: data);
  }

  Future<LeafDioResponse<void>> deleteUser(int id) {
    return delete<Null, Null>('/users/$id');
  }
}
```

### Using a Service

```dart
final userService = client.getService<UserService>();
final response = await userService.getUser(1);

if (response.isSuccessful) {
  final user = response.data;
} else {
  final error = response.httpException;
  print('Error: ${error?.message}');
}
```

### Custom Error Parsing

```dart
final response = await userService.post<User, Null>(
  '/users',
  data: userData,
  errorParser: (statusCode, body) {
    if (statusCode == 422 && body is Map) {
      return ValidationError.fromJson(body);
    }
    return null; // fallback to generic E deserialization
  },
);
```
