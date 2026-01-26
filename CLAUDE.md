# Flutter Leaf Kit

A personal Flutter utility library package for common modules

## Git 커밋 가이드

커밋 시 `/commit` 스킬을 사용합니다.

```bash
/commit           # 변경사항 분석 후 자동 커밋 메시지 생성
/commit 메시지    # 입력된 메시지를 subject로 사용
```

## 패키지 구조

`packages/` 폴더 아래 11개의 독립 패키지로 구성:

| 패키지 | 설명 |
|--------|------|
| `leaf_common` | 공용 유틸, 확장 함수, 로깅, 예외 처리 |
| `leaf_component` | UI 컴포넌트 (AppBar, TabBar, Calendar, Radio, Toast 등) |
| `leaf_datetime` | 날짜/시간 관리, 로컬라이제이션 (한/영) |
| `leaf_location` | 위치 정보 관리 (geolocator) |
| `leaf_map` | Google Maps 통합 |
| `leaf_navigation` | 페이지 네비게이션, 모달 |
| `leaf_manager` | 앱/디바이스/파일/권한 관리 |
| `leaf_network` | HTTP 통신 (Dio 기반) |
| `leaf_store` | BLoC 상태 관리, SharedPreferences |
| `leaf_webview` | WebView 통합 |
| `leaf` | 모든 패키지 통합 export |

## 코드 컨벤션

- 클래스 접두사: `Lf` (예: `LfAppBar`, `LfHttp`, `LfDevice`)
- Export: 각 패키지별 단일 export 파일 (예: `leaf_common.dart`)
- 상태 관리: BLoC 패턴 사용

## Python 가이드

Python 스크립트는 Poetry로 관리하며, `scripts/` 폴더에 위치합니다.

```bash
poetry install  # 의존성 설치
```

주요 명령어는 [README.md](README.md#commands) 참고