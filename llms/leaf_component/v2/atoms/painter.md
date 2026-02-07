# LeafTimelinePainter

A `CustomPainter` that draws a vertical timeline line between items. The line is drawn from just below the top circle indicator to just above the bottom, leaving configurable gap spacing at each end. This widget does not use the Leaf theme system -- colors and dimensions are passed directly as constructor parameters.

## API Reference

### LeafTimelinePainter

Extends `CustomPainter`.

#### Constructor Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `width` | `double` | Yes | - | Total width of the timeline indicator area; used to calculate the center line position (`width / 2`) |
| `lineColor` | `Color` | Yes | - | Color of the timeline line |
| `strokeCap` | `StrokeCap` | No | `StrokeCap.butt` | Line cap style |
| `strokeWidth` | `double` | No | `2.0` | Width of the timeline stroke |
| `itemGap` | `double` | No | `3.0` | Gap between the circle indicator edge and the line endpoints |
| `style` | `PaintingStyle` | No | `PaintingStyle.stroke` | Paint fill style |

### Drawing Behavior
- Start point: `Offset(width/2, width + itemGap)` -- just below the top circle
- End point: `Offset(canvasWidth - width/2, canvasHeight - itemGap)` -- just above the bottom
- The line is only drawn if the start point is above the end point (`p1.dy < p2.dy`)

### Repaint Optimization
`shouldRepaint` compares all parameters: `width`, `lineColor`, `strokeCap`, `strokeWidth`, `itemGap`, and `style`.

## Usage

### Basic Timeline Line
```dart
CustomPaint(
  painter: LeafTimelinePainter(
    width: 20,
    lineColor: Colors.grey,
  ),
  child: Container(height: 100),
)
```

### Styled Timeline
```dart
CustomPaint(
  painter: LeafTimelinePainter(
    width: 24,
    lineColor: Colors.blue,
    strokeWidth: 3.0,
    strokeCap: StrokeCap.round,
    itemGap: 5.0,
  ),
  child: Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: [
        // Timeline item content
        Text('Step 1'),
        SizedBox(height: 40),
        Text('Step 2'),
      ],
    ),
  ),
)
```

### In a Timeline List
```dart
ListView.builder(
  itemCount: events.length,
  itemBuilder: (context, index) {
    final isLast = index == events.length - 1;
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: isLast
                ? SizedBox.shrink()
                : CustomPaint(
                    painter: LeafTimelinePainter(
                      width: 12,
                      lineColor: Colors.grey.shade400,
                      strokeWidth: 2.0,
                      itemGap: 4.0,
                    ),
                  ),
          ),
          Expanded(child: EventCard(event: events[index])),
        ],
      ),
    );
  },
)
```
