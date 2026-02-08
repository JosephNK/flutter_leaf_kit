# LeafHttpOverrides

Global `HttpOverrides` that limits the maximum number of concurrent connections per host to 5. Apply at app startup to control connection pooling.

## API Reference

### LeafHttpOverrides (extends HttpOverrides)

#### Overridden Methods

| Method | Description |
|--------|-------------|
| `createHttpClient(SecurityContext? context)` | Returns an `HttpClient` with `maxConnectionsPerHost = 5` |

## Usage

```dart
void main() {
  HttpOverrides.global = LeafHttpOverrides();
  runApp(MyApp());
}
```
