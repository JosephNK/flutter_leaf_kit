import 'package:flutter/material.dart';

/// AppBar Configure
class LFAppBarComponentConfigure {
  final TextStyle? titleStyle;
  final double? backIconSize;
  final Color? backgroundColor;
  final Color? bottomBorderColor;
  final double? elevation;
  final double? actionsRightMargin;

  LFAppBarComponentConfigure({
    this.titleStyle,
    this.backIconSize,
    this.backgroundColor,
    this.bottomBorderColor,
    this.elevation,
    this.actionsRightMargin,
  });
}

/// BottomSheet Configure
class LFBottomSheetConfigure {
  final Color? activeColor;
  final Color? inactiveColor;
  final String cancelText;

  LFBottomSheetConfigure({
    this.activeColor = Colors.blueAccent,
    this.inactiveColor = Colors.black,
    this.cancelText = 'Cancel',
  });
}

class LFAppComponentConfigure {
  LFAppBarComponentConfigure? appBar;
  LFBottomSheetConfigure? bottomSheet;

  LFAppComponentConfigure();

  LFAppBarComponentConfigure? setupAppbar() {
    return null;
  }

  LFBottomSheetConfigure? setupBottomSheet() {
    return null;
  }
}

class LFComponentConfigure {
  static final LFComponentConfigure _instance =
      LFComponentConfigure._internal();
  static LFComponentConfigure get shared => _instance;
  LFComponentConfigure._internal();

  LFComponentConfigure setup(LFAppComponentConfigure? configure) {
    _appComponentConfigure = configure;
    return this;
  }

  LFAppComponentConfigure? _appComponentConfigure;

  /// Getter
  LFAppBarComponentConfigure? get appBar =>
      LFComponentConfigure.shared._appComponentConfigure?.appBar;
  LFBottomSheetConfigure? get bottomSheet =>
      LFComponentConfigure.shared._appComponentConfigure?.bottomSheet;
}
