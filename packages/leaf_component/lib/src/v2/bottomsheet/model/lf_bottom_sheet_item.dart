part of lf_bottom_sheet;

class LFBottomSheetItem {
  final dynamic key;
  final String title;
  final bool enabled;

  LFBottomSheetItem({
    required this.key,
    required this.title,
    this.enabled = true,
  });
}
