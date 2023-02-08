part of lf_rate;

class LFRate extends StatelessWidget {
  final int itemCount;
  final double initialRating;
  final double minRating;
  final Widget? icon;
  final ValueChanged<double>? onRatingUpdate;

  const LFRate({
    Key? key,
    required this.itemCount,
    this.initialRating = 0.0,
    this.minRating = 0.0,
    this.icon,
    this.onRatingUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: minRating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: itemCount,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) =>
          icon ??
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
      onRatingUpdate: (rating) {
        onRatingUpdate?.call(rating);
      },
    );
  }
}
