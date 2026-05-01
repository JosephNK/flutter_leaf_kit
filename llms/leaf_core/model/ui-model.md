# UIModel & UIModelV2

Abstract base model classes built on Equatable for value-equality. Two generations: V1 uses untyped `Object?` payload, V2 uses a generic type parameter `<P>` for type-safe payload access.

## API Reference

### UIModelInterface (V1 Interface)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `getPayload<T>()` | `T?` | Retrieve payload cast to type T |

### UIModel (V1 Abstract Class)

Extends `Equatable`, implements `UIModelInterface`.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `payload` | `Object?` | Yes | Untyped payload data |

| Property | Type | Description |
|----------|------|-------------|
| `payload` | `Object?` | The payload value |
| `props` | `List<Object?>` | Equatable props (`[payload]`) |

### UIModelV2Interface (V2 Interface)

| Method | Return Type | Description |
|--------|-------------|-------------|
| `getPayload()` | `Object?` | Retrieve the payload |

### UIModelV2\<P\> (V2 Abstract Class)

Extends `Equatable`, implements `UIModelV2Interface`. Generic type `P` provides type-safe payload access.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `payload` | `P?` | No | Typed payload data |

| Property | Type | Description |
|----------|------|-------------|
| `payload` | `P?` | The typed payload value |
| `props` | `List<Object?>` | Equatable props |

| Method | Return Type | Description |
|--------|-------------|-------------|
| `getPayload()` | `P?` | Returns the typed payload |

## Usage

### V1 Model

```dart
class UserModel extends UIModel {
  final String name;

  const UserModel({required this.name, required super.payload});

  @override
  List<Object?> get props => [super.props, name];

  @override
  T? getPayload<T>() => payload as T?;
}
```

### V2 Model (Recommended)

```dart
class ProductModel extends UIModelV2<String> {
  final String title;
  final int price;

  const ProductModel({
    required this.title,
    required this.price,
    super.payload,
  });

  @override
  List<Object?> get props => [super.props, title, price];
}

final product = ProductModel(title: 'Item', price: 100, payload: 'sku-123');
final sku = product.getPayload(); // 'sku-123' (typed as String?)
```
