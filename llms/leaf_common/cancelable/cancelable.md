# LeafCancelableFuture

A lightweight wrapper that makes a `Future` completion callback cancellable. When cancelled, the `onComplete` callback is silently skipped even if the underlying Future resolves.

## API Reference

### LeafCancelableFuture\<T\>

#### Constructor Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `future` | `Future<dynamic>` | Yes | The future to observe |
| `onComplete` | `void Function(T)` | Yes | Callback invoked with the future's result, unless cancelled |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `cancel()` | `void` | Marks this wrapper as cancelled; the `onComplete` callback will not fire |

## Usage

### Basic — Cancel a Delayed Future

```dart
final cancellable = LeafCancelableFuture<String>(
  future: Future.delayed(Duration(seconds: 2), () => 'done'),
  onComplete: (value) => print(value),
);

// Cancel before the future completes
cancellable.cancel();
```

### Cancel on Widget Dispose

```dart
class _MyWidgetState extends State<MyWidget> {
  LeafCancelableFuture<int>? _pendingLoad;

  void _startLoad() {
    _pendingLoad = LeafCancelableFuture<int>(
      future: fetchData(),
      onComplete: (data) => setState(() => _data = data),
    );
  }

  @override
  void dispose() {
    _pendingLoad?.cancel();
    super.dispose();
  }
}
```
