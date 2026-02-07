# PopScope Template

A widget that intercepts the Android back button to confirm app exit with a double-press pattern. On non-Android platforms the child is returned without modification.

## API Reference

### LeafPopScopeAppClose

On Android, the first back press fires `onBackPressed` (e.g. to show a "press again to exit" snackbar). A second press within `duration` invokes `SystemNavigator.pop()` to close the app. On non-Android platforms the child is returned as-is.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `child` | `Widget` | Yes | -- | The content below this scope |
| `onBackPressed` | `LeafPopScopeCallback?` | No | `null` | Called on the first back-press so the host can show a confirmation UI (e.g. snackbar) |
| `duration` | `Duration` | No | `Duration(milliseconds: 4000)` | Window in which a second back-press triggers app exit |
| `onWillPop` | `VoidCallback?` | No | `null` | Optional callback fired together with `onBackPressed` |

### LeafPopScopeCallback

```dart
typedef LeafPopScopeCallback = Future<void> Function();
```

Callback invoked before the app-close timer begins.

#### Platform Behavior

| Platform | Behavior |
|----------|----------|
| Android | Intercepts back button with double-press-to-exit pattern |
| iOS / macOS / Others | `child` is returned directly without any `PopScope` wrapping |

#### Internal Logic

1. First back press: records the timestamp, calls `onBackPressed` and `onWillPop`.
2. Second back press within `duration`: calls `SystemNavigator.pop()` to exit the app.
3. If `ModalRoute.willHandlePopInternally` is `true`, the system navigator pop is invoked immediately (the route handles its own pop).

## Usage

### Basic Double-Press Exit

```dart
LeafPopScopeAppClose(
  onBackPressed: () async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Press back again to exit'),
        duration: Duration(seconds: 2),
      ),
    );
  },
  child: Scaffold(
    body: const Center(child: Text('Main content')),
  ),
);
```

### Custom Exit Duration

```dart
LeafPopScopeAppClose(
  duration: const Duration(seconds: 2),
  onBackPressed: () async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tap back once more to exit'),
        duration: Duration(seconds: 2),
      ),
    );
  },
  child: const HomeScreen(),
);
```

### With Additional onWillPop Callback

```dart
LeafPopScopeAppClose(
  onBackPressed: () async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Press back again to exit')),
    );
  },
  onWillPop: () {
    // Additional logic on first back press
    analyticsService.logBackPressed();
  },
  child: const HomeScreen(),
);
```

### Wrapping the Entire App

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return LeafPopScopeAppClose(
            onBackPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Press back again to exit'),
                ),
              );
            },
            child: const HomeScreen(),
          );
        },
      ),
    );
  }
}
```
