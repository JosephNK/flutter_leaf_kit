part of '../text.dart';

@Deprecated('V1 component deprecated. Use V2 components instead.')
enum LFTextSize { small, medium, large }

@Deprecated('V1 component deprecated. Use V2 components instead.')
extension LFTextSizeExt on LFTextSize {
  double get textScaleFactor {
    switch (this) {
      case LFTextSize.small:
        return 0.8;
      case LFTextSize.medium:
        return 1.0;
      case LFTextSize.large:
        return 1.2;
    }
  }
}

@Deprecated('V1 component deprecated. Use V2 components instead.')
extension LFTextSizeDouble on double {
  LFTextSize get textSize {
    if (this == 0.8) {
      return LFTextSize.small;
    } else if (this == 1.0) {
      return LFTextSize.medium;
    } else if (this == 1.2) {
      return LFTextSize.large;
    }
    return LFTextSize.medium;
  }
}
