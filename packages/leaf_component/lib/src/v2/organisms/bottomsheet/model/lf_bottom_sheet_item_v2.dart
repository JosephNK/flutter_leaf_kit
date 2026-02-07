import 'package:flutter/foundation.dart';

/// A data model for a bottom sheet action item.
@immutable
class LFBottomSheetItemV2<T> {
  final T? key;
  final String title;
  final bool enabled;

  const LFBottomSheetItemV2({
    this.key,
    required this.title,
    this.enabled = true,
  });
}
