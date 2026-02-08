# LeafMessageException

A simple `Exception` implementation that carries a human-readable error message string. The `toString()` method returns the message directly, making it suitable for display in UI error handlers.

## API Reference

### LeafMessageException

#### Constructor Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `message` | `String` | Yes | The error message |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `message` | `String` | The error message |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `toString()` | `String` | Returns the `message` string |

## Usage

### Throwing an Exception

```dart
throw LeafMessageException('User not found');
```

### Catching and Displaying

```dart
try {
  await fetchUser(id);
} on LeafMessageException catch (e) {
  showSnackBar(e.message);
}
```
