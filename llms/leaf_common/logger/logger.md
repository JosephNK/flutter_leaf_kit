# LeafLogging, LeafLoggingManager & PlatformConsoleOutput

Static logging facade backed by the `logger` package. Provides debug, info, warning, and error log levels with platform-aware console output (uses `developer.log` on iOS debug, `debugPrint` elsewhere).

## API Reference

### LeafLogging (Static Methods)

| Method | Parameters | Description |
|--------|------------|-------------|
| `LeafLogging.d()` | `dynamic message` | Debug log |
| `LeafLogging.i()` | `dynamic message` | Info log |
| `LeafLogging.w()` | `dynamic message` | Warning log |
| `LeafLogging.e()` | `dynamic message` | Error log |
| `LeafLogging.printLong()` | `dynamic message` | Prints long strings in 800-char chunks (debug mode only) |

### LeafLoggingManager (Singleton)

| Property / Method | Type | Description |
|-------------------|------|-------------|
| `LeafLoggingManager.shared` | `LeafLoggingManager` | Singleton instance |
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

### Basic Usage

```dart
LeafLogging.d('Debug message');
LeafLogging.i('Info message');
LeafLogging.w('Warning message');
LeafLogging.e('Error occurred');
```

### Long String Output

```dart
LeafLogging.printLong(jsonEncode(largeResponse));
```

### Custom Logger Configuration

```dart
LeafLoggingManager.shared.setup(
  PrettyPrinter(
    methodCount: 2,
    lineLength: 80,
    colors: true,
  ),
);
```
