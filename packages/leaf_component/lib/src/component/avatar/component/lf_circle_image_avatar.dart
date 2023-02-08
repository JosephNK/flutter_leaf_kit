part of lf_avatar;

class LFCircleImageAvatar extends StatelessWidget {
  final Object? image; // String, Uint8List
  final double size;
  final Color borderColor;
  final double borderWidth;
  final Map<String, String>? header;
  final BoxFit fit;

  const LFCircleImageAvatar({
    Key? key,
    required this.image,
    this.size = 50,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.header,
    this.fit = BoxFit.cover,
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
          child: _buildImageWidget(),
        ),
      ),
    );
  }

  Widget? _buildImageWidget() {
    final image = this.image;

    if (image is String) {
      if (isEmpty(image)) {
        return Container();
      } else {
        if (isURL(image)) {
          return LFCacheImage(
            header: header,
            url: image,
            width: size,
            height: size,
            fit: fit,
          );
        } else {
          return Image(image: AssetImage(image), fit: fit);
        }
      }
    } else if (image is Uint8List) {
      return Image.memory(image, fit: fit);
    }

    return null;
  }
}
