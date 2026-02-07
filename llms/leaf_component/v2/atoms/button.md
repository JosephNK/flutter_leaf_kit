# LeafButton

A themed button widget that resolves colors from the Leaf design token system. Features built-in loading state management, tap lock (debounce) via `LeafLockGestureDetector`, optional leading widget, and ink-well feedback.

## API Reference

### LeafButton

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `text` | `String` | Yes | - | Button label text |
| `textStyle` | `TextStyle?` | No | `null` | Custom text style; its color is overridden by `foregroundColor` |
| `textAlign` | `TextAlign?` | No | `TextAlign.center` | Text alignment |
| `leading` | `Widget?` | No | `null` | Widget placed before the text label |
| `leadingSpacing` | `double?` | No | `null` | Gap between leading widget and text |
| `duration` | `Duration` | No | `Duration(milliseconds: 250)` | Lock duration after tap to prevent double-taps |
| `forceLock` | `bool` | No | `false` | When `true`, keeps the button locked until externally released |
| `loading` | `bool` | No | `false` | Whether the button is in loading state |
| `showLoading` | `bool` | No | `true` | Whether to show a loading indicator when `loading` is `true` |
| `disabled` | `bool` | No | `false` | Disables the button (prevents taps) |
| `backgroundColor` | `Color?` | No | `null` | Button background color |
| `foregroundColor` | `Color?` | No | `null` | Text/icon color |
| `decoration` | `BoxDecoration?` | No | `null` | Custom box decoration; overrides `backgroundColor` |
| `margin` | `EdgeInsets?` | No | `null` | Outer margin |
| `padding` | `EdgeInsets?` | No | `EdgeInsets.all(10.0)` | Inner padding |
| `enabledInkWell` | `bool` | No | `true` | Enable ink splash effect on tap |
| `onLoaderBuilder` | `LeafLockGestureDetectorOnLoaderBuilder?` | No | `null` | Custom loading widget builder: `Widget Function()` |
| `onTap` | `VoidCallback?` | No | `null` | Tap callback |

### Style Resolution
1. Widget parameter (e.g., `backgroundColor`)
2. Component theme (`theme.buttonTheme?.backgroundColor`)
3. Global token (`colors.primary`)

| Property | Theme Key | Default |
|----------|-----------|---------|
| `foregroundColor` | `buttonTheme?.foregroundColor` | `colors.onPrimary` |
| `backgroundColor` | `buttonTheme?.backgroundColor` | `colors.primary` |
| `leadingSpacing` | `buttonTheme?.leadingSpacing` | `8.0` |
| `padding` | `buttonTheme?.padding` | Constructor default |

### Constraints
The button enforces a minimum hit target of 48x48 logical pixels via `ConstrainedBox`.

## Usage

### Basic
```dart
LeafButton(
  text: 'Submit',
  onTap: () => handleSubmit(),
)
```

### With Leading Icon
```dart
LeafButton(
  text: 'Download',
  leading: Icon(Icons.download, color: Colors.white),
  leadingSpacing: 12,
  onTap: () => startDownload(),
)
```

### Loading State
```dart
LeafButton(
  text: 'Saving...',
  loading: isLoading,
  showLoading: true,
  onTap: () => save(),
)
```

### Disabled Button
```dart
LeafButton(
  text: 'Unavailable',
  disabled: true,
  onTap: () {},
)
```

### Custom Decoration
```dart
LeafButton(
  text: 'Outlined',
  decoration: BoxDecoration(
    border: Border.all(color: Colors.blue),
    borderRadius: BorderRadius.circular(8),
  ),
  foregroundColor: Colors.blue,
  onTap: () {},
)
```

### Force Lock (Manual Release)
```dart
LeafButton(
  text: 'Process',
  forceLock: isProcessing,
  onTap: () => startLongProcess(),
)
```
