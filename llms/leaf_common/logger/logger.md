# Logging, LoggingManager & PlatformConsoleOutput

Static logging facade backed by the `logger` package. Provides debug, info, warning, and error log levels with platform-aware console output (uses `developer.log` on iOS debug, `debugPrint` elsewhere).

## API Reference

### Logging (Static Methods)

| Method | Parameters | Description |
|--------|------------|-------------|
| `Logging.d()` | `dynamic message` | Debug log |
| `Logging.i()` | `dynamic message` | Info log |
| `Logging.w()` | `dynamic message` | Warning log |
| `Logging.e()` | `dynamic message` | Error log |
| `Logging.printLong()` | `dynamic message` | Prints long strings in 800-char chunks (debug mode only) |

### LoggingManager (Singleton)

| Property / Method | Type | Description |
|-------------------|------|-------------|
| `LoggingManager.shared` | `LoggingManager` | Singleton instance |
| `logger` | `Logger?` | Current logger instance |
| `setup(PrettyPrinter prettyPrinter)` | `void` | Reconfigure the logger with a custom printer |

Default configuration:
- `methodCount`: 0
- `errorMethodCount`: 8
- `lineLength`: 120
- `colors`: enabled on Android only
- `printEmojis`: true
- `dateTimeFormat`: none

### PlatformConsoleOutput (extends LogOutput)

| Method | Description |
|--------|-------------|
| `output(OutputEvent event)` | Routes to `developer.log` on iOS debug, `debugPrint` elsewhere |

## Usage

### Basic Logging

```dart
Logging.d('Debug message');
Logging.i('Info message');
Logging.w('Warning message');
Logging.e('Error occurred');
```

### Long String Output

```dart
Logging.printLong(jsonEncode(largeResponse));
```

### Custom Logger Configuration

```dart
LoggingManager.shared.setup(
  PrettyPrinter(
    methodCount: 2,
    lineLength: 80,
    colors: true,
  ),
);
```
