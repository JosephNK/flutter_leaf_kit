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

/// Alert Configure
class LFAlertDialogConfigure {
  final String? cancelText;
  final String? okText;
  final String? errorMessageTitle;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final TextStyle? okTextStyle;
  final Color? okTextBackgroundColor;
  final Color? okTextBorderColor;
  final TextStyle? cancelTextStyle;
  final Color? cancelTextBackgroundColor;
  final Color? cancelTextBorderColor;
  final EdgeInsets? buttonPadding;

  LFAlertDialogConfigure({
    this.cancelText,
    this.okText,
    this.errorMessageTitle,
    this.titleStyle,
    this.messageStyle,
    this.okTextStyle,
    this.okTextBackgroundColor,
    this.okTextBorderColor,
    this.cancelTextStyle,
    this.cancelTextBackgroundColor,
    this.cancelTextBorderColor,
    this.buttonPadding,
  });
}

/// BottomSheet Configure
class LFBottomSheetConfigure {
  final Color? activeColor;
  final Color? inactiveColor;
  final String? cancelText;

  LFBottomSheetConfigure({
    this.activeColor = Colors.blueAccent,
    this.inactiveColor = Colors.black,
    this.cancelText,
  });
}

class LFAppComponentConfigure {
  LFAppBarComponentConfigure? appBar;
  LFAlertDialogConfigure? alert;
  LFBottomSheetConfigure? bottomSheet;

  LFAppComponentConfigure();

  LFAppBarComponentConfigure? setupAppbar() {
    return null;
  }

  LFAlertDialogConfigure? setupAlert() {
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
    _alertComponentConfigure = configure?.setupAlert();
    _bottomSheetComponentConfigure = configure?.setupBottomSheet();
    return this;
  }

  LFAppBarComponentConfigure? _appBarComponentConfigure;
  LFAlertDialogConfigure? _alertComponentConfigure;
  LFBottomSheetConfigure? _bottomSheetComponentConfigure;

  /// Getter
  LFAppBarComponentConfigure? get appBar => _appBarComponentConfigure;
  LFAlertDialogConfigure? get alert => _alertComponentConfigure;
  LFBottomSheetConfigure? get bottomSheet => _bottomSheetComponentConfigure;
}
