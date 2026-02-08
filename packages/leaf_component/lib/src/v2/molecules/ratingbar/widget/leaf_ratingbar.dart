import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../common/theme/leaf_theme.dart';

/// A themed star-rating bar.
///
/// Wraps [RatingBar] from `flutter_rating_bar` with 3-level cascade theming.
class LeafRatingBar extends StatelessWidget {
  final int itemCount;
  final RatingWidget? ratingWidget;
  final double initialRating;
  final double minRating;
  final EdgeInsets? itemPadding;
  final double? itemSize;
  final bool tapOnlyMode;
  final bool updateOnDrag;
  final bool ignoreGestures;
  final bool allowHalfRating;
  final Color? ratedColor;
  final Color? unratedColor;
  final ValueChanged<double> onRatingUpdate;

  const LeafRatingBar({
    super.key,
    required this.itemCount,
    required this.onRatingUpdate,
    this.ratingWidget,
    this.initialRating = 0.0,
    this.minRating = 0.0,
    this.itemPadding,
    this.itemSize,
    this.tapOnlyMode = false,
    this.updateOnDrag = false,
    this.ignoreGestures = false,
    this.allowHalfRating = true,
    this.ratedColor,
    this.unratedColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final ratingTheme = theme.ratingBarTheme;

    final resolvedRated =
        ratedColor ?? ratingTheme?.ratedColor ?? colors.warning;
    final resolvedUnrated =
        unratedColor ?? ratingTheme?.unratedColor ?? colors.inactive;
    final resolvedSize = itemSize ?? ratingTheme?.size ?? 40.0;
    final resolvedPadding =
        itemPadding ??
        EdgeInsets.symmetric(horizontal: ratingTheme?.spacing ?? 0.0);

    return Semantics(
      label: 'Rating',
      value: '${initialRating.toStringAsFixed(1)} of $itemCount',
      child: RatingBar(
        initialRating: initialRating,
        minRating: minRating,
        direction: Axis.horizontal,
        allowHalfRating: allowHalfRating,
        itemCount: itemCount,
        itemSize: resolvedSize,
        itemPadding: resolvedPadding,
        tapOnlyMode: tapOnlyMode,
        updateOnDrag: updateOnDrag,
        ignoreGestures: ignoreGestures,
        ratingWidget:
            ratingWidget ??
            RatingWidget(
              full: Icon(Icons.star, color: resolvedRated),
              half: Icon(Icons.star_half, color: resolvedRated),
              empty: Icon(Icons.star_border, color: resolvedUnrated),
            ),
        onRatingUpdate: onRatingUpdate,
      ),
    );
  }
}
