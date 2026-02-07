/// Text scale factor presets for V2 text components.
///
/// Standalone V2 version — no dependency on V1.
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
