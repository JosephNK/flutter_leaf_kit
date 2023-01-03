import 'package:flutter/material.dart';

/// AppBar Configure
class LFAppBarComponentConfigure {
  final TextStyle? titleStyle;
  final double? backIconSize;
  final Color? bottomBorderColor;

  LFAppBarComponentConfigure({
    this.titleStyle,
    this.backIconSize,
    this.bottomBorderColor,
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

abstract class LFAppComponentConfigure {
  void run();
}

class LFComponentConfigure extends LFAppComponentConfigure {
  static final LFComponentConfigure _instance =
      LFComponentConfigure._internal();
  static LFComponentConfigure get shared => _instance;
  LFComponentConfigure._internal();

  LFComponentConfigure setup({
    LFAppBarComponentConfigure? appBarConfigure,
    LFBottomSheetConfigure? bottomSheetConfigure,
  }) {
    _appBar = appBarConfigure;
    _bottomSheet = bottomSheetConfigure;

    return this;
  }

  LFAppBarComponentConfigure? get appBar => LFComponentConfigure.shared._appBar;
  LFAppBarComponentConfigure? _appBar;

  LFBottomSheetConfigure? get bottomSheet =>
      LFComponentConfigure.shared._bottomSheet;
  LFBottomSheetConfigure? _bottomSheet;

  @override
  void run() {}
}
