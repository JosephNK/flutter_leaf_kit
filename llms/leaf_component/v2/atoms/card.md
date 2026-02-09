# LeafCard

A themed card widget with variant styles (elevated, outlined, filled), optional header/footer slots, and built-in tap support. Integrates with the Leaf design token system for consistent styling.

## API Reference

### LeafCardVariant

| Value | Description |
|-------|-------------|
| `elevated` | Surface color with shadow elevation (default) |
| `outlined` | Border visible, no elevation |
| `filled` | SurfaceVariant background, no border or elevation |

### LeafCard

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key |
| `child` | `Widget` | Yes | - | Main card content |
| `header` | `Widget?` | No | `null` | Optional header slot (separated by divider) |
| `footer` | `Widget?` | No | `null` | Optional footer slot (separated by divider) |
| `variant` | `LeafCardVariant?` | No | `null` | Card style variant |
| `backgroundColor` | `Color?` | No | `null` | Card background color |
| `borderColor` | `Color?` | No | `null` | Border color |
| `borderWidth` | `double?` | No | `null` | Border width |
| `borderRadius` | `double?` | No | `null` | Corner radius |
| `padding` | `EdgeInsets?` | No | `null` | Internal padding |
| `margin` | `EdgeInsets?` | No | `null` | External margin |
| `elevation` | `double?` | No | `null` | Material elevation |
| `boxShadow` | `List<BoxShadow>?` | No | `null` | Custom shadow (overrides elevation) |
| `clipBehavior` | `Clip?` | No | `null` | Content clipping behavior |
| `onTap` | `VoidCallback?` | No | `null` | Tap callback (adds ink ripple) |
| `onLongPress` | `VoidCallback?` | No | `null` | Long press callback |
| `semanticLabel` | `String?` | No | `null` | Accessibility label |

### Style Resolution
1. Widget parameter (e.g., `backgroundColor`)
2. Component theme (`theme.cardTheme?.backgroundColor`)
3. Variant-based default token

| Property | Theme Key | Default (elevated) | Default (outlined) | Default (filled) |
|----------|-----------|-------------------|-------------------|------------------|
| `backgroundColor` | `cardTheme?.backgroundColor` | `colors.surface` | `colors.surface` | `colors.surfaceVariant` |
| `borderColor` | `cardTheme?.borderColor` | `transparent` | `colors.divider` | `transparent` |
| `borderWidth` | `cardTheme?.borderWidth` | `0.0` | `1.0` | `0.0` |
| `borderRadius` | `cardTheme?.borderRadius` | `radius.lg` | `radius.lg` | `radius.lg` |
| `elevation` | `cardTheme?.elevation` | `2.0` | `0.0` | `0.0` |
| `padding` | `cardTheme?.padding` | `EdgeInsets.all(16.0)` | `EdgeInsets.all(16.0)` | `EdgeInsets.all(16.0)` |
| `clipBehavior` | `cardTheme?.clipBehavior` | `Clip.antiAlias` | `Clip.antiAlias` | `Clip.antiAlias` |

## Usage

### Basic Card
```dart
LeafCard(child: Text('Hello'))
```

### Outlined Card with Header/Footer
```dart
LeafCard(
  variant: LeafCardVariant.outlined,
  header: Text('Title'),
  footer: LeafButton(text: 'Action', onTap: () {}),
  child: Text('Body content'),
)
```

### Tappable Elevated Card
```dart
LeafCard(
  elevation: 4.0,
  borderRadius: 16.0,
  onTap: () => navigateTo(...),
  child: ListTile(title: Text('Item')),
)
```

### Card with Theme
```dart
LeafTheme(
  data: LeafThemeData.light().copyWith(
    cardTheme: LeafCardThemeData(
      variant: LeafCardVariant.elevated,
      borderRadius: 12.0,
      padding: EdgeInsets.all(16),
    ),
  ),
  child: LeafCard(child: Text('Themed card')),
)
```
