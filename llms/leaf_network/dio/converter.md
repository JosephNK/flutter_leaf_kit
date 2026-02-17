# Dio Converters

BuiltValue-based JSON response converter and DioException error converter. These convert raw Dio responses into typed `LeafDioResponse<T>` objects using BuiltValue serialization.

## API Reference

### Typedefs

| Typedef | Signature | Description |
|---------|-----------|-------------|
| `LeafDioErrorParser` | `Object? Function(int statusCode, dynamic body)` | Custom error parser for status-code-specific deserialization; return `null` to fall back to generic `E` deserialization |

### Abstract Interfaces

#### LeafDioJsonConverter

| Method | Return Type | Description |
|--------|-------------|-------------|
| `convertJsonResponse<ResultType, ResultErrorType>(Response)` | `FutureOr<LeafDioResponse<ResultType>>` | Convert successful JSON response |

#### LeafDioExceptionConverterBase

| Method | Return Type | Description |
|--------|-------------|-------------|
| `convertDioException<ResultType, ResultErrorType>(DioException, {LeafDioErrorParser? errorParser})` | `FutureOr<LeafDioResponse<ResultType>>` | Convert Dio exception to response |

### Helper Function

| Function | Return Type | Description |
|----------|-------------|-------------|
| `getPrintBodyFromResponse(jsonData, response, {printMaxLength})` | `dynamic` | Pretty-print JSON body for logging, truncated at `printMaxLength` (default 2024) |

### LeafDioBuiltValueConverter (implements LeafDioJsonConverter)

Deserializes JSON response bodies into BuiltValue types with support for undefined key mapping.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `serializers` | `Serializers` | Yes | - | BuiltValue serializers |
| `printMaxLength` | `int` | No | `2024` | Max log body length |
| `jsonUndefinedKey` | `LeafDioJsonUndefinedKey?` | No | `null` | Key mapping config for non-standard JSON |

#### Static Properties

| Property | Type | Description |
|----------|------|-------------|
| `jsonSerializers` | `Serializers?` | Serializers with `StandardJsonPlugin` applied |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `convertJsonResponse<R, E>(Response)` | `FutureOr<LeafDioResponse<R>>` | Deserialize response via BuiltValue |
| `convertSuccess<R, E>(Response)` | `FutureOr<LeafDioResponse<R>>` | Internal success conversion with logging |

### LeafDioExceptionConverter (implements LeafDioExceptionConverterBase)

Converts `DioException` into typed `LeafDioResponse` with appropriate `LeafHttpException` subclass.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `serializers` | `Serializers` | Yes | - | BuiltValue serializers |
| `printMaxLength` | `int` | No | `2024` | Max log body length |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `convertDioException<R, E>(DioException, {LeafDioErrorParser? errorParser})` | `FutureOr<LeafDioResponse<R>>` | Route to `convertError` (with response) or `convertException` (without) |
| `convertError<R, E>(Response, {LeafDioErrorParser? errorParser})` | `FutureOr<LeafDioResponse<R>>` | Convert HTTP error response (400/401/404/408/500/503) |
| `convertException<R, E>(DioException)` | `FutureOr<LeafDioResponse<R>>` | Convert Dio-level exception (timeout, cancel, connection error) |

#### DioExceptionType Mapping

| DioExceptionType | LeafHttpException | Status Code |
|------------------|-------------------|-------------|
| `connectionTimeout` | `LeafConnectionTimeoutException` | -99990 |
| `sendTimeout` | `LeafSendTimeoutException` | -99991 |
| `receiveTimeout` | `LeafReceiveTimeoutException` | -99992 |
| `badCertificate` | `LeafBadCertificateException` | -99993 |
| `badResponse` | `LeafBadResponseException` | -99994 |
| `cancel` | `LeafCancelException` | -99995 |
| `connectionError` | `LeafConnectionErrorException` | -99996 |
| `unknown` | `LeafUnknownException` | -99999 |

### LeafDioJsonUndefinedKey

Configuration for wrapping non-standard JSON shapes before BuiltValue deserialization.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `collectionKey` | `String?` | No | `null` | Key to wrap top-level arrays (e.g., `[{...}]` becomes `{"key": [...]}`) |
| `objectKey` | `String?` | No | `null` | Key to wrap single values or objects |
| `excludeStructs` | `List<Map<String, dynamic>>?` | No | `null` | Map structures that should not be wrapped |

## Usage

### Standard Setup (via LeafDioClient)

Converters are automatically created and injected by `LeafDioClient.init`. Direct usage is rarely needed.

```dart
final client = LeafDioClient().init(
  baseUrl: Uri.parse('https://api.example.com'),
  responseSerializers: serializers,
  services: [MyService()],
);
```

### Undefined Key Mapping

```dart
final client = LeafDioClient().init(
  baseUrl: Uri.parse('https://api.example.com'),
  responseSerializers: serializers,
  services: [MyService()],
  jsonUndefinedKey: LeafDioJsonUndefinedKey(
    collectionKey: 'items',
    objectKey: 'data',
    excludeStructs: [{'data': null, 'meta': null}],
  ),
);
```
