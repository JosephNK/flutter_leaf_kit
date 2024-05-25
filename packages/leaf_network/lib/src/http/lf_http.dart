import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:http/http.dart' as http;

class LFHttp {
  Future<Uint8List?> resizeDownloadImage(
    Uri uri, {
    required int targetWidth,
    required int targetHeight,
  }) async {
    try {
      http.Response response = await http.get(uri);
      Uint8List originalUnit8List = response.bodyBytes;
      // ui.Image originalUiImage = await decodeImageFromList(originalUnit8List);
      // ByteData? originalByteData = await originalUiImage.toByteData();
      var codec = await ui.instantiateImageCodec(
        originalUnit8List,
        targetHeight: targetHeight,
        targetWidth: targetWidth,
      );
      var frameInfo = await codec.getNextFrame();
      ui.Image targetUiImage = frameInfo.image;
      ByteData? targetByteData =
          await targetUiImage.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? targetUint8List = targetByteData?.buffer.asUint8List();
      return targetUint8List;
    } catch (e) {
      rethrow;
    }
  }
}
