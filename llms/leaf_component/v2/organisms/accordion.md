# LeafAccordion

A generic, themed accordion widget that displays a list of expandable/collapsible tiles. Supports both single-expand and multi-expand modes with smooth animations. Uses the Leaf design token system for styling.

## API Reference

### LeafAccordionItem\<T\>

An immutable data model for accordion items.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `title` | `String` | Yes | - | Header title text |
| `data` | `T` | Yes | - | Generic data payload for the item |
| `subtitle` | `String?` | No | `null` | Optional subtitle text below the title |

### LeafAccordion\<T\>

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `items` | `List<LeafAccordionItem<T>>` | Yes | - | List of accordion items to display |
| `itemBuilder` | `Widget Function(BuildContext, int, T)` | Yes | - | Builder for expanded content |
| `expandedIndex` | `int?` | No | `null` | Currently expanded index (single mode) |
| `expandedIndices` | `Set<int>?` | No | `null` | Currently expanded indices (multi mode) |
| `allowMultiple` | `bool` | No | `false` | Allow multiple items expanded simultaneously |
| `onExpansionChanged` | `ValueChanged<int>?` | No | `null` | Callback when an item is toggled |
| `headerBackgroundColor` | `Color?` | No | `null` | Header background color |
| `contentBackgroundColor` | `Color?` | No | `null` | Expanded content background color |
| `dividerColor` | `Color?` | No | `null` | Divider line color |
| `iconColor` | `Color?` | No | `null` | Arrow icon color |
| `headerPadding` | `EdgeInsets?` | No | `null` | Header area padding |
| `contentPadding` | `EdgeInsets?` | No | `null` | Content area padding |
| `expandDuration` | `Duration?` | No | `null` | Animation duration for expand/collapse |

### LeafAccordionTile

A single expandable tile with animated expand/collapse. Used internally by `LeafAccordion`.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `title` | `String` | Yes | - | Header title text |
| `child` | `Widget` | Yes | - | Content widget shown when expanded |
| `subtitle` | `String?` | No | `null` | Optional subtitle below the title |
| `expanded` | `bool` | No | `false` | Whether the tile is expanded |
| `onExpansionChanged` | `ValueChanged<bool>?` | No | `null` | Expansion toggle callback |
| `headerBackgroundColor` | `Color?` | No | `null` | Header background color |
| `contentBackgroundColor` | `Color?` | No | `null` | Content background color |
| `dividerColor` | `Color?` | No | `null` | Divider color |
| `iconColor` | `Color?` | No | `null` | Arrow icon color |
| `headerPadding` | `EdgeInsets?` | No | `null` | Header padding |
| `contentPadding` | `EdgeInsets?` | No | `null` | Content padding |
| `expandDuration` | `Duration?` | No | `null` | Animation duration |

### Style Resolution

1. Widget parameter (e.g., `headerBackgroundColor`)
2. Component theme (`theme.accordionTheme?.headerBackgroundColor`)
3. Global token (`colors.surface`, `colors.background`, `colors.divider`, `colors.onSurface`)

Default resolved values:
- `headerBackgroundColor`: `colors.surface`
- `contentBackgroundColor`: `colors.background`
- `dividerColor`: `colors.divider`
- `iconColor`: `colors.onSurface`
- `headerPadding`: `EdgeInsets.all(16.0)`
- `contentPadding`: `EdgeInsets.all(16.0)`
- Icon rotation duration: `150ms`
- Size transition duration: `250ms`

## Usage

### Basic Single-Expand

```dart
class _MyState extends State<MyWidget> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return LeafAccordion<String>(
      items: [
        LeafAccordionItem(title: 'Section 1', data: 'Content for section 1'),
        LeafAccordionItem(title: 'Section 2', data: 'Content for section 2'),
        LeafAccordionItem(title: 'Section 3', data: 'Content for section 3'),
      ],
      expandedIndex: _expandedIndex,
      itemBuilder: (context, index, data) {
        return Text(data);
      },
      onExpansionChanged: (index) {
        setState(() {
          _expandedIndex = _expandedIndex == index ? null : index;
        });
      },
    );
  }
}
```

### Multi-Expand with Subtitles

```dart
class _MyState extends State<MyWidget> {
  final Set<int> _expandedIndices = {};

  @override
  Widget build(BuildContext context) {
    return LeafAccordion<Map<String, String>>(
      items: [
        LeafAccordionItem(
          title: 'FAQ 1',
          subtitle: 'About billing',
          data: {'answer': 'Billing information here...'},
        ),
        LeafAccordionItem(
          title: 'FAQ 2',
          subtitle: 'About shipping',
          data: {'answer': 'Shipping details here...'},
        ),
      ],
      allowMultiple: true,
      expandedIndices: _expandedIndices,
      itemBuilder: (context, index, data) {
        return Text(data['answer'] ?? '');
      },
      onExpansionChanged: (index) {
        setState(() {
          if (_expandedIndices.contains(index)) {
            _expandedIndices.remove(index);
          } else {
            _expandedIndices.add(index);
          }
        });
      },
    );
  }
}
```

### Standalone Tile

```dart
LeafAccordionTile(
  title: 'Advanced Settings',
  subtitle: 'Configure advanced options',
  expanded: _isExpanded,
  expandDuration: Duration(milliseconds: 300),
  onExpansionChanged: (expanded) {
    setState(() => _isExpanded = expanded);
  },
  child: Column(
    children: [
      SwitchListTile(title: Text('Option A'), value: true, onChanged: (_) {}),
      SwitchListTile(title: Text('Option B'), value: false, onChanged: (_) {}),
    ],
  ),
)
```
