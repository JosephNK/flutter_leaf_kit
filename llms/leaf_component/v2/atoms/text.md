# LeafText

A themed text widget that resolves styles from the Leaf design token system, with a built-in CJK underline workaround that renders underlines as bottom borders per character to avoid Flutter issue #42833 where underlines cut through CJK/Hangul glyphs.

## API Reference

### LeafText

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `text` | `String` | Yes | - | The text content to display (positional parameter) |
| `key` | `Key?` | No | `null` | Widget key |
| `style` | `TextStyle?` | No | `null` | Custom text style; falls back to `theme.typography.bodyMedium` |
| `textAlign` | `TextAlign?` | No | `TextAlign.left` | Text alignment |
| `color` | `Color?` | No | `null` | Text color override applied via `copyWith` |
| `maxLines` | `int?` | No | `null` | Maximum number of lines; enables overflow when set |
| `overflow` | `TextOverflow?` | No | `TextOverflow.ellipsis` | Overflow behavior when `maxLines` is set |
| `textScaleFactor` | `double` | No | `1.0` | Manual text scale factor |
| `textSize` | `LeafTextSize?` | No | `null` | Preset scale factor (`small`=0.8, `medium`=1.0, `large`=1.2); overrides `textScaleFactor` |
| `height` | `double?` | No | `null` | Line height multiplier applied via `copyWith` |
| `semanticsLabel` | `String?` | No | `null` | Accessibility label; defaults to `text` |

### LeafTextSize (Enum)

| Value | Scale Factor |
|-------|-------------|
| `small` | 0.8 |
| `medium` | 1.0 |
| `large` | 1.2 |

### Style Resolution
1. Explicit `style` parameter
2. `LeafThemeData.typography.bodyMedium` from the nearest `LeafTheme`
3. `DefaultTextStyle` from the widget tree

### CJK Underline Workaround
When the resolved style has `TextDecoration.underline`, LeafText automatically switches from `Text` to `RichText` with per-character `WidgetSpan`s. Each character is wrapped in a `DecoratedBox` with a bottom border, preventing the underline from cutting through CJK glyphs.

## Usage

### Basic
```dart
LeafText('Hello, World!')
```

### With Custom Style
```dart
LeafText(
  'Styled text',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  color: Colors.blue,
)
```

### With Text Size Preset
```dart
LeafText(
  'Large text',
  textSize: LeafTextSize.large,
)
```

### Multiline with Overflow
```dart
LeafText(
  'This is a very long text that should be truncated after two lines',
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

### CJK Underline
```dart
LeafText(
  '한글 밑줄 텍스트',
  style: TextStyle(decoration: TextDecoration.underline),
)
```

### With Accessibility
```dart
LeafText(
  'Price: \$9.99',
  semanticsLabel: 'Price is nine dollars and ninety-nine cents',
)
```
