part of '../text.dart';

enum LFTextSize {
  small,
  medium,
  large,
}

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

extension LFTextSizeDouble on double {
  LFTextSize get textSize {
    if (this == 0.8) {
      return LFTextSize.small;
    } else if (this == 0.8) {
      return LFTextSize.medium;
    } else if (this == 0.8) {
      return LFTextSize.large;
    }
    return LFTextSize.medium;
  }
}
