# LeafSwitch

A themed toggle switch widget that adapts to the platform, rendering a `CupertinoSwitch` on Apple platforms (iOS/macOS) and a Material `Switch` on others. Uses context-based platform detection for web compatibility.

## API Reference

### LeafSwitch

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `value` | `bool` | Yes | - | Current on/off state |
| `activeTrackColor` | `Color?` | No | `null` | Track color when switch is on |
| `inactiveTrackColor` | `Color?` | No | `null` | Track color when switch is off |
| `thumbColor` | `Color?` | No | `null` | Thumb (circle) color |
| `onChanged` | `ValueChanged<bool>?` | No | `null` | Callback with the new toggle state |

### Style Resolution
1. Widget parameter (e.g., `activeTrackColor`)
2. Component theme (`theme.switchTheme?.activeTrackColor`)
3. Global token (`colors.primary`)

| Property | Theme Key | Default |
|----------|-----------|---------|
| `activeTrackColor` | `switchTheme?.activeTrackColor` | `colors.primary` |
| `inactiveTrackColor` | `switchTheme?.inactiveTrackColor` | `colors.inactive` |
| `thumbColor` | `switchTheme?.thumbColor` | `null` (platform default) |

### Platform Adaptation
| Platform | Widget Used | Notes |
|----------|-------------|-------|
| iOS, macOS | `CupertinoSwitch` | `applyTheme: false` |
| Android, others | Material `Switch` | Disabled state uses 50% alpha on inactive track; track outline width set to 0 |

Platform is detected via `Theme.of(context).platform` instead of `dart:io` for web safety.

## Usage

### Basic
```dart
LeafSwitch(
  value: isEnabled,
  onChanged: (newValue) => setState(() => isEnabled = newValue),
)
```

### Custom Colors
```dart
LeafSwitch(
  value: isDarkMode,
  activeTrackColor: Colors.green,
  inactiveTrackColor: Colors.grey.shade300,
  thumbColor: Colors.white,
  onChanged: (value) => setState(() => isDarkMode = value),
)
```

### Read-Only Switch
```dart
LeafSwitch(
  value: isActive,
  onChanged: null, // disables interaction
)
```
