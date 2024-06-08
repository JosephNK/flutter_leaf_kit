part of '../ratingbar.dart';

class LFRatingBar extends StatelessWidget {
  final int itemCount;
  final double initialRating;
  final double minRating;
  final Widget? iconWidget;
  final RatingWidget? ratingWidget;
  final EdgeInsets? itemPadding;
  final ValueChanged<double>? onRatingUpdate;

  const LFRatingBar({
    super.key,
    required this.itemCount,
    this.initialRating = 0.0,
    this.minRating = 0.0,
    this.iconWidget,
    this.ratingWidget,
    this.itemPadding,
    this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    if (ratingWidget != null) {
      return RatingBar(
        initialRating: initialRating,
        minRating: minRating,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: itemCount,
        itemPadding: itemPadding ?? const EdgeInsets.symmetric(horizontal: 4.0),
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
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: minRating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: itemCount,
      itemPadding: itemPadding ?? const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) {
        return iconWidget ?? const Icon(Icons.star, color: Colors.red);
      },
      onRatingUpdate: (rating) {
        onRatingUpdate?.call(rating);
      },
    );
  }
}
