part of '../navigationbar.dart';

class LFBottomTabItem extends Equatable {
  final LFBottomTabIndex bottomTabIndex;
  final Widget? defaultIcon;
  final Widget? activeIcon;
  final String? text;
  final bool isNew;

  const LFBottomTabItem({
    required this.bottomTabIndex,
    required this.defaultIcon,
    this.activeIcon,
    this.text,
    this.isNew = false,
  });

  @override
  List<Object?> get props => [
        bottomTabIndex,
        defaultIcon,
        activeIcon,
        text,
        isNew,
      ];

  LFBottomTabItem copyWith({
    LFBottomTabIndex? bottomTabIndex,
    Widget? defaultIcon,
    Widget? activeIcon,
    String? text,
    bool? isNew,
  }) {
    return LFBottomTabItem(
      bottomTabIndex: bottomTabIndex ?? this.bottomTabIndex,
      defaultIcon: defaultIcon ?? this.defaultIcon,
      activeIcon: activeIcon ?? this.activeIcon,
      text: text ?? this.text,
      isNew: isNew ?? this.isNew,
    );
  }
}
