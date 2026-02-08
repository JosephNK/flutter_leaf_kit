part of '../configure.dart';

/// AppBar Configure
@Deprecated('Use LeafAppBarThemeData instead')
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
@Deprecated('Use LeafDialogThemeData instead')
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
  final BorderRadius? borderRadius;

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
    this.borderRadius,
  });
}

/// BottomSheet Configure
@Deprecated('Use LeafBottomSheetThemeData instead')
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

/// Picker Calendar Configure
@Deprecated('Use LeafPickerThemeData instead')
class LFPickerCalendarConfigure {
  final Color? activeColor;

  LFPickerCalendarConfigure({this.activeColor = Colors.blueAccent});
}

@Deprecated('Use LeafThemeData instead')
class LFAppComponentConfigure {
  LFAppBarComponentConfigure? appBar;
  LFAlertDialogConfigure? alert;
  LFBottomSheetConfigure? bottomSheet;
  LFPickerCalendarConfigure? pickerCalendar;

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

  LFPickerCalendarConfigure? setupPickerCalendar() {
    return null;
  }
}

@Deprecated('Use LeafTheme instead')
class LFComponentConfigure {
  static final LFComponentConfigure _instance =
      LFComponentConfigure._internal();
  static LFComponentConfigure get shared => _instance;
  LFComponentConfigure._internal();

  LFComponentConfigure setup(LFAppComponentConfigure? configure) {
    _appBarComponentConfigure = configure?.setupAppbar();
    _alertComponentConfigure = configure?.setupAlert();
    _bottomSheetComponentConfigure = configure?.setupBottomSheet();
    _pickerCalendarConfigure = configure?.setupPickerCalendar();
    return this;
  }

  LFAppBarComponentConfigure? _appBarComponentConfigure;
  LFAlertDialogConfigure? _alertComponentConfigure;
  LFBottomSheetConfigure? _bottomSheetComponentConfigure;
  LFPickerCalendarConfigure? _pickerCalendarConfigure;

  /// Getter
  LFAppBarComponentConfigure? get appBar => _appBarComponentConfigure;
  LFAlertDialogConfigure? get alert => _alertComponentConfigure;
  LFBottomSheetConfigure? get bottomSheet => _bottomSheetComponentConfigure;
  LFPickerCalendarConfigure? get pickerCalendar => _pickerCalendarConfigure;
}
