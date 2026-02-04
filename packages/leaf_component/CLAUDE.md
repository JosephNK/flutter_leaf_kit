# leaf_component

Lf 디자인 시스템 기반 Flutter UI 컴포넌트 라이브러리.

## 빌드 & 테스트

```bash
flutter analyze packages/leaf_component
flutter test packages/leaf_component
```

## 패키지 구조

```
lib/
  leaf_component.dart          # 패키지 진입점
  src/
    tokens/                    # 디자인 토큰 (colors, typography, spacing, elevation, radius, duration)
    theme/                     # LFThemeData, LFTheme InheritedWidget, ThemeExtension
      component/               # 컴포넌트별 테마 데이터 (LFButtonThemeData 등)
    component/                 # UI 컴포넌트 (카테고리별 폴더)
    configure/                 # 글로벌 설정 (레거시, theme으로 마이그레이션 예정)
    model/                     # 공유 데이터 모델 (LFDataItem, LFDataColorItem)
```

## 의존성

- 내부: `leaf_common`, `leaf_datetime`, `leaf_manager`
- 주요 외부: `cached_network_image`, `flutter_svg`, `shimmer`, `fluttertoast`, `toastification`, `photo_manager`, `lucide_icons_flutter`

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

### Atoms (기본 요소)

`LFText`, `LFIcon`, `LFBadge`, `LFButton`, `LFInkWell`, `LFCheckBox`, `LFRadio`, `LFSwitch`, `LFChip`, `LFSlider`, `LFIndicator`, `LFSkeleton`, Animated 위젯

### Molecules (조합 요소)

`LFTextField`, `LFChips`, `LFCheckBoxGroup`, `LFRadioGroup`, `LFRatingBar`, `LFAppBar`, `LFTabBar`, `LFAccordionTile`

### Organisms (복합 UI)

`LFAlertDialog`, `LFBottomSheet`, `LFToast`, `LFCalendarView`, `LFAccordion`, `LFPageView`, `LFPushNotification`, Scroll 뷰, Photo 컴포넌트, Picker

### Templates (페이지 구조)

`ScreenStatefulWidget`, `LFLayoutApp`, `LFBottomTabBarScaffold`, `LFPopScopeAppClose`

## 컴포넌트 인벤토리

| 카테고리 | 주요 위젯 | 복잡도 |
|----------|-----------|--------|
| accordion | LFAccordion, LFAccordionTile, LFAccordionSection | Medium |
| animated | Bouncing, Expand, Fade, Flip, Rotate, Scale | Medium |
| app | LFLayoutApp | Low |
| appbar | LFAppBar, LFAppBarTitle, LFAppBarAction, LFAppBarBack | Medium |
| badge | LFBadge | Low |
| bottomsheet | LFBottomSheet | Medium |
| button | LFButton, LFInkWell, LFLockGestureDetector | Medium |
| calendar | LFCalendarView (월 네비게이션 포함) | High |
| checkbox | LFCheckBox, LFCheckBoxGroup | Low |
| chip | LFChip, LFChips | Low |
| dialog | LFAlertDialog + Calendar/Checkbox/Radio/Chip picker | High |
| grid | LFStaggeredGrid | Low |
| icon | LFIcons (IconData, SVG) | Low |
| image | Asset, Cache, Network, CircleAvatar, Memory, Transform | Medium |
| indicator | 플랫폼 적응형 로딩 + 페이지 인디케이터 | Low |
| navigationbar | 하단 탭 바 시스템 | High |
| notification | LFPushNotification | Medium |
| page | LFPageView (auto-paging) | Medium |
| painter | LFTimelinePainter | Low |
| photo | 포토 앨범 + LRU 캐시 | High |
| picker | 날짜/시간 피커 | Medium |
| popscope | LFPopScopeAppClose | Low |
| radio | LFRadio, LFRadioGroup | Low |
| ratingbar | LFRatingBar | Low |
| screen | ScreenStatefulWidget, ScreenStatelessWidget | Medium |
| scroll | ListView, GridView, ScrollView (Material/Cupertino) | High |
| size | LFWidgetSize | Low |
| skeleton | Shimmer 스켈레톤 로더 | Low |
| slider | LFSlider, LFRangeSlider | Low |
| switch | LFSwitch (Material/Cupertino) | Low |
| tabs | LFTabBar, LFTabView | Low |
| text | LFText, AutoSize, EasyRich, Expandable, Link, Rich | Medium |
| textfield | LFTextField + 커스텀 포매터 | High |
| toast | LFToast (fluttertoast + toastification) | Medium |

## 플랫폼 적응성

`Platform.isIOS` 대신 context 기반 감지 사용:

```dart
// 올바른 방법 (웹 호환)
final isApple = Theme.of(context).platform == TargetPlatform.iOS
    || Theme.of(context).platform == TargetPlatform.macOS;

// 잘못된 방법 (웹에서 크래시)
final isApple = Platform.isIOS;
```

## 마이그레이션 가이드

### LFComponentConfigure -> LFTheme

`LFComponentConfigure` 싱글톤은 deprecated 예정. `LFTheme` InheritedWidget으로 전환:

```dart
// 레거시 (deprecated 예정)
LFComponentConfigure.shared.setup(configure);

// 신규
LFTheme(
  data: LFThemeData.light().copyWith(
    appBarTheme: LFAppBarThemeData(
      backgroundColor: Colors.indigo,
    ),
  ),
  child: app,
);
```

## 알려진 이슈

- `LFTextSizeDouble` 확장: 모든 조건이 `this == 0.8` 비교 (medium, large 분기 미작동)
- `LFRadio`: `inactiveIcon` 기본값이 `activeIcon`을 참조하는 버그
- `LFCalendarView`: print 문 잔존
- 하드코딩 문자열 다수 ('PlaceHolder', 'Cancel', 'OK' 등)
- `Platform.isIOS` 직접 호출로 웹 빌드 미호환
- 테스트 0건
