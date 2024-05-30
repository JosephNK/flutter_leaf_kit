part of '../navigationbar.dart';

class LFBottomTabItem extends Equatable {
  final LFBottomTabIndex bottomTabIndex;
  final Widget? defaultIcon;
  final Widget? activeIcon;
  final String? text;
  final int badgeCount;

  const LFBottomTabItem({
    required this.bottomTabIndex,
    required this.defaultIcon,
    this.activeIcon,
    this.text,
    this.badgeCount = 0,
  });

  @override
  List<Object?> get props => [
        bottomTabIndex,
        defaultIcon,
        activeIcon,
        text,
        badgeCount,
      ];

  LFBottomTabItem copyWith({
    LFBottomTabIndex? bottomTabIndex,
    Widget? defaultIcon,
    Widget? activeIcon,
    String? text,
    int? badgeCount,
  }) {
    return LFBottomTabItem(
      bottomTabIndex: bottomTabIndex ?? this.bottomTabIndex,
      defaultIcon: defaultIcon ?? this.defaultIcon,
      activeIcon: activeIcon ?? this.activeIcon,
      text: text ?? this.text,
      badgeCount: badgeCount ?? this.badgeCount,
    );
  }
}
