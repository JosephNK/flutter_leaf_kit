# LeafStaggeredGrid

A wrapper around `StaggeredGrid.count` from the `flutter_staggered_grid_view` package for creating staggered grid layouts where tiles can span multiple rows and columns. This is a structural layout widget that does not require theme integration.

## API Reference

### LeafStaggeredGrid

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `crossAxisCount` | `int` | Yes | - | Number of cells in the cross axis |
| `mainAxisSpacing` | `double` | No | `0` | Spacing between tiles along the main axis |
| `crossAxisSpacing` | `double` | No | `0` | Spacing between tiles along the cross axis |
| `axisDirection` | `AxisDirection?` | No | `null` | Optional axis direction override |
| `children` | `List<LeafStaggeredGridTile>` | No | `[]` | The grid tiles to render |

### LeafStaggeredGridTile

A wrapper around `StaggeredGridTile.count` that defines how many cells a single tile occupies.

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `crossAxisCellCount` | `int` | Yes | - | Number of cells this tile spans across the cross axis |
| `mainAxisCellCount` | `num` | Yes | - | Number of cells this tile spans along the main axis |
| `child` | `Widget` | Yes | - | The content widget of this tile |

## Usage

### Basic Staggered Grid

```dart
LeafStaggeredGrid(
  crossAxisCount: 4,
  mainAxisSpacing: 4,
  crossAxisSpacing: 4,
  children: [
    LeafStaggeredGridTile(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: Container(color: Colors.red),
    ),
    LeafStaggeredGridTile(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: Container(color: Colors.green),
    ),
    LeafStaggeredGridTile(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Container(color: Colors.blue),
    ),
    LeafStaggeredGridTile(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Container(color: Colors.yellow),
    ),
    LeafStaggeredGridTile(
      crossAxisCellCount: 4,
      mainAxisCellCount: 2,
      child: Container(color: Colors.purple),
    ),
  ],
)
```

### Dashboard Layout

```dart
LeafStaggeredGrid(
  crossAxisCount: 4,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  children: [
    // Large featured card
    LeafStaggeredGridTile(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: Card(
        child: Center(child: Text('Featured')),
      ),
    ),
    // Small cards
    LeafStaggeredGridTile(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Card(
        child: Center(child: Text('Stats 1')),
      ),
    ),
    LeafStaggeredGridTile(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Card(
        child: Center(child: Text('Stats 2')),
      ),
    ),
    // Wide card
    LeafStaggeredGridTile(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: Card(
        child: Center(child: Text('Chart')),
      ),
    ),
  ],
)
```

### Photo Gallery Layout

```dart
LeafStaggeredGrid(
  crossAxisCount: 3,
  mainAxisSpacing: 2,
  crossAxisSpacing: 2,
  children: [
    // Tall image
    LeafStaggeredGridTile(
      crossAxisCellCount: 1,
      mainAxisCellCount: 2,
      child: Image.network(imageUrl1, fit: BoxFit.cover),
    ),
    // Square images
    LeafStaggeredGridTile(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Image.network(imageUrl2, fit: BoxFit.cover),
    ),
    LeafStaggeredGridTile(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Image.network(imageUrl3, fit: BoxFit.cover),
    ),
    // Wide image
    LeafStaggeredGridTile(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: Image.network(imageUrl4, fit: BoxFit.cover),
    ),
  ],
)
```

### With Fractional Cell Counts

```dart
LeafStaggeredGrid(
  crossAxisCount: 4,
  mainAxisSpacing: 4,
  crossAxisSpacing: 4,
  children: [
    LeafStaggeredGridTile(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1.5, // fractional main axis span
      child: Container(color: Colors.teal),
    ),
    LeafStaggeredGridTile(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2.5,
      child: Container(color: Colors.orange),
    ),
  ],
)
```
