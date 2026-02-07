# LeafBadge

A themed badge widget that displays a small label or icon, commonly used for notification counts or status indicators. Renders as a rounded pill shape with configurable elevation.

## API Reference

### LeafBadge

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `text` | `String?` | No | `null` | Badge label text |
| `icon` | `IconData?` | No | `null` | Badge icon; sized at 40% of `size` |
| `size` | `double?` | No | `null` | Minimum width and height of the badge |
| `textStyle` | `TextStyle?` | No | `null` | Custom text style for the label |
| `backgroundColor` | `Color?` | No | `null` | Badge background color |
| `iconColor` | `Color?` | No | `null` | Icon tint color |
| `padding` | `EdgeInsets?` | No | `null` | Internal padding |
| `elevation` | `double?` | No | `null` | Material elevation |

### Style Resolution
1. Widget parameter (e.g., `backgroundColor`)
2. Component theme (`theme.badgeTheme?.backgroundColor`)
3. Global token (`colors.error`)

| Property | Theme Key | Default |
|----------|-----------|---------|
| `size` | `badgeTheme?.size` | `18.0` |
| `backgroundColor` | `badgeTheme?.backgroundColor` | `colors.error` |
| `iconColor` | `badgeTheme?.iconColor` | `colors.onError` |
| `padding` | `badgeTheme?.padding` | `EdgeInsets.symmetric(horizontal: 3.0)` |
| `elevation` | `badgeTheme?.elevation` | `2.0` |
| `textStyle` | `badgeTheme?.textStyle` | `null` |

## Usage

### Text Badge
```dart
LeafBadge(text: '3')
```

### Icon Badge
```dart
LeafBadge(icon: Icons.notifications)
```

### Custom Styled Badge
```dart
LeafBadge(
  text: '99+',
  backgroundColor: Colors.red,
  textStyle: TextStyle(color: Colors.white, fontSize: 10),
  size: 24,
  elevation: 4.0,
)
```

### Badge with Theme
```dart
LeafTheme(
  data: LeafThemeData.light().copyWith(
    badgeTheme: LeafBadgeThemeData(
      backgroundColor: Colors.orange,
      size: 20,
      elevation: 0,
    ),
  ),
  child: LeafBadge(text: '5'),
)
```
