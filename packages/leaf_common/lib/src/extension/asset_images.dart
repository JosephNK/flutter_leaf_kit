part of '../lf_common.dart';

extension AssetImageHelper on AssetImage {
  Future<Map<String, dynamic>> getAsyncSize() async {
    final Image image = Image(image: this);
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo image, bool _) {
      completer.complete(image.image);
    }));
    ui.Image info = await completer.future;
    double width = info.width.toDouble();
    double height = info.height.toDouble();
    return {'asset': this, 'width': width, 'height': height};
  }
}
