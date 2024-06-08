part of '../ratingbar.dart';

class LFRatingBar extends StatelessWidget {
  final int itemCount;
  final RatingWidget? ratingWidget;
  final double initialRating;
  final double minRating;
  final EdgeInsets itemPadding;
  final double itemSize;
  final bool tapOnlyMode;
  final bool updateOnDrag;
  final ValueChanged<double>? onRatingUpdate;

  const LFRatingBar({
    super.key,
    required this.itemCount,
    this.ratingWidget,
    this.initialRating = 0.0,
    this.minRating = 0.0,
    this.itemPadding = EdgeInsets.zero,
    this.itemSize = 40.0,
    this.tapOnlyMode = false,
    this.updateOnDrag = false,
    this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final ratingWidget = this.ratingWidget;

    return RatingBar(
      initialRating: initialRating,
      minRating: minRating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: itemCount,
      itemSize: itemSize,
      itemPadding: itemPadding,
      tapOnlyMode: tapOnlyMode,
      updateOnDrag: updateOnDrag,
      ratingWidget: ratingWidget ??
          RatingWidget(
            full: const Icon(Icons.star, color: Colors.red),
            half: const Icon(Icons.star_half, color: Colors.red),
            empty: const Icon(Icons.star_border, color: Colors.red),
          ),
      onRatingUpdate: (rating) {
        onRatingUpdate?.call(rating);
      },
    );
  }
}
