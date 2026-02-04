# leaf_component 디자인 시스템 전면 개편 계획

## 현재 상태 분석

- **36개 카테고리**, **120+ 파일**의 UI 컴포넌트
- 디자인 토큰 시스템 없음 (색상, 타이포그래피, 스페이싱 하드코딩)
- 다크 모드 미지원
- Flutter ThemeExtension 미사용 (싱글톤 `LFComponentConfigure`로 4개 컴포넌트만 설정)
- 테스트 0건
- 버그 2건 + print 문 잔존

---

## Phase 0: 기존 버그 수정 ✅ 완료

### 0.1 LFTextSizeDouble 조건문 수정 ✅

- **파일**: `lib/src/component/text/types/lf_text_size.dart`
- **문제**: 세 조건 모두 `this == 0.8` 비교 → medium, large 분기 도달 불가
- **수정**: small=0.8, medium=1.0, large=1.2로 분기 수정

### 0.2 LFRadio inactiveIcon 버그 수정 ✅

- **파일**: `lib/src/component/radio/component/lf_radio.dart` (line 41)
- **문제**: `inactiveIcon` 기본값이 `this.activeIcon`을 참조
- **수정**: `this.inactiveIcon`으로 변경

### 0.3 print 문 제거 ✅

- **파일**: `lib/src/component/calendar/component/lf_calendar_view.dart`
- **수정**: print 문 삭제 + 불필요한 `foundation.dart` import 제거

---

## Phase 1: 디자인 토큰 시스템 ✅ 완료

### 1.1 Color 토큰 ✅

- **파일**: `lib/src/tokens/lf_colors.dart`
- **내용**: immutable 색상 토큰 클래스
  - Brand: primary, onPrimary, secondary, onSecondary
  - Surface: surface, onSurface, surfaceVariant, onSurfaceVariant
  - Background: background, onBackground
  - State: error, onError, success, warning, info
  - Interactive: active, inactive, disabled, focus, hover
  - Specific: divider, shadow, overlay, shimmerBase, shimmerHighlight
  - 프리셋: `LFColors.light()`, `LFColors.dark()`

### 1.2 Typography 토큰 ✅

- **파일**: `lib/src/tokens/lf_typography.dart`
- **내용**: Material Design 3 스케일 기반 타이포그래피
  - Display: displayLarge, displayMedium, displaySmall
  - Headline: headlineLarge, headlineMedium, headlineSmall
  - Title: titleLarge (22.0), titleMedium (16.0), titleSmall (14.0)
  - Body: bodyLarge (16.0), bodyMedium (14.0), bodySmall (12.0)
  - Label: labelLarge, labelMedium, labelSmall
  - 프리셋: `LFTypography.defaults()`

### 1.3 Spacing 토큰 ✅

- **파일**: `lib/src/tokens/lf_spacing.dart`
- **내용**: 간격 스케일
  - xs: 2.0, sm: 4.0, md: 8.0, lg: 12.0, xl: 16.0, xxl: 24.0, xxxl: 32.0
  - 프리셋: `LFSpacing.defaults()`

### 1.4 Elevation 토큰 ✅

- **파일**: `lib/src/tokens/lf_elevation.dart`
- **내용**: 그림자/높이 스케일
  - none: 0, xs: 1, sm: 2, md: 4, lg: 8, xl: 16
  - BoxShadow 프리셋: shadowNone, shadowSm, shadowMd, shadowLg

### 1.5 Radius 토큰 ✅

- **파일**: `lib/src/tokens/lf_radius.dart`
- **내용**: 모서리 반경 스케일
  - none: 0, sm: 4, md: 8, lg: 12, xl: 16, xxl: 20, full: 50

### 1.6 Duration 토큰 ✅

- **파일**: `lib/src/tokens/lf_duration.dart`
- **내용**: 애니메이션 시간 스케일
  - fast: 150ms, normal: 250ms, slow: 300ms, verySlow: 450ms

### 1.7 Barrel Export ✅

- **파일**: `lib/src/tokens/tokens.dart`
- **내용**: 모든 토큰 파일 export

---

## Phase 2: 테마 시스템 ✅ 완료

### 2.1 LFThemeData 생성 ✅

- **파일**: `lib/src/theme/lf_theme_data.dart`
- **내용**: 모든 토큰을 집계하는 중앙 테마 데이터 클래스
  - colors, typography, spacing, elevation, radius, duration
  - 컴포넌트별 테마 오버라이드 (buttonTheme, appBarTheme 등)
  - 프리셋: `LFThemeData.light()`, `LFThemeData.dark()`
  - `copyWith()` 메서드

### 2.2 LFTheme InheritedWidget 생성 ✅

- **파일**: `lib/src/theme/lf_theme.dart`
- **내용**: Flutter 위젯 트리에 테마 데이터를 제공
  - `LFTheme.of(context)` → LFThemeData 반환
  - `LFTheme.maybeOf(context)` → nullable 반환
  - 기본값: LFThemeData.light()

### 2.3 Flutter ThemeExtension 통합 ✅

- **파일**: `lib/src/theme/lf_theme_extension.dart`
- **내용**: `ThemeExtension<LFThemeDataExtension>` 구현
  - `Theme.of(context).extension<LFThemeDataExtension>()` 지원
  - `lerp()` 구현으로 부드러운 테마 전환

### 2.4 컴포넌트별 ThemeData 생성 ✅

- **위치**: `lib/src/theme/component/`
- **생성 순서** (우선순위):
  1. `LFButtonThemeData`
  2. `LFAppBarThemeData`
  3. `LFTextFieldThemeData`
  4. `LFDialogThemeData`
  5. `LFCheckBoxThemeData`
  6. `LFRadioThemeData`
  7. `LFChipThemeData`
  8. `LFSwitchThemeData`
  9. `LFTabBarThemeData`
  10. `LFBottomSheetThemeData`
  11. `LFBadgeThemeData`
  12. `LFToastThemeData`
  13. `LFIndicatorThemeData`
  14. `LFSkeletonThemeData`
  15. `LFCalendarThemeData`
  16. `LFNotificationThemeData`

### 2.5 Theme Barrel Export ✅

- **파일**: `lib/src/theme/theme.dart`

---

## Phase 3: 컴포넌트 마이그레이션 (하드코딩 → 토큰/테마)

모든 컴포넌트의 마이그레이션 패턴:

```dart
// Before
final activeIcon = this.activeIcon ?? const Icon(Icons.check_box, color: Colors.blueAccent);

// After
Widget build(BuildContext context) {
  final theme = LFTheme.of(context);
  final componentTheme = theme.checkBoxTheme;
  final activeColor = this.activeColor ?? componentTheme?.activeColor ?? theme.colors.primary;
  final activeIcon = this.activeIcon ?? Icon(Icons.check_box, color: activeColor);
}
```

### 3.1 Core 컴포넌트 (최우선)

| 컴포넌트 | 파일 | 주요 변경 |
|----------|------|-----------|
| LFButton | `button/component/lf_button.dart` | Colors.white → onPrimary, Colors.blueAccent → primary |
| LFText | `text/component/lf_text.dart` | typography 스케일 통합 |
| LFTextField | `textfield/component/lf_textfield.dart` | 15+ 하드코딩 색상 → 테마 토큰, 'PlaceHolder' 제거 |
| LFAppBar | `appbar/component/lf_appbar.dart` | Colors.white → surface, Colors.black → onSurface, Configure → Theme |

### 3.2 Selection 컴포넌트

| 컴포넌트 | 주요 변경 |
|----------|-----------|
| LFCheckBox | Colors.blueAccent → primary, Colors.grey → inactive |
| LFRadio | 동일 + inactiveIcon 버그 수정 |
| LFSwitch | 테마 기반 track/thumb 색상 |
| LFChip | Colors.black → onSurface, Colors.blueAccent → primary, 50.0 → radius.full |
| LFSlider | 테마 기반 track/thumb 색상 |

### 3.3 Feedback 컴포넌트

| 컴포넌트 | 주요 변경 |
|----------|-----------|
| LFBadge | Colors.red → error, Colors.white → onError |
| LFToast | Colors.black87 → 테마 토큰 |
| LFIndicator | 테마 기반 사이즈 기본값 |
| LFSkeleton | Colors.grey[300] → shimmerBase, Colors.grey[100] → shimmerHighlight |

### 3.4 Complex 컴포넌트

| 컴포넌트 | 주요 변경 |
|----------|-----------|
| LFAlertDialog | Configure → Theme, 하드코딩 문자열 제거 |
| LFBottomSheet | Configure → Theme, Colors.blueAccent → primary, 'Cancel' 제거 |
| LFTabBar | Colors.blueAccent → primary, Colors.black54 → onSurfaceVariant |
| LFCalendarView | Colors.purple → 테마 토큰, print 제거, 'OK' 제거 |
| LFPushNotification | 모든 하드코딩 → 테마 토큰 |
| LFPageView | Colors.pinkAccent → primary |

### 3.5 Infrastructure 컴포넌트

| 컴포넌트 | 주요 변경 |
|----------|-----------|
| LFInkWell | 하위 호환 유지하며 테마 통합 |
| LFLayoutApp | LFTheme ancestor 위젯 옵션 추가 |
| ScreenState | Colors.transparent → 테마 배경, Platform.isIOS → context 기반 |

---

## Phase 4: 컴포넌트 계층 분류 (문서화)

Atomic Design 기반으로 분류 (파일 위치는 유지, 문서/CLAUDE.md에서 분류):

- **Atoms**: LFText, LFIcon, LFBadge, LFButton, LFCheckBox, LFRadio, LFSwitch, LFChip, LFSlider, LFIndicator, LFSkeleton, Animated
- **Molecules**: LFTextField, LFChips, LFCheckBoxGroup, LFRadioGroup, LFRatingBar, LFAppBar, LFTabBar, LFAccordionTile
- **Organisms**: LFAlertDialog, LFBottomSheet, LFToast, LFCalendarView, LFAccordion, LFPageView, LFPushNotification, Scroll, Photo, Picker
- **Templates**: ScreenStatefulWidget, LFLayoutApp, LFBottomTabBarScaffold, LFPopScopeAppClose

### 신규 컴포넌트 후보

| 컴포넌트 | 계층 | 우선순위 |
|----------|------|----------|
| LFDivider | Atom | Medium |
| LFAvatar | Atom | Medium |
| LFCard | Molecule | High |
| LFListTile | Molecule | High |
| LFSearchField | Molecule | Medium |
| LFEmptyState | Molecule | Medium |
| LFErrorState | Molecule | Medium |
| LFLoadingOverlay | Molecule | Low |
| LFSnackBar | Organism | Medium |
| LFDropdown | Organism | Medium |
| LFStepper | Organism | Low |

---

## Phase 5: LFComponentConfigure 싱글톤 Deprecation

### 5.1 @deprecated 마킹

- **파일**: `lib/src/configure/src/lf_component_configure.dart`
- 클래스 및 모든 하위 설정에 `@Deprecated('Use LFTheme instead')` 추가
- 기능은 유지하되 경고 출력

### 5.2 LFLayoutApp 업데이트

- optional `LFThemeData` 파라미터 추가
- 제공 시 `LFTheme`으로 감싸기
- 레거시 configure와 신규 theme 동시 지원

---

## Phase 6: 접근성 (Phase 2와 병렬 가능)

### 6.1 Semantic Labels

- LFButton: `Semantics(button: true, label: text)`
- LFCheckBox: `Semantics(checked: state)`
- LFRadio: `Semantics(selected: state)`
- LFSwitch: `Semantics(toggled: state)`

### 6.2 Touch Target 크기

- 모든 탭 가능 컴포넌트에 최소 48x48 dp 터치 영역 보장
- `ConstrainedBox(constraints: BoxConstraints(minHeight: 48, minWidth: 48))`

### 6.3 색상 대비 검증

- WCAG AA 대비율 충족 확인 (일반 텍스트 4.5:1, 대형 텍스트 3:1)

---

## Phase 7: 플랫폼 적응성 (Phase 2와 병렬 가능)

### 7.1 Platform.isIOS 대체

**영향 파일:**
- `appbar/component/lf_appbar.dart`
- `indicator/component/lf_indicator.dart`
- `bottomsheet/component/lf_bottom_sheet.dart`
- `screen/component/lf_screen_stateful_widget.dart`
- `scroll/` (다수 파일)

**수정**: context 기반 플랫폼 감지 유틸리티 생성

```dart
class LFPlatform {
  static bool isApple(BuildContext context) {
    final platform = Theme.of(context).platform;
    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
  }
}
```

---

## Phase 8: 테스트 기반 (Phase 2와 병렬 가능)

### 8.1 테스트 헬퍼 생성

- **파일**: `test/helpers/test_helpers.dart`
- `buildTestWidget()` 래퍼 함수 (LFTheme + MaterialApp + Scaffold)

### 8.2 토큰 시스템 테스트

- **위치**: `test/tokens/`
- LFColors.light() / dark() null 값 없음 확인
- LFTypography.defaults() 폰트 크기 범위 확인
- LFSpacing.defaults() 단조 증가 확인

### 8.3 테마 해석 테스트

- **위치**: `test/theme/`
- LFTheme.of(context) 기본값 반환 확인
- 테마 해석 캐스케이드 동작 확인 (파라미터 > 테마 > 기본값)

### 8.4 위젯 테스트

- **위치**: `test/component/`
- **우선순위 대상:**
  1. LFButton (탭, disabled, 로딩, 테마 색상)
  2. LFText (렌더링, 스타일 적용)
  3. LFCheckBox (토글, 커스텀 아이콘)
  4. LFRadio (선택 동작)
  5. LFTextField (입력, 클리어, 포커스, 유효성)
  6. LFSwitch (토글)
  7. LFBadge (텍스트 vs 아이콘)
  8. LFAlertDialog (표시/확인 플로우)
  9. LFAppBar (렌더링, 뒤로가기 버튼)

---

## 실행 순서

```
Phase 0: 버그 수정
  │
Phase 1: 디자인 토큰
  │
Phase 2: 테마 시스템
  │
  ├── Phase 6: 접근성 (병렬)
  ├── Phase 7: 플랫폼 적응성 (병렬)
  └── Phase 8.1~8.3: 테스트 기반 (병렬)
  │
Phase 3: 컴포넌트 마이그레이션 (순차)
  │  3.1 Core → 3.2 Selection → 3.3 Feedback → 3.4 Complex → 3.5 Infrastructure
  │
Phase 4: 컴포넌트 계층 문서화 (Phase 2 이후 언제든)
  │
Phase 5: LFComponentConfigure deprecation (Phase 3 이후)
  │
Phase 8.4: 위젯 테스트 (각 마이그레이션 단계마다 병행)
```

---

## 리스크 및 대응

| 리스크 | 심각도 | 대응 |
|--------|--------|------|
| 기존 사용처 Breaking change | High | 기존 파라미터 모두 유지. 테마는 파라미터가 null일 때만 기본값 제공. Configure는 deprecated 하되 기능 유지 |
| 범위 확장 | High | Phase별 독립 배포 가능하게 설계. 토큰/테마 먼저 배포 후 컴포넌트 순차 마이그레이션 |
| Platform.isIOS 웹 빌드 크래시 | Medium | Phase 7에서 context 기반으로 전환. 웹 미지원 시 후순위 |
| 테마 조회 성능 저하 | Low | InheritedWidget 조회는 O(1). Theme.of(context)와 동일 비용 |
| Calendar/Photo 복잡한 내부 상태 | Medium | 마지막에 마이그레이션. Provider/ChangeNotifier 사용으로 테마 통합이 복잡 |
| 테스트 부재로 리그레션 미감지 | High | 각 컴포넌트 마이그레이션 전에 테스트 먼저 작성 (Phase 8 병행) |

---

## 성공 기준

- [ ] 모든 색상, 타이포그래피, 스페이싱, 엘리베이션, 반경 값이 토큰 클래스에서 참조됨 (컴포넌트 build 메서드에 `Colors.xxx` 하드코딩 0건)
- [ ] `LFTheme` InheritedWidget이 위젯 트리에 테마 데이터 제공
- [ ] Light/Dark 테마 프리셋이 시각적으로 일관된 UI 생성
- [ ] 모든 기존 위젯 API 하위 호환 유지 (required 파라미터 변경 없음)
- [ ] `LFComponentConfigure` deprecated 처리 + 마이그레이션 가이드 제공
- [ ] 모든 컴포넌트가 스타일 해석 순서 준수: 명시 파라미터 > 컴포넌트 테마 > 글로벌 토큰 > 폴백
- [ ] 토큰, 테마, 핵심 컴포넌트 테스트 커버리지 80% 이상
- [ ] 컴포넌트 코드에 `Platform.isIOS` 직접 호출 0건
- [ ] 모든 인터랙티브 컴포넌트에 semantic label 포함
- [ ] CLAUDE.md에 아키텍처, 컨벤션, 기여 가이드 문서화 완료
