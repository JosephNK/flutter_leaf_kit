/// Text scale factor presets for V2 text components.
///
/// Standalone V2 version — no dependency on V1.
enum LeafTextSize {
  small,
  medium,
  large,
}

extension LeafTextSizeExt on LeafTextSize {
  double get textScaleFactor {
    switch (this) {
      case LeafTextSize.small:
        return 0.8;
      case LeafTextSize.medium:
        return 1.0;
      case LeafTextSize.large:
        return 1.2;
    }
  }
}
