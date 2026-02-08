# LeafTypeConverter

Safe dynamic-to-typed value converter. Handles conversion between `String`, `int`, `double`, `bool`, `num`, and `List` types with graceful `null` return on failure.

## API Reference

### LeafTypeConverter

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `convertTo<T>(dynamic value)` | `T?` | Converts `value` to type `T`, returns `null` on failure |

#### Supported Conversions

| Target Type | Source Types | Notes |
|-------------|-------------|-------|
| `String` | Any | Uses `toString()` |
| `int` | `int`, `double`, `String`, `bool` | `double` truncates, `bool` maps to 0/1 |
| `double` | `double`, `int`, `String`, `bool` | `bool` maps to 0.0/1.0 |
| `bool` | `bool`, `int`, `double`, `String` | String accepts `'true'`, `'1'`, `'yes'` (case-insensitive) |
| `num` | `num`, `String`, `bool` | Detects int vs double from decimal point |
| `List` | `List`, any single value | Single value wrapped in list |

## Usage

### Basic Conversion

```dart
final converter = LeafTypeConverter();

converter.convertTo<int>('42');       // 42
converter.convertTo<double>(10);      // 10.0
converter.convertTo<bool>('true');    // true
converter.convertTo<String>(123);     // '123'
```

### Safe Null Handling

```dart
converter.convertTo<int>(null);        // null
converter.convertTo<int>('not a num'); // null
```

### Bool from Various Sources

```dart
converter.convertTo<bool>(1);       // true
converter.convertTo<bool>(0);       // false
converter.convertTo<bool>('yes');   // true
converter.convertTo<bool>('YES');   // true
```
