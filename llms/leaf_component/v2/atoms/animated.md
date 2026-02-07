# Animated Widgets

A collection of animation widgets with a shared controller system. Each widget wraps a Flutter transition widget and supports both automatic (auto-play, repeat) and manual (value-driven) animation modes.

## Controller System

### LeafAnimationController (Base)

All animation controllers extend this base class.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `autoAnimation` | `bool` | `false` | Auto-start animation on init |
| `repeatCount` | `int` | `-1` | Number of repeats; `-1` means infinite when repeating |
| `duration` | `Duration` | `Duration(milliseconds: 250)` | Animation duration |

#### Methods
| Method | Description |
|--------|-------------|
| `forward({double? from})` | Play forward |
| `reverse({double? from})` | Play in reverse |
| `repeat()` | Start repeating; stops after `repeatCount * duration` if not `-1` |
| `stop()` | Stop animation |

#### LeafAnimationStatus (Enum)
| Value | Description |
|-------|-------------|
| `forward` | Playing forward |
| `stop` | Stopped |
| `reverse` | Playing in reverse |
| `repeat` | Repeating |

### Specialized Controllers

| Controller | Extra Parameters | Description |
|------------|-----------------|-------------|
| `LeafRotateAnimationController` | `degree` (`double`, default `pi`) | Rotation target in radians |
| `LeafFadeAnimationController` | `isDisappear` (`bool`, default `false`) | `false`: fade in (0 to 1), `true`: fade out (1 to 0) |
| `LeafExpandAnimationController` | None | Expand/collapse |
| `LeafBouncingAnimationController` | None | Bounce (scale 1.0 to 1.2) |
| `LeafScaleAnimationController` | None | Scale (0.0 to 1.0) |

---

## API Reference

### LeafBouncingAnimated

Animates scale from 1.0 to 1.2 with an elastic curve. Good for attention-drawing effects.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `child` | `Widget` | Yes | - | Widget to animate |
| `controller` | `LeafBouncingAnimationController?` | No | `null` | External controller |
| `value` | `bool?` | No | `null` | Toggle trigger; changes trigger animation |
| `duration` | `Duration` | No | `Duration(milliseconds: 250)` | Animation duration |
| `curve` | `Curve` | No | `Curves.elasticIn` | Animation curve |
| `enableInitAnimation` | `bool` | No | `true` | Animate on initial build |
| `onAnimationStatus` | `ValueChanged<AnimationStatus>?` | No | `null` | Status listener |

---

### LeafExpandAnimated

Vertical expand/collapse animation using `SizeTransition`.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `child` | `Widget` | Yes | - | Widget to animate |
| `controller` | `LeafExpandAnimationController?` | No | `null` | External controller |
| `value` | `bool?` | No | `null` | `true` expands, `false` collapses |
| `duration` | `Duration?` | No | `null` | Animation duration (default 250ms) |
| `onAnimationStatus` | `ValueChanged<AnimationStatus>?` | No | `null` | Status listener |

---

### LeafFadeAnimated

Fade (opacity) animation. Direction controlled by controller's `isDisappear` flag.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `child` | `Widget` | Yes | - | Widget to animate |
| `controller` | `LeafFadeAnimationController?` | No | `null` | External controller |
| `value` | `bool?` | No | `null` | `true` plays forward, `false` plays reverse |
| `duration` | `Duration?` | No | `null` | Animation duration (default 250ms) |
| `onAnimationStatus` | `ValueChanged<AnimationStatus>?` | No | `null` | Status listener |

---

### LeafFlipAnimated

A 3D card-flip animation toggling between `front` and `rear` widgets on tap. Uses perspective rotation with `Matrix4.rotationY`.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `front` | `Widget` | Yes | - | Front-face widget |
| `rear` | `Widget` | Yes | - | Back-face widget |
| `showFrontSide` | `bool` | No | `true` | Initial face to show |
| `onChanged` | `ValueChanged<bool>?` | No | `null` | Callback with new `showFrontSide` value |

Note: Flip animation duration is fixed at 800ms with `Curves.easeInBack`.

---

### LeafRotateAnimated

Rotation animation from 0 to a configurable degree (default `pi` radians = 180 degrees).

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `child` | `Widget` | Yes | - | Widget to animate |
| `controller` | `LeafRotateAnimationController?` | No | `null` | External controller (configure `degree` here) |
| `value` | `bool?` | No | `null` | `true` plays forward, `false` plays reverse |
| `duration` | `Duration?` | No | `null` | Animation duration (default 250ms) |
| `onAnimationStatus` | `ValueChanged<AnimationStatus>?` | No | `null` | Status listener |

---

### LeafScaleAnimated

Scale animation from 0.0 to 1.0 with `Curves.easeInOutBack`.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `child` | `Widget` | Yes | - | Widget to animate |
| `controller` | `LeafScaleAnimationController?` | No | `null` | External controller |
| `value` | `bool?` | No | `null` | `true` plays forward, `false` plays reverse |
| `duration` | `Duration?` | No | `null` | Animation duration (default 250ms) |
| `onAnimationStatus` | `ValueChanged<AnimationStatus>?` | No | `null` | Status listener |

---

## Animation Modes

### Manual Mode (default)
Driven by the `value` parameter. When `value` changes, the animation plays forward or reverse.

### Auto Mode
Set `autoAnimation: true` on the controller. The animation starts immediately on widget init.
- If `repeatCount == -1`: runs `forward()` once then stops
- If `repeatCount > 0`: runs `repeat()` for the specified count

## Usage

### Bouncing (Manual)
```dart
LeafBouncingAnimated(
  value: isBouncing,
  child: Icon(Icons.favorite, size: 48),
)
```

### Expand/Collapse
```dart
LeafExpandAnimated(
  value: isExpanded,
  duration: Duration(milliseconds: 300),
  child: Container(
    height: 200,
    color: Colors.blue.shade100,
    child: Text('Expandable content'),
  ),
)
```

### Fade In
```dart
LeafFadeAnimated(
  value: isVisible,
  child: Text('Fading text'),
)
```

### Fade Out (Disappear)
```dart
final controller = LeafFadeAnimationController(
  isDisappear: true,
  autoAnimation: true,
  duration: Duration(milliseconds: 500),
);

LeafFadeAnimated(
  controller: controller,
  child: Text('Disappearing...'),
)
```

### Card Flip
```dart
LeafFlipAnimated(
  front: Container(
    color: Colors.blue,
    child: Center(child: Text('Front')),
  ),
  rear: Container(
    color: Colors.red,
    child: Center(child: Text('Back')),
  ),
  showFrontSide: showFront,
  onChanged: (isFront) => setState(() => showFront = isFront),
)
```

### Rotate with Custom Degree
```dart
final controller = LeafRotateAnimationController(
  degree: 2 * pi, // full 360-degree rotation
  autoAnimation: true,
  repeatCount: 3,
  duration: Duration(seconds: 1),
);

LeafRotateAnimated(
  controller: controller,
  child: Icon(Icons.refresh, size: 32),
)
```

### Scale Entrance
```dart
LeafScaleAnimated(
  value: isShown,
  duration: Duration(milliseconds: 400),
  child: Card(child: Text('Scaled content')),
  onAnimationStatus: (status) {
    if (status == AnimationStatus.completed) {
      // animation finished
    }
  },
)
```

### Auto-Repeating Bounce
```dart
final controller = LeafBouncingAnimationController(
  autoAnimation: true,
  repeatCount: 5,
  duration: Duration(milliseconds: 600),
);

LeafBouncingAnimated(
  controller: controller,
  child: Icon(Icons.notifications, size: 32),
)
```
