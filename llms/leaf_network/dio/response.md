# LeafDioResponse\<T\>

Typed response wrapper extending Dio's `Response<T>` with success checking, error tracking, and exception access. Returned by all `LeafDioService` HTTP methods.

## API Reference

### LeafDioResponse\<T\> (extends Response\<T\>)

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

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `error` | `Object?` | Deserialized error body (mutable) |
| `exception` | `LeafHttpExceptionObject?` | Wrapped exception object (mutable) |
| `isSuccessful` | `bool` | `true` when status 200-399, no error, and no exception |
| `httpException` | `LeafHttpException?` | Convenience getter for `exception?.exception` |

#### toString Output

Produces structured debug output including status code, data (JSON-encoded for maps/lists, truncated for long strings), data type, URI, and method.

## Usage

### Check Response

```dart
final response = await service.get<User, Null>('/users/1');

if (response.isSuccessful) {
  final user = response.data!;
  print('User: ${user.name}');
} else {
  final exception = response.httpException;
  print('Error ${exception?.statusCode}: ${exception?.message}');
}
```

### Access Error Body

```dart
final response = await service.post<User, ErrorBody>('/users', data: body);

if (!response.isSuccessful) {
  final errorBody = response.error as ErrorBody?;
  print('Validation errors: ${errorBody?.errors}');
}
```
