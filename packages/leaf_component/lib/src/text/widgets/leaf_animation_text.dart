part of leaf_text_component;

class LeafAnimationText extends StatelessWidget {
  final String? title;
  final TextStyle? textStyle;
  final VoidCallback? onFinished;

  const LeafAnimationText({
    Key? key,
    this.title,
    this.textStyle,
    this.onFinished,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText(
            title ?? '',
            textStyle: GoogleFonts.lateef(
              textStyle: textStyle ??
                  const TextStyle(
                    color: Colors.black,
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
        isRepeatingAnimation: false,
        repeatForever: false,
        onFinished: () {
          onFinished?.call();
        },
      ),
    );
  }
}
