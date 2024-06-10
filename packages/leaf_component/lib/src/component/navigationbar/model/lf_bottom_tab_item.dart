part of '../navigationbar.dart';

class LFBottomTabItem extends Equatable {
  final LFBottomTabIndex bottomTabIndex;
  final Widget? defaultIcon;
  final Widget? activeIcon;
  final String? text;
  final TextStyle? defaultTextStyle;
  final TextStyle? activeTextStyle;
  final int badgeCount;
  final Alignment? badgeAlignment;

  const LFBottomTabItem({
    required this.bottomTabIndex,
    required this.defaultIcon,
    this.activeIcon,
    this.text,
    this.defaultTextStyle,
    this.activeTextStyle,
    this.badgeCount = 0,
    this.badgeAlignment,
  });

  @override
  List<Object?> get props => [
        bottomTabIndex,
        defaultIcon,
        activeIcon,
        text,
        defaultTextStyle,
        activeTextStyle,
        badgeCount,
        badgeAlignment,
      ];

  LFBottomTabItem copyWith({
    LFBottomTabIndex? bottomTabIndex,
    Widget? defaultIcon,
    Widget? activeIcon,
    String? text,
    TextStyle? defaultTextStyle,
    TextStyle? activeTextStyle,
    int? badgeCount,
    Alignment? badgeAlignment,
  }) {
    return LFBottomTabItem(
      bottomTabIndex: bottomTabIndex ?? this.bottomTabIndex,
      defaultIcon: defaultIcon ?? this.defaultIcon,
      activeIcon: activeIcon ?? this.activeIcon,
      text: text ?? this.text,
      defaultTextStyle: defaultTextStyle ?? this.defaultTextStyle,
      activeTextStyle: activeTextStyle ?? this.activeTextStyle,
      badgeCount: badgeCount ?? this.badgeCount,
      badgeAlignment: badgeAlignment ?? this.badgeAlignment,
    );
  }
}
