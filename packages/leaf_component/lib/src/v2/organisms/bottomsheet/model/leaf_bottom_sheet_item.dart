import 'package:flutter/foundation.dart';

/// A data model for a bottom sheet action item.
@immutable
class LeafBottomSheetItem<T> {
  final T? key;
  final String title;
  final bool enabled;

  const LeafBottomSheetItem({
    this.key,
    required this.title,
    this.enabled = true,
  });
}
