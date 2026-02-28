# LeafDioResponse\<T, E\>

Typed response wrapper extending Dio's `Response<T>` with error type parameter `E`, success checking, error tracking, and exception access. Returned by all `LeafDioService` HTTP methods.

## API Reference

### LeafErrorObject (extends Object)

Wrapper that holds an error body object.

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `value` | `Object?` | No | `null` | The wrapped error value |

### LeafDioResponse\<T, E\> (extends Response\<T\>)

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `data` | `T?` | No | `null` | Deserialized response body |
| `requestOptions` | `RequestOptions` | Yes | - | Original request options |
| `statusCode` | `int?` | No | `null` | HTTP status code |
| `statusMessage` | `String?` | No | `null` | HTTP status message |
| `isRedirect` | `bool` | No | `false` | Whether the response was a redirect |
| `redirects` | `List<RedirectRecord>` | No | `[]` | Redirect history |
| `extra` | `Map<String, dynamic>` | No | `{}` | Extra metadata |
| `headers` | `Headers?` | No | `null` | Response headers |

#### Setters

| Setter | Type | Description |
|--------|------|-------------|
| `error` | `LeafErrorObject?` | Set the error object (internal storage) |
| `exception` | `LeafHttpExceptionObject?` | Set the exception object (internal storage) |

#### Getters

| Property | Type | Description |
|----------|------|-------------|
| `isSuccessful` | `bool` | `true` when status 200-399, no error, and no exception |
| `error` | `E?` | Deserialized error body, cast to type `E` |
| `isHttpUnauthorisedException` | `bool` | `true` when `httpException` is `LeafUnauthorisedException` |
| `httpException` | `LeafHttpException?` | Convenience getter for `_exception?.httpException` |

#### toString Output

Produces structured debug output including status code, data (JSON-encoded for maps/lists, truncated for long strings), data type, URI, and method.

## Usage

### Check Response

```dart
final response = await service.get<User, ErrorBody>('/users/1');

if (response.isSuccessful) {
  final user = response.data!;
  print('User: ${user.name}');
} else {
  final exception = response.httpException;
  print('Error ${exception?.statusCode}: ${exception?.message}');
}
```

### Access Typed Error Body

```dart
final response = await service.post<User, ErrorBody>('/users', data: body);

if (!response.isSuccessful) {
  final errorBody = response.error; // ErrorBody? (typed as E)
  print('Validation errors: ${errorBody?.errors}');
}
```

### Check 401 Unauthorized

```dart
final response = await service.get<User, Null>('/profile');

if (response.isHttpUnauthorisedException) {
  // Redirect to login
}
```
