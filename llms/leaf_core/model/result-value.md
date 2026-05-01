# LeafResultValue, LeafErrorValue & LeafErrorValueException

Result/error pattern for wrapping API responses and propagating errors through the UI layer. Supports chained error display methods that check `context.mounted` before showing errors.

## API Reference

### Typedefs

| Typedef | Signature |
|---------|-----------|
| `LeafResultValueOnError` | `Future<void> Function(BuildContext, String?, Object?)` |
| `LeafResultValueOnErrorMessage` | `Future<void> Function(BuildContext, String)` |
| `LeafResultValueOnException` | `Future<void> Function(BuildContext, Object?)` |
| `LeafResultValueOnErrorValue` | `Future<void> Function(BuildContext, LeafErrorValue)` |
| `LeafErrorValueOnWait` | `Future<void> Function(BuildContext, LeafErrorValue)` |

### LeafResultValue\<T\> (extends Equatable)

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `errorValue` | `LeafErrorValue?` | No | `null` | Error information |
| `data` | `T?` | No | `null` | Success data |
| `option` | `Object?` | No | `null` | Additional metadata |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `empty` | `bool` | `true` when all fields are null |

#### Factory Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `LeafResultValue.fromValue({errorValue, data, option})` | `LeafResultValue<T>` | Create with all fields |
| `LeafResultValue.fromSuccess(data, {option})` | `LeafResultValue<T>` | Create success result |
| `LeafResultValue.fromError(data, {errorValue, option})` | `LeafResultValue<T>` | Create error result |
| `LeafResultValue.fromEmpty()` | `LeafResultValue<T>` | Create empty result |

#### Chained Error Display Methods

All return `Future<LeafResultValue<T>>` for chaining. Each checks `context.mounted` before invoking the callback.

| Method | Callback Type | Description |
|--------|---------------|-------------|
| `showIfExistError(context, {onError})` | `LeafResultValueOnError` | Show error with message + exception |
| `showIfExistErrorMessage(context, {onErrorMessage})` | `LeafResultValueOnErrorMessage` | Show error message only |
| `showIfExistExceptionMessage(context, {onException})` | `LeafResultValueOnException` | Show exception only |

#### Static Helper

| Method | Description |
|--------|-------------|
| `waitForShowErrorValues(context, errorValues, {onErrorValue, sync})` | Process multiple error values sequentially |

#### copyWith (Extension)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith({errorValue, data, option})` | `LeafResultValue<T>` | Returns a copy with replaced fields |

### LeafErrorValue (extends Equatable)

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `statusCode` | `int` | Yes | - | HTTP or custom status code |
| `errorCode` | `String?` | No | `null` | Application error code |
| `errorMessage` | `String?` | No | `null` | Human-readable error message |
| `exception` | `Object?` | No | `null` | Original exception |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `displayErrorMessage` | `String` | Error message or empty string |
| `displayErrorMessageWithErrorCode` | `String` | Error message with error code appended |
| `objectToException` | `LeafErrorValueException` | Wraps this value as a throwable exception |

#### Factory Constructors

| Factory | Description |
|---------|-------------|
| `LeafErrorValue.empty()` | Empty error with default status code (`-9999`) |
| `LeafErrorValue.fromException({exception, errorCode})` | Create from exception object |
| `LeafErrorValue.fromErrorMessage(message, {errorCode})` | Create from error message string |

#### Static Helpers

| Method | Description |
|--------|-------------|
| `getFirstErrorValues(List<LeafErrorValue?>)` | First non-null error value |
| `getLastErrorValues(List<LeafErrorValue?>)` | Last non-null error value |
| `waitForErrorValues(context, {errorValues, onWait})` | Iterate error values with async callback |

#### copyWith (Extension)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith({statusCode, errorCode, errorMessage, exception})` | `LeafErrorValue` | Returns a copy with replaced fields |

### LeafErrorValueException (implements Exception)

| Property | Type | Description |
|----------|------|-------------|
| `value` | `LeafErrorValue` | The wrapped error value |

#### Constants

| Constant | Value | Description |
|----------|-------|-------------|
| `kDefaultStatusCode` | `-9999` | Default status code for non-HTTP errors |

## Usage

### Success Result

```dart
final result = LeafResultValue.fromSuccess<User>(user);
```

### Error Result

```dart
final result = LeafResultValue.fromError<User>(
  null,
  errorValue: LeafErrorValue(
    statusCode: 404,
    errorMessage: 'User not found',
  ),
);
```

### Chained Error Display

```dart
final result = await fetchUser();
await result.showIfExistErrorMessage(
  context,
  onErrorMessage: (ctx, message) async {
    showSnackBar(ctx, message);
  },
);
```

### Error Value from Exception

```dart
try {
  await apiCall();
} catch (e) {
  final errorValue = LeafErrorValue.fromException(exception: e);
  return LeafResultValue.fromError(null, errorValue: errorValue);
}
```

### Batch Error Processing

```dart
await LeafResultValue.waitForShowErrorValues(
  context,
  [result1.errorValue, result2.errorValue],
  onErrorValue: (ctx, errorValue) async {
    showDialog(ctx, errorValue.displayErrorMessage);
  },
  sync: true,
);
```
