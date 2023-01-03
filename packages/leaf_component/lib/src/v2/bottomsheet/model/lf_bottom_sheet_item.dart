part of lf_bottom_sheet;

class LFBottomSheetItem<T> {
  T? key;
  String title;
  bool enabled;

  LFBottomSheetItem({
    this.key,
    required this.title,
    this.enabled = true,
  }) {
    // key = key ?? UniqueKey();
  }
}
