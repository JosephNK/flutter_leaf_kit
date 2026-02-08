# LeafHttpException

Base exception class for HTTP error handling. Provides 16 typed subclasses mapped to HTTP status codes and Dio exception types, plus a wrapper object and a helper function.

## API Reference

### LeafHttpException (implements Exception)

#### Constructor Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `statusCode` | `int` | Yes | HTTP status code or custom error code |
| `message` | `String` | Yes | Human-readable error message |
| `value` | `dynamic` | Yes | Response body or additional data |

### HTTP Status Subclasses

All subclasses share the same constructor signature as `LeafHttpException(statusCode, message, value)`.

| Class | HTTP Status | Description |
|-------|-------------|-------------|
| `LeafBadRequestException` | 400 | Bad request |
| `LeafUnauthorisedException` | 401 | Unauthorized |
| `LeafNotFoundException` | 404 | Not found |
| `LeafTimeoutRequestException` | 408 | Request timeout |
| `LeafInternalServerException` | 500 | Internal server error |
| `LeafServiceUnavailableException` | 503 | Service unavailable |

### Network / Client Subclasses

| Class | Description |
|-------|-------------|
| `LeafInternetNotConnectException` | Internet connection unavailable |
| `LeafImageVolumeMaxException` | Image file size exceeded |
| `LeafConnectionTimeoutException` | Dio connection timeout |
| `LeafSendTimeoutException` | Dio send timeout |
| `LeafReceiveTimeoutException` | Dio receive timeout |
| `LeafBadCertificateException` | Dio bad certificate |
| `LeafBadResponseException` | Dio bad response |
| `LeafCancelException` | Dio request cancelled |
| `LeafConnectionErrorException` | Dio connection error |
| `LeafUnknownException` | Unknown or unclassified error |

### LeafHttpExceptionObject

Wrapper that holds a `LeafHttpException` and provides formatted `toString()` output including runtime type info.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `exception` | `LeafHttpException` | Yes | The wrapped exception |

### Helper Function

| Function | Return Type | Description |
|----------|-------------|-------------|
| `isLeafHttpException(Object? e)` | `bool` | Returns `true` if the object is one of the 8 primary HTTP exception types |

## Usage

### Catching Typed Exceptions

```dart
try {
  final response = await service.get<User, Null>('/users/1');
  if (!response.isSuccessful) {
    final exception = response.httpException;
    if (exception is LeafUnauthorisedException) {
      // Handle 401 - redirect to login
    } else if (exception is LeafNotFoundException) {
      // Handle 404
    }
  }
} catch (e) {
  if (isLeafHttpException(e)) {
    final httpError = e as LeafHttpException;
    print('Status: ${httpError.statusCode}, Message: ${httpError.message}');
  }
}
```

### Wrapping with ExceptionObject

```dart
final exception = LeafBadRequestException(400, 'Invalid input', responseBody);
final wrapped = LeafHttpExceptionObject(exception);
print(wrapped); // prints runtimeType + exception details
```
