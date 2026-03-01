# LeafAppConfig

Singleton that holds app package metadata (name, version, build number, platform) and derives the build type from the package name. Provides display version and user agent string generation.

## API Reference

### LeafAppConfig

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
| `LeafAppConfig.ensureInitialized()` | `Future<LeafAppConfig>` | Creates instance from `PackageInfo.fromPlatform()` |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `instance` | `LeafAppConfig` | Singleton access (throws if not initialized) |
| `buildType` | `LeafBuildType` | Derived build type |
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
| `userAgent(String appName, {LeafBuildType? overrideBuildType})` | `String` | User agent string (e.g., `MyApp-ios-development-1.0.0.1`). `overrideBuildType`으로 빌드타입 오버라이드 가능 |

### LeafBuildType (Enum)

| Value | Description |
|-------|-------------|
| `production` | Live/release build |
| `development` | Development build |
| `staging` | Staging build |
| `test` | QA/test build |

### LeafBuildTypeExt (Extension on LeafBuildType)

| Property | Type | Description |
|----------|------|-------------|
| `longName` | `String` | Full name (e.g., `production`, `development`) |
| `shortName` | `String` | Abbreviated name (e.g., `prod`, `dev`, `stg`, `test`) |

## Usage

### Initialize from Platform

```dart
final appConfig = await LeafAppConfig.ensureInitialized();
```

### Initialize Manually

```dart
final appConfig = LeafAppConfig(
  packageName: 'com.example.app.dev',
  packageVersion: '1.2.0',
  packageBuildNumber: '42',
);
```

### Access Singleton

```dart
final config = LeafAppConfig.instance;
print(config.isProduction); // false
print(config.buildType.shortName); // 'dev'
```

### Display Version

```dart
final version = LeafAppConfig.instance.getDisplayAppVersion(
  showBuildNumber: true,
  showDeployment: true,
); // 'development 1.2.0(42)'
```

### User Agent

```dart
final ua = LeafAppConfig.instance.userAgent('MyApp');
// 'MyApp-ios-development-1.2.0.42'

// 빌드타입 오버라이드
final ua2 = LeafAppConfig.instance.userAgent('MyApp', overrideBuildType: LeafBuildType.production);
// 'MyApp-ios-production-1.2.0.42'
```
