# Shared Utilities

Internal utility widgets used by other Leaf components. Provides a Material ripple InkWell wrapper and a gesture detector with tap-lock debouncing.

## API Reference

### LeafInkWell

A simple ink-well wrapper that provides a Material ripple effect with optional decoration and padding. Uses `Material(type: MaterialType.transparency)` to ensure the ripple works on any background.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `child` | `Widget` | Yes | -- | The content widget |
| `padding` | `EdgeInsets?` | No | `EdgeInsets.zero` | Padding applied inside the ink area |
| `decoration` | `BoxDecoration?` | No | `null` | Decoration applied to the outer container |
| `width` | `double?` | No | `null` | Fixed width for the ink area |
| `height` | `double?` | No | `null` | Fixed height for the ink area |
| `disabled` | `bool` | No | `false` | When `true`, the `onTap` callback is not fired |
| `borderRadius` | `BorderRadius?` | No | `null` | Border radius for the ripple effect clipping |
| `onTap` | `VoidCallback?` | No | `null` | Callback fired when the widget is tapped |

### LeafLockGestureDetector

A gesture detector that locks taps for a brief duration to prevent accidental double taps (debouncing). Supports loading, disabled, and force-lock states. Optionally wraps the child in `LeafInkWell` for Material ripple.

When tapped, the detector starts an internal lock timer. During the lock period, subsequent taps are ignored. If the child is a `Stack`, the detector preserves its `Positioned` children and `clipBehavior`.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `child` | `Widget` | Yes | -- | The content widget |
| `duration` | `Duration` | No | `Duration(milliseconds: 250)` | Lock duration after a tap before the next tap is accepted |
| `forceLock` | `bool` | No | `false` | When `true`, taps are permanently locked regardless of timer |
| `loading` | `bool` | No | `false` | External loading state; shows a loading indicator overlay |
| `showLoading` | `bool` | No | `true` | Whether to visually show the loading indicator |
| `disabled` | `bool` | No | `false` | When `true`, taps are ignored |
| `decoration` | `BoxDecoration?` | No | `null` | Decoration applied to the container |
| `margin` | `EdgeInsets?` | No | `null` | Margin around the container |
| `padding` | `EdgeInsets?` | No | `null` | Padding inside the container |
| `enabledInkWell` | `bool` | No | `true` | When `true`, wraps in `LeafInkWell` for Material ripple; when `false`, uses plain `GestureDetector` |
| `onLoaderBuilder` | `LeafLockGestureDetectorOnLoaderBuilder?` | No | `null` | Custom loading indicator builder. Default shows a 20x20 `CircularProgressIndicator` |
| `onTap` | `VoidCallback?` | No | `null` | Callback fired when the widget is tapped (and not locked/disabled) |

### LeafLockGestureDetectorOnLoaderBuilder

```dart
typedef LeafLockGestureDetectorOnLoaderBuilder = Widget Function();
```

Builder for a custom loading indicator within `LeafLockGestureDetector`.

#### State Behavior

| State | Tap Behavior |
|-------|-------------|
| Normal | Tap fires `onTap`, then locks for `duration` |
| Locked (timer active) | Taps are ignored until the timer expires |
| `forceLock = true` | All taps are permanently ignored |
| `loading = true` | Loading indicator overlay is shown (if `showLoading` is true) |
| `disabled = true` | All taps are ignored; InkWell is disabled |
| `onTap = null` | No gesture handling is attached |

## Usage

### Basic InkWell

```dart
LeafInkWell(
  onTap: () {
    // Handle tap with ripple effect
  },
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Tap me'),
  ),
);
```

### InkWell with Decoration

```dart
LeafInkWell(
  decoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(8),
  ),
  borderRadius: BorderRadius.circular(8),
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  onTap: () {
    // Handle tap
  },
  child: const Text('Styled button'),
);
```

### Disabled InkWell

```dart
LeafInkWell(
  disabled: true,
  onTap: () {
    // This will not be called
  },
  child: const Text('Disabled'),
);
```

### Basic Lock Gesture Detector

```dart
LeafLockGestureDetector(
  onTap: () {
    // Safe from accidental double-taps
    submitForm();
  },
  child: const Text('Submit'),
);
```

### Lock Gesture with Custom Duration

```dart
LeafLockGestureDetector(
  duration: const Duration(milliseconds: 500),
  onTap: () {
    navigateToDetail();
  },
  child: const ListTile(
    title: Text('Item'),
    trailing: Icon(Icons.chevron_right),
  ),
);
```

### Lock Gesture with Loading State

```dart
LeafLockGestureDetector(
  loading: isSubmitting,
  showLoading: true,
  onTap: () async {
    setState(() => isSubmitting = true);
    await submitData();
    setState(() => isSubmitting = false);
  },
  child: const Text('Save'),
);
```

### Lock Gesture with Custom Loader

```dart
LeafLockGestureDetector(
  loading: isLoading,
  onLoaderBuilder: () => const SizedBox(
    width: 16,
    height: 16,
    child: CircularProgressIndicator(
      strokeWidth: 1.5,
      color: Colors.white,
    ),
  ),
  onTap: () {
    performAction();
  },
  child: const Text('Action'),
);
```

### Lock Gesture without InkWell

```dart
LeafLockGestureDetector(
  enabledInkWell: false, // Uses plain GestureDetector
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
  ),
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.symmetric(horizontal: 24),
  onTap: () {
    doSomething();
  },
  child: const Text('No ripple'),
);
```

### Force-Locked Gesture

```dart
LeafLockGestureDetector(
  forceLock: isProcessing, // Permanently locks taps while true
  onTap: () {
    startProcess();
  },
  child: const Text('Process'),
);
```
