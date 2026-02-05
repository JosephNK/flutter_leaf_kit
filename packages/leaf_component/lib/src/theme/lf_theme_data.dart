import '../tokens/lf_colors.dart';
import '../tokens/lf_duration.dart';
import '../tokens/lf_elevation.dart';
import '../tokens/lf_radius.dart';
import '../tokens/lf_spacing.dart';
import '../tokens/lf_typography.dart';
import 'component/lf_accordion_theme_data.dart';
import 'component/lf_appbar_theme_data.dart';
import 'component/lf_badge_theme_data.dart';
import 'component/lf_bottomsheet_theme_data.dart';
import 'component/lf_button_theme_data.dart';
import 'component/lf_calendar_theme_data.dart';
import 'component/lf_checkbox_theme_data.dart';
import 'component/lf_chip_theme_data.dart';
import 'component/lf_dialog_theme_data.dart';
import 'component/lf_image_theme_data.dart';
import 'component/lf_indicator_theme_data.dart';
import 'component/lf_navigationbar_theme_data.dart';
import 'component/lf_notification_theme_data.dart';
import 'component/lf_picker_theme_data.dart';
import 'component/lf_radio_theme_data.dart';
import 'component/lf_ratingbar_theme_data.dart';
import 'component/lf_skeleton_theme_data.dart';
import 'component/lf_slider_theme_data.dart';
import 'component/lf_switch_theme_data.dart';
import 'component/lf_tabbar_theme_data.dart';
import 'component/lf_textfield_theme_data.dart';
import 'component/lf_toast_theme_data.dart';

class LFThemeData {
  final LFColors colors;
  final LFTypography typography;
  final LFSpacing spacing;
  final LFElevation elevation;
  final LFRadius radius;
  final LFDuration duration;

  // Component themes
  final LFButtonThemeData? buttonTheme;
  final LFAppBarThemeData? appBarTheme;
  final LFTextFieldThemeData? textFieldTheme;
  final LFDialogThemeData? dialogTheme;
  final LFCheckBoxThemeData? checkBoxTheme;
  final LFRadioThemeData? radioTheme;
  final LFChipThemeData? chipTheme;
  final LFSwitchThemeData? switchTheme;
  final LFTabBarThemeData? tabBarTheme;
  final LFBottomSheetThemeData? bottomSheetTheme;
  final LFBadgeThemeData? badgeTheme;
  final LFToastThemeData? toastTheme;
  final LFIndicatorThemeData? indicatorTheme;
  final LFSkeletonThemeData? skeletonTheme;
  final LFCalendarThemeData? calendarTheme;
  final LFNotificationThemeData? notificationTheme;
  final LFSliderThemeData? sliderTheme;
  final LFRatingBarThemeData? ratingBarTheme;
  final LFAccordionThemeData? accordionTheme;
  final LFImageThemeData? imageTheme;
  final LFNavigationBarThemeData? navigationBarTheme;
  final LFPickerThemeData? pickerTheme;

  const LFThemeData({
    required this.colors,
    required this.typography,
    required this.spacing,
    required this.elevation,
    required this.radius,
    required this.duration,
    this.buttonTheme,
    this.appBarTheme,
    this.textFieldTheme,
    this.dialogTheme,
    this.checkBoxTheme,
    this.radioTheme,
    this.chipTheme,
    this.switchTheme,
    this.tabBarTheme,
    this.bottomSheetTheme,
    this.badgeTheme,
    this.toastTheme,
    this.indicatorTheme,
    this.skeletonTheme,
    this.calendarTheme,
    this.notificationTheme,
    this.sliderTheme,
    this.ratingBarTheme,
    this.accordionTheme,
    this.imageTheme,
    this.navigationBarTheme,
    this.pickerTheme,
  });

  factory LFThemeData.light() {
    return LFThemeData(
      colors: LFColors.light(),
      typography: LFTypography.defaults(),
      spacing: LFSpacing.defaults(),
      elevation: LFElevation.defaults(),
      radius: LFRadius.defaults(),
      duration: LFDuration.defaults(),
    );
  }

  factory LFThemeData.dark() {
    return LFThemeData(
      colors: LFColors.dark(),
      typography: LFTypography.defaults(),
      spacing: LFSpacing.defaults(),
      elevation: LFElevation.defaults(),
      radius: LFRadius.defaults(),
      duration: LFDuration.defaults(),
    );
  }

  LFThemeData copyWith({
    LFColors? colors,
    LFTypography? typography,
    LFSpacing? spacing,
    LFElevation? elevation,
    LFRadius? radius,
    LFDuration? duration,
    LFButtonThemeData? buttonTheme,
    LFAppBarThemeData? appBarTheme,
    LFTextFieldThemeData? textFieldTheme,
    LFDialogThemeData? dialogTheme,
    LFCheckBoxThemeData? checkBoxTheme,
    LFRadioThemeData? radioTheme,
    LFChipThemeData? chipTheme,
    LFSwitchThemeData? switchTheme,
    LFTabBarThemeData? tabBarTheme,
    LFBottomSheetThemeData? bottomSheetTheme,
    LFBadgeThemeData? badgeTheme,
    LFToastThemeData? toastTheme,
    LFIndicatorThemeData? indicatorTheme,
    LFSkeletonThemeData? skeletonTheme,
    LFCalendarThemeData? calendarTheme,
    LFNotificationThemeData? notificationTheme,
    LFSliderThemeData? sliderTheme,
    LFRatingBarThemeData? ratingBarTheme,
    LFAccordionThemeData? accordionTheme,
    LFImageThemeData? imageTheme,
    LFNavigationBarThemeData? navigationBarTheme,
    LFPickerThemeData? pickerTheme,
  }) {
    return LFThemeData(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      elevation: elevation ?? this.elevation,
      radius: radius ?? this.radius,
      duration: duration ?? this.duration,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      appBarTheme: appBarTheme ?? this.appBarTheme,
      textFieldTheme: textFieldTheme ?? this.textFieldTheme,
      dialogTheme: dialogTheme ?? this.dialogTheme,
      checkBoxTheme: checkBoxTheme ?? this.checkBoxTheme,
      radioTheme: radioTheme ?? this.radioTheme,
      chipTheme: chipTheme ?? this.chipTheme,
      switchTheme: switchTheme ?? this.switchTheme,
      tabBarTheme: tabBarTheme ?? this.tabBarTheme,
      bottomSheetTheme: bottomSheetTheme ?? this.bottomSheetTheme,
      badgeTheme: badgeTheme ?? this.badgeTheme,
      toastTheme: toastTheme ?? this.toastTheme,
      indicatorTheme: indicatorTheme ?? this.indicatorTheme,
      skeletonTheme: skeletonTheme ?? this.skeletonTheme,
      calendarTheme: calendarTheme ?? this.calendarTheme,
      notificationTheme: notificationTheme ?? this.notificationTheme,
      sliderTheme: sliderTheme ?? this.sliderTheme,
      ratingBarTheme: ratingBarTheme ?? this.ratingBarTheme,
      accordionTheme: accordionTheme ?? this.accordionTheme,
      imageTheme: imageTheme ?? this.imageTheme,
      navigationBarTheme: navigationBarTheme ?? this.navigationBarTheme,
      pickerTheme: pickerTheme ?? this.pickerTheme,
    );
  }

  static LFThemeData lerp(LFThemeData a, LFThemeData b, double t) {
    return LFThemeData(
      colors: LFColors.lerp(a.colors, b.colors, t),
      typography: LFTypography.lerp(a.typography, b.typography, t),
      spacing: LFSpacing.lerp(a.spacing, b.spacing, t),
      elevation: t < 0.5 ? a.elevation : b.elevation,
      radius: LFRadius.lerp(a.radius, b.radius, t),
      duration: t < 0.5 ? a.duration : b.duration,
      buttonTheme: t < 0.5 ? a.buttonTheme : b.buttonTheme,
      appBarTheme: t < 0.5 ? a.appBarTheme : b.appBarTheme,
      textFieldTheme: t < 0.5 ? a.textFieldTheme : b.textFieldTheme,
      dialogTheme: t < 0.5 ? a.dialogTheme : b.dialogTheme,
      checkBoxTheme: t < 0.5 ? a.checkBoxTheme : b.checkBoxTheme,
      radioTheme: t < 0.5 ? a.radioTheme : b.radioTheme,
      chipTheme: t < 0.5 ? a.chipTheme : b.chipTheme,
      switchTheme: t < 0.5 ? a.switchTheme : b.switchTheme,
      tabBarTheme: t < 0.5 ? a.tabBarTheme : b.tabBarTheme,
      bottomSheetTheme: t < 0.5 ? a.bottomSheetTheme : b.bottomSheetTheme,
      badgeTheme: t < 0.5 ? a.badgeTheme : b.badgeTheme,
      toastTheme: t < 0.5 ? a.toastTheme : b.toastTheme,
      indicatorTheme: t < 0.5 ? a.indicatorTheme : b.indicatorTheme,
      skeletonTheme: t < 0.5 ? a.skeletonTheme : b.skeletonTheme,
      calendarTheme: t < 0.5 ? a.calendarTheme : b.calendarTheme,
      notificationTheme:
          t < 0.5 ? a.notificationTheme : b.notificationTheme,
      sliderTheme: t < 0.5 ? a.sliderTheme : b.sliderTheme,
      ratingBarTheme: t < 0.5 ? a.ratingBarTheme : b.ratingBarTheme,
      accordionTheme: t < 0.5 ? a.accordionTheme : b.accordionTheme,
      imageTheme: t < 0.5 ? a.imageTheme : b.imageTheme,
      navigationBarTheme:
          t < 0.5 ? a.navigationBarTheme : b.navigationBarTheme,
      pickerTheme: t < 0.5 ? a.pickerTheme : b.pickerTheme,
    );
  }
}
