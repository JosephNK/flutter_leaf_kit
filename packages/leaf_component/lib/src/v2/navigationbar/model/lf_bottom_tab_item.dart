part of lf_navigationbar;

class LFBottomTabItem extends Equatable {
  final LFBottomTabIndex bottomTabIndex;
  final Widget? icon;
  final String? text;
  final bool isNew;

  const LFBottomTabItem({
    required this.bottomTabIndex,
    required this.icon,
    this.text,
    this.isNew = false,
  });

  @override
  List<Object?> get props => [
        bottomTabIndex,
        icon,
        text,
        isNew,
      ];

  LFBottomTabItem copyWith({
    LFBottomTabIndex? bottomTabIndex,
    Widget? icon,
    String? text,
    bool? isNew,
  }) {
    return LFBottomTabItem(
      bottomTabIndex: bottomTabIndex ?? this.bottomTabIndex,
      icon: icon ?? this.icon,
      text: text ?? this.text,
      isNew: isNew ?? this.isNew,
    );
  }
}
