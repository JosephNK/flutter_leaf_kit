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
    _appBarComponentConfigure = configure?.setupAppbar();
    _bottomSheetComponentConfigure = configure?.setupBottomSheet();
    return this;
  }

  LFAppBarComponentConfigure? _appBarComponentConfigure;
  LFBottomSheetConfigure? _bottomSheetComponentConfigure;

  /// Getter
  LFAppBarComponentConfigure? get appBar => _appBarComponentConfigure;
  LFBottomSheetConfigure? get bottomSheet => _bottomSheetComponentConfigure;
}
