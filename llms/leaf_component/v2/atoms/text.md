# LeafText

A themed text widget that resolves styles from the Leaf design token system, with a built-in CJK underline workaround that renders underlines as bottom borders per character to avoid Flutter issue #42833 where underlines cut through CJK/Hangul glyphs. Supports both plain text and mixed-style rich text via `LeafText.rich`.

## API Reference

### LeafText (default constructor)

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

### LeafText.rich (named constructor)

Creates a themed text widget with an `InlineSpan` tree for mixed-style text. Uses `Text.rich` internally to preserve `DefaultTextStyle` inheritance.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `textSpan` | `InlineSpan` | Yes | - | The span tree to display (positional parameter) |
| `key` | `Key?` | No | `null` | Widget key |
| `style` | `TextStyle?` | No | `null` | Default style applied to the span tree; falls back to `theme.typography.bodyMedium` |
| `textAlign` | `TextAlign?` | No | `TextAlign.left` | Text alignment |
| `color` | `Color?` | No | `null` | Text color override applied via `copyWith` |
| `maxLines` | `int?` | No | `null` | Maximum number of lines; enables overflow when set |
| `overflow` | `TextOverflow?` | No | `TextOverflow.ellipsis` | Overflow behavior when `maxLines` is set |
| `textScaleFactor` | `double` | No | `1.0` | Manual text scale factor |
| `textSize` | `LeafTextSize?` | No | `null` | Preset scale factor; overrides `textScaleFactor` |
| `height` | `double?` | No | `null` | Line height multiplier applied via `copyWith` |
| `semanticsLabel` | `String?` | No | `null` | Accessibility label; defaults to extracted plain text from span tree |

#### Properties
| Property | Type | Description |
|----------|------|-------------|
| `text` | `String?` | Plain text (non-null for default constructor, null for `.rich`) |
| `textSpan` | `InlineSpan?` | Span tree (non-null for `.rich`, null for default constructor) |

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
When the resolved style has `TextDecoration.underline`, the default constructor automatically switches from `Text` to `RichText` with per-character `WidgetSpan`s. Each character is wrapped in a `DecoratedBox` with a bottom border, preventing the underline from cutting through CJK glyphs.

Note: The CJK underline workaround applies only to the default constructor. `LeafText.rich` delegates to `Text.rich` directly.

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

### Rich Text (Mixed Styles)
```dart
LeafText.rich(
  TextSpan(
    text: 'Hello ',
    children: [
      TextSpan(
        text: 'Flutter',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      TextSpan(text: '에 오신 걸 환영합니다!'),
    ],
  ),
)
```

### Rich Text with Inline Widget
```dart
LeafText.rich(
  TextSpan(
    text: '별점 ',
    children: [
      WidgetSpan(child: Icon(Icons.star, size: 16)),
      TextSpan(text: ' 4.5'),
    ],
  ),
  style: TextStyle(fontSize: 16),
)
```
