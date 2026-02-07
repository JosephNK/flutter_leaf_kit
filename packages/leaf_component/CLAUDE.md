# leaf_component

LF 디자인 시스템 기반 Flutter UI 컴포넌트 라이브러리.

## 빌드 & 테스트

```bash
flutter analyze packages/leaf_component
flutter test packages/leaf_component
```

## 네이밍 컨벤션

- 클래스 접두사: `LF` (예: `LFButton`, `LFAppBar`, `LFText`)
- 파일 접두사: `lf_` (예: `lf_button.dart`, `lf_appbar.dart`)
- 토큰 클래스: `LFColors`, `LFTypography`, `LFSpacing`, `LFElevation`, `LFRadius`, `LFDuration`
- 테마 클래스: `LFThemeData`, `LFTheme`
- 컴포넌트 테마: `LF` + 컴포넌트명 + `ThemeData` (예: `LFButtonThemeData`)
- Enum: `LF` + 컴포넌트명 + 개념 (예: `LFCheckBoxAlign`, `LFTextSize`)

## 컴포넌트 작성 규칙

### 필수 요건

1. `const` 생성자 사용 (가능한 경우)
2. 스타일링은 optional 파라미터로 받되, 테마 기반 기본값 사용
3. `StatelessWidget` 우선 (`StatefulWidget`은 로컬 상태가 필요할 때만)
4. 접근성을 위한 semantic label 포함

### 스타일 해석 우선순위

```
위젯 파라미터 > LFThemeData (context) > 하드코딩 기본값
```

```dart
Widget build(BuildContext context) {
  final theme = LFTheme.of(context);
  final colors = theme.colors;

  final bgColor = widget.backgroundColor    // 1. 위젯 파라미터
      ?? theme.buttonTheme?.backgroundColor  // 2. 컴포넌트 테마
      ?? colors.primary;                     // 3. 글로벌 토큰
  ...
}
```

### 파일 크기 제한

- 파일당 최대 400줄 (초과 시 서브 위젯으로 분리)
- 파일당 하나의 public 위젯
- private 헬퍼 위젯은 같은 파일에 허용

### Barrel Export

- 각 컴포넌트 카테고리는 barrel 파일 보유 (예: `button.dart`)
- Dart `part`/`part of` 패턴 사용
- `component.dart`에서 모든 카테고리 re-export

## 디자인 토큰 시스템

### Colors (`LFColors`)

| 토큰 | 용도 |
|------|------| 
| `primary`, `onPrimary` | 브랜드 주요 색상 |
| `secondary`, `onSecondary` | 보조 색상 |
| `surface`, `onSurface` | 카드, AppBar 등 표면 |
| `background`, `onBackground` | 배경 |
| `error`, `onError` | 에러 상태 |
| `success`, `warning`, `info` | 시맨틱 색상 |
| `active`, `inactive`, `disabled` | 인터랙티브 상태 |
| `divider`, `shadow`, `overlay` | 구조적 요소 |

프리셋: `LFColors.light()`, `LFColors.dark()`

### Typography (`LFTypography`)

Material Design 3 스케일 기반: `displayLarge` ~ `labelSmall`

### Spacing (`LFSpacing`)

```
xs: 2 / sm: 4 / md: 8 / lg: 12 / xl: 16 / xxl: 24 / xxxl: 32
```

### Elevation (`LFElevation`)

```
none: 0 / xs: 1 / sm: 2 / md: 4 / lg: 8 / xl: 16
```

### Radius (`LFRadius`)

```
none: 0 / sm: 4 / md: 8 / lg: 12 / xl: 16 / xxl: 20 / full: 50
```

### Duration (`LFDuration`)

```
fast: 150ms / normal: 250ms / slow: 300ms / verySlow: 450ms
```

## 테마 시스템

### LFTheme 사용법

```dart
// 앱 루트에서 테마 제공
LFTheme(
  data: LFThemeData.light(),  // 또는 LFThemeData.dark()
  child: MaterialApp(...),
);

// 컴포넌트에서 테마 접근
final theme = LFTheme.of(context);
final colors = theme.colors;
final typography = theme.typography;
```

### Flutter ThemeData 통합

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      LFThemeDataExtension(data: LFThemeData.light()),
    ],
  ),
);
```

## 컴포넌트 계층 (Atomic Design)

[Atomic Design](https://bradfrost.com/blog/post/atomic-web-design/) 방법론을 기반으로 컴포넌트를 계층화합니다.

| 단계 | 설명 | 예시 |
|------|------|------|
| **Atoms** | 더 이상 분해할 수 없는 기본 UI 요소 | 버튼, 텍스트, 아이콘 |
| **Molecules** | Atoms를 조합한 기능 단위 | 텍스트 필드, 체크박스 그룹 |
| **Organisms** | Molecules/Atoms를 조합한 복합 UI 블록 | 다이얼로그, 캘린더, 바텀시트 |
| **Templates** | 페이지 수준의 레이아웃 구조 | 스캐폴드, 앱 레이아웃 |

새 컴포넌트 추가 시 위 계층에 맞는 적절한 레벨에 배치하세요.

### Atoms (기본 요소)

`LFText`, `LFIcon`, `LFBadge`, `LFButton`, `LFInkWell`, `LFCheckBox`, `LFRadio`, `LFSwitch`, `LFChip`, `LFSlider`, `LFIndicator`, `LFSkeleton`, Animated 위젯

### Molecules (조합 요소)

`LFTextField`, `LFChips`, `LFCheckBoxGroup`, `LFRadioGroup`, `LFRatingBar`, `LFAppBar`, `LFTabBar`, `LFAccordionTile`

### Organisms (복합 UI)

`LFAlertDialog`, `LFBottomSheet`, `LFToast`, `LFCalendarView`, `LFAccordion`, `LFPageView`, `LFPushNotification`, Scroll 뷰, Photo 컴포넌트, Picker

### Templates (페이지 구조)

`ScreenStatefulWidget`, `LFLayoutApp`, `LFBottomTabBarScaffold`, `LFPopScopeAppClose`

## 플랫폼 적응성

`Platform.isIOS` 대신 context 기반 감지 사용:

```dart
// 올바른 방법 (웹 호환)
final isApple = Theme.of(context).platform == TargetPlatform.iOS
    || Theme.of(context).platform == TargetPlatform.macOS;

// 잘못된 방법 (웹에서 크래시)
final isApple = Platform.isIOS;
```
