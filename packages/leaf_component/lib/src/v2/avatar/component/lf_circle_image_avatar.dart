part of lf_avatar;

class LFCircleImageAvatar extends StatelessWidget {
  final String image;
  final double size;
  final Color borderColor;
  final double borderWidth;
  final Map<String, String>? header;

  const LFCircleImageAvatar({
    Key? key,
    required this.image,
    this.size = 50,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0), // Border width
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(size), // Image radius
          child: isURL(image)
              ? LFCacheImage(
                  header: header,
                  url: image,
                  width: size,
                  height: size,
                  fit: BoxFit.cover)
              : Image(image: AssetImage(image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
