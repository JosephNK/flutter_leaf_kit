# LeafAppInfo

Singleton that holds app package metadata (name, version, build number, platform) and derives the build type from the package name. Provides display version and user agent string generation.

## API Reference

### LeafAppInfo

#### Factory Constructor

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `packageName` | `String` | Yes | App package name (e.g., `com.example.app.dev`) |
| `packageVersion` | `String` | Yes | Semantic version string |
| `packageBuildNumber` | `String` | Yes | Build number |

The factory determines `platform` (`ios`, `aos`, `web`) and `buildType` based on whether `packageName` contains `dev`, `staging`, or `test`.

#### Static Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `LeafAppInfo.fromInfo()` | `Future<LeafAppInfo>` | Creates instance from `PackageInfo.fromPlatform()` |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `instance` | `LeafAppInfo` | Singleton access (throws if not initialized) |
| `buildType` | `BuildType` | Derived build type |
| `packageName` | `String` | App package name |
| `packageVersion` | `String` | Version string |
| `packageBuildNumber` | `String` | Build number |
| `platform` | `String` | `ios`, `aos`, or `web` |
| `isProduction` | `bool` | Whether build type is production |
| `isDevelopment` | `bool` | Whether build type is development |
| `isStaging` | `bool` | Whether build type is staging |
| `isTest` | `bool` | Whether build type is test |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `getDisplayAppVersion({bool showBuildNumber, bool showDeployment})` | `String` | Formatted version string (e.g., `development 1.0.0(1)`) |
| `userAgent(String appName)` | `String` | User agent string (e.g., `MyApp-ios-development-1.0.0.1`) |

### BuildType (Enum)

| Value | Description |
|-------|-------------|
| `production` | Live/release build |
| `development` | Development build |
| `staging` | Staging build |
| `test` | QA/test build |

### BuildTypeExt (Extension on BuildType)

| Property | Type | Description |
|----------|------|-------------|
| `longName` | `String` | Full name (e.g., `production`, `development`) |
| `shortName` | `String` | Abbreviated name (e.g., `prod`, `dev`, `stg`, `test`) |

## Usage

### Initialize from Platform

```dart
final appInfo = await LeafAppInfo.fromInfo();
```

### Initialize Manually

```dart
final appInfo = LeafAppInfo(
  packageName: 'com.example.app.dev',
  packageVersion: '1.2.0',
  packageBuildNumber: '42',
);
```

### Access Singleton

```dart
final info = LeafAppInfo.instance;
print(info.isProduction); // false
print(info.buildType.shortName); // 'dev'
```

### Display Version

```dart
final version = LeafAppInfo.instance.getDisplayAppVersion(
  showBuildNumber: true,
  showDeployment: true,
); // 'development 1.2.0(42)'
```

### User Agent

```dart
final ua = LeafAppInfo.instance.userAgent('MyApp');
// 'MyApp-ios-development-1.2.0.42'
```
