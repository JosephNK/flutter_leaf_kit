# LeafWidgetSize

A utility widget that measures its child's size and global position, reporting changes through a callback. Uses a custom `RenderProxyBox` to detect layout changes after each frame via a post-frame callback. This widget does not use the Leaf theme system.

## API Reference

### LeafWidgetSize

Extends `SingleChildRenderObjectWidget`.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `onChange` | `LeafOnWidgetSizeChange` | Yes | - | Callback fired when child's position or size changes |
| `child` | `Widget` | Yes | - | The widget to measure |

### LeafOnWidgetSizeChange (Typedef)

```dart
typedef LeafOnWidgetSizeChange = void Function(Offset position, Size size);
```

- `position`: The child's global position (`localToGlobal(Offset.zero)`)
- `size`: The child's rendered size

### LeafWidgetRenderObject

Internal `RenderProxyBox` implementation. Tracks previous size and position to avoid redundant callbacks -- `onChange` is only called when either value actually changes.

### Behavior
- Measurement happens in `performLayout()` via `addPostFrameCallback`
- The callback fires after the frame is painted, ensuring accurate global coordinates
- Changes are debounced: no callback if both position and size are identical to previous values

## Usage

### Measure Widget Size
```dart
LeafWidgetSize(
  onChange: (position, size) {
    print('Position: $position, Size: $size');
  },
  child: Container(
    width: 200,
    height: 100,
    color: Colors.blue,
    child: Text('Measure me'),
  ),
)
```

### Track Dynamic Size Changes
```dart
Size? _childSize;

LeafWidgetSize(
  onChange: (position, size) {
    setState(() => _childSize = size);
  },
  child: AnimatedContainer(
    duration: Duration(milliseconds: 300),
    width: isExpanded ? 300 : 150,
    height: isExpanded ? 200 : 100,
    color: Colors.green,
  ),
)

// Use _childSize elsewhere in your layout
if (_childSize != null)
  Text('Child is ${_childSize!.width} x ${_childSize!.height}')
```

### Position-Aware Overlay
```dart
Offset? _targetPosition;
Size? _targetSize;

LeafWidgetSize(
  onChange: (position, size) {
    setState(() {
      _targetPosition = position;
      _targetSize = size;
    });
  },
  child: ElevatedButton(
    onPressed: showOverlay,
    child: Text('Show tooltip'),
  ),
)
```
