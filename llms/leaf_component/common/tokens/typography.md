# LeafTypography

Typography token class based on the Material Design 3 type scale. Provides 15 named `TextStyle` slots across five categories: Display, Headline, Title, Body, and Label. Immutable with `copyWith()` and `lerp()` support.

## API Reference

### Constructor Parameters

All parameters are **required** `TextStyle` values.

#### Display
| Parameter | Description |
|-----------|-------------|
| `displayLarge` | Largest display text |
| `displayMedium` | Medium display text |
| `displaySmall` | Smallest display text |

#### Headline
| Parameter | Description |
|-----------|-------------|
| `headlineLarge` | Largest headline text |
| `headlineMedium` | Medium headline text |
| `headlineSmall` | Smallest headline text |

#### Title
| Parameter | Description |
|-----------|-------------|
| `titleLarge` | Largest title text |
| `titleMedium` | Medium title text |
| `titleSmall` | Smallest title text |

#### Body
| Parameter | Description |
|-----------|-------------|
| `bodyLarge` | Largest body text |
| `bodyMedium` | Medium body text (default reading size) |
| `bodySmall` | Smallest body text |

#### Label
| Parameter | Description |
|-----------|-------------|
| `labelLarge` | Largest label text |
| `labelMedium` | Medium label text |
| `labelSmall` | Smallest label text |

### Factory Constructors

| Factory | Description |
|---------|-------------|
| `LeafTypography.defaults()` | Material Design 3 default type scale |

### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `copyWith({...})` | `LeafTypography` | Returns a copy with the given fields replaced |
| `LeafTypography.lerp(a, b, t)` | `LeafTypography` | Linearly interpolates between two instances |

## Default Type Scale

| Style | Size | Weight | Letter Spacing | Line Height |
|-------|------|--------|----------------|-------------|
| `displayLarge` | 57.0 | w400 | -0.25 | 1.12 |
| `displayMedium` | 45.0 | w400 | - | 1.16 |
| `displaySmall` | 36.0 | w400 | - | 1.22 |
| `headlineLarge` | 32.0 | w400 | - | 1.25 |
| `headlineMedium` | 28.0 | w400 | - | 1.29 |
| `headlineSmall` | 24.0 | w400 | - | 1.33 |
| `titleLarge` | 22.0 | w500 | - | 1.27 |
| `titleMedium` | 16.0 | w500 | 0.15 | 1.50 |
| `titleSmall` | 14.0 | w500 | 0.1 | 1.43 |
| `bodyLarge` | 16.0 | w400 | 0.5 | 1.50 |
| `bodyMedium` | 14.0 | w400 | 0.25 | 1.43 |
| `bodySmall` | 12.0 | w400 | 0.4 | 1.33 |
| `labelLarge` | 14.0 | w500 | 0.1 | 1.43 |
| `labelMedium` | 12.0 | w500 | 0.5 | 1.33 |
| `labelSmall` | 11.0 | w500 | 0.5 | 1.45 |

## Usage

### Using Default Scale
```dart
final typography = LeafTypography.defaults();
```

### Custom Typography
```dart
final typography = LeafTypography.defaults().copyWith(
  displayLarge: TextStyle(
    fontSize: 60.0,
    fontWeight: FontWeight.w700,
    fontFamily: 'CustomFont',
  ),
);
```

### Accessing via Theme
```dart
final typography = LeafTheme.of(context).typography;
// or
final typography = context.leafTypography;

Text('Title', style: typography.headlineMedium);
Text('Body', style: typography.bodyMedium);
Text('Label', style: typography.labelSmall);
```
