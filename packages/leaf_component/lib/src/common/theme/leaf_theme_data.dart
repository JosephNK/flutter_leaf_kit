import '../tokens/leaf_colors.dart';
import '../tokens/leaf_duration.dart';
import '../tokens/leaf_elevation.dart';
import '../tokens/leaf_radius.dart';
import '../tokens/leaf_spacing.dart';
import '../tokens/leaf_typography.dart';
import 'component/leaf_accordion_theme_data.dart';
import 'component/leaf_appbar_theme_data.dart';
import 'component/leaf_badge_theme_data.dart';
import 'component/leaf_bottomsheet_theme_data.dart';
import 'component/leaf_button_theme_data.dart';
import 'component/leaf_calendar_theme_data.dart';
import 'component/leaf_checkbox_theme_data.dart';
import 'component/leaf_chip_theme_data.dart';
import 'component/leaf_dialog_theme_data.dart';
import 'component/leaf_image_theme_data.dart';
import 'component/leaf_indicator_theme_data.dart';
import 'component/leaf_navigationbar_theme_data.dart';
import 'component/leaf_notification_theme_data.dart';
import 'component/leaf_page_view_theme_data.dart';
import 'component/leaf_picker_theme_data.dart';
import 'component/leaf_radio_theme_data.dart';
import 'component/leaf_ratingbar_theme_data.dart';
import 'component/leaf_skeleton_theme_data.dart';
import 'component/leaf_slider_theme_data.dart';
import 'component/leaf_switch_theme_data.dart';
import 'component/leaf_tabbar_theme_data.dart';
import 'component/leaf_textfield_theme_data.dart';
import 'component/leaf_toast_theme_data.dart';

class LeafThemeData {
  final LeafColors colors;
  final LeafTypography typography;
  final LeafSpacing spacing;
  final LeafElevation elevation;
  final LeafRadius radius;
  final LeafDuration duration;

  // Component themes
  final LeafButtonThemeData? buttonTheme;
  final LeafAppBarThemeData? appBarTheme;
  final LeafTextFieldThemeData? textFieldTheme;
  final LeafDialogThemeData? dialogTheme;
  final LeafCheckBoxThemeData? checkBoxTheme;
  final LeafRadioThemeData? radioTheme;
  final LeafChipThemeData? chipTheme;
  final LeafSwitchThemeData? switchTheme;
  final LeafTabBarThemeData? tabBarTheme;
  final LeafBottomSheetThemeData? bottomSheetTheme;
  final LeafBadgeThemeData? badgeTheme;
  final LeafToastThemeData? toastTheme;
  final LeafIndicatorThemeData? indicatorTheme;
  final LeafSkeletonThemeData? skeletonTheme;
  final LeafCalendarThemeData? calendarTheme;
  final LeafNotificationThemeData? notificationTheme;
  final LeafSliderThemeData? sliderTheme;
  final LeafRatingBarThemeData? ratingBarTheme;
  final LeafAccordionThemeData? accordionTheme;
  final LeafImageThemeData? imageTheme;
  final LeafNavigationBarThemeData? navigationBarTheme;
  final LeafPageViewThemeData? pageViewTheme;
  final LeafPickerThemeData? pickerTheme;

  const LeafThemeData({
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
    this.pageViewTheme,
    this.pickerTheme,
  });

  factory LeafThemeData.light() {
    return LeafThemeData(
      colors: LeafColors.light(),
      typography: LeafTypography.defaults(),
      spacing: LeafSpacing.defaults(),
      elevation: LeafElevation.defaults(),
      radius: LeafRadius.defaults(),
      duration: LeafDuration.defaults(),
    );
  }

  factory LeafThemeData.dark() {
    return LeafThemeData(
      colors: LeafColors.dark(),
      typography: LeafTypography.defaults(),
      spacing: LeafSpacing.defaults(),
      elevation: LeafElevation.defaults(),
      radius: LeafRadius.defaults(),
      duration: LeafDuration.defaults(),
    );
  }

  LeafThemeData copyWith({
    LeafColors? colors,
    LeafTypography? typography,
    LeafSpacing? spacing,
    LeafElevation? elevation,
    LeafRadius? radius,
    LeafDuration? duration,
    LeafButtonThemeData? buttonTheme,
    LeafAppBarThemeData? appBarTheme,
    LeafTextFieldThemeData? textFieldTheme,
    LeafDialogThemeData? dialogTheme,
    LeafCheckBoxThemeData? checkBoxTheme,
    LeafRadioThemeData? radioTheme,
    LeafChipThemeData? chipTheme,
    LeafSwitchThemeData? switchTheme,
    LeafTabBarThemeData? tabBarTheme,
    LeafBottomSheetThemeData? bottomSheetTheme,
    LeafBadgeThemeData? badgeTheme,
    LeafToastThemeData? toastTheme,
    LeafIndicatorThemeData? indicatorTheme,
    LeafSkeletonThemeData? skeletonTheme,
    LeafCalendarThemeData? calendarTheme,
    LeafNotificationThemeData? notificationTheme,
    LeafSliderThemeData? sliderTheme,
    LeafRatingBarThemeData? ratingBarTheme,
    LeafAccordionThemeData? accordionTheme,
    LeafImageThemeData? imageTheme,
    LeafNavigationBarThemeData? navigationBarTheme,
    LeafPageViewThemeData? pageViewTheme,
    LeafPickerThemeData? pickerTheme,
  }) {
    return LeafThemeData(
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
      pageViewTheme: pageViewTheme ?? this.pageViewTheme,
      pickerTheme: pickerTheme ?? this.pickerTheme,
    );
  }

  static LeafThemeData lerp(LeafThemeData a, LeafThemeData b, double t) {
    return LeafThemeData(
      colors: LeafColors.lerp(a.colors, b.colors, t),
      typography: LeafTypography.lerp(a.typography, b.typography, t),
      spacing: LeafSpacing.lerp(a.spacing, b.spacing, t),
      elevation: t < 0.5 ? a.elevation : b.elevation,
      radius: LeafRadius.lerp(a.radius, b.radius, t),
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
      notificationTheme: t < 0.5 ? a.notificationTheme : b.notificationTheme,
      sliderTheme: t < 0.5 ? a.sliderTheme : b.sliderTheme,
      ratingBarTheme: t < 0.5 ? a.ratingBarTheme : b.ratingBarTheme,
      accordionTheme: t < 0.5 ? a.accordionTheme : b.accordionTheme,
      imageTheme: t < 0.5 ? a.imageTheme : b.imageTheme,
      navigationBarTheme: t < 0.5 ? a.navigationBarTheme : b.navigationBarTheme,
      pageViewTheme: t < 0.5 ? a.pageViewTheme : b.pageViewTheme,
      pickerTheme: t < 0.5 ? a.pickerTheme : b.pickerTheme,
    );
  }
}
