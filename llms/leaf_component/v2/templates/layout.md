# Layout Template

A root-level layout widget that waits for non-zero layout constraints before building the main content. Displays a loading indicator until the layout is ready, and optionally renders a build-flavour banner.

## API Reference

### LeafLayoutApp

Uses `LayoutBuilder` and `OrientationBuilder` to detect when layout constraints become available (non-zero `maxWidth`). Shows a `LeafIndicator` as a loading placeholder until ready. Uses `LeafTheme` for theming.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `child` | `Widget` | Yes | -- | The main content widget displayed once constraints are available |
| `buildName` | `String` | No | `''` | Build flavour label (e.g. `"DEV"`, `"STAGING"`). When non-empty, a `Banner` is rendered at the top-start corner |
| `backgroundColor` | `Color?` | No | `null` | Background color for the layout container. Falls back to `LeafColors.background` |
| `onSetupDevice` | `LeafLayoutAppOnSetupDevice?` | No | `null` | Optional device setup callback. Receives `onBuilder` so the host can perform platform-specific initialization before signalling readiness |
| `onBuilder` | `VoidCallback` | Yes | -- | Called once the layout is ready (non-zero constraints detected) |

#### Style Resolution Order

1. Explicit `backgroundColor` parameter
2. `LeafThemeData.colors.background`

### LeafLayoutAppOnSetupDevice

```dart
typedef LeafLayoutAppOnSetupDevice = void Function(VoidCallback onBuilder);
```

A callback invoked when the layout constraints are available. The host should call `onBuilder` to signal that the app is ready to display content.

## Usage

### Basic Layout

```dart
LeafLayoutApp(
  onBuilder: () {
    // Layout is ready, perform post-layout setup
    debugPrint('Layout ready');
  },
  child: MaterialApp(
    home: HomeScreen(),
  ),
);
```

### Layout with Device Setup

```dart
LeafLayoutApp(
  onSetupDevice: (onBuilder) {
    // Perform platform-specific initialization
    initializePlatformServices().then((_) {
      onBuilder(); // Signal readiness
    });
  },
  onBuilder: () {
    debugPrint('App fully initialized');
  },
  child: MaterialApp(
    home: HomeScreen(),
  ),
);
```

### Layout with Build Flavour Banner

```dart
LeafLayoutApp(
  buildName: 'DEV',
  backgroundColor: Colors.white,
  onBuilder: () {
    // Ready
  },
  child: MaterialApp(
    home: HomeScreen(),
  ),
);
```

### Full App Root Example

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LeafTheme(
      data: LeafThemeData.light(),
      child: LeafLayoutApp(
        buildName: kDebugMode ? 'DEBUG' : '',
        onSetupDevice: (onBuilder) async {
          await Firebase.initializeApp();
          onBuilder();
        },
        onBuilder: () {
          // All initialization complete
        },
        child: MaterialApp(
          title: 'My App',
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
```
