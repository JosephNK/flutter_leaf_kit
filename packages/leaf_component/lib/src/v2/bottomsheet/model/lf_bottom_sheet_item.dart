part of lf_bottom_sheet;

class LFBottomSheetItem {
  Object? key;
  String title;
  bool enabled;

  LFBottomSheetItem({
    this.key,
    required this.title,
    this.enabled = true,
  }) {
    key = key ?? UniqueKey();
  }
}
