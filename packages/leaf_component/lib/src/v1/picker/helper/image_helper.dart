part of leaf_picker_component;

class LeafImageHelper {
  static Future<List<Uint8List>> conventMemoryData(List<dynamic> paths) async {
    var imageDatas = <Uint8List>[];
    if (paths is List<wechat.AssetEntity>) {
      for (var path in paths) {
        // final bytes = await path.originBytes;
        final filePath = await path.originFile;
        if (filePath != null) {
          final dataUint8List =
              await imgco.FlutterImageCompress.compressWithFile(
            filePath.absolute.path,
            quality: 100,
          );
          if (dataUint8List != null) {
            imageDatas.add(dataUint8List);
          }
        }
      }
    } else if (paths is List<PickedFile>) {
      final files = paths;
      for (var file in files) {
        final filePath = file.path;
        // final bytes = File(filePath).readAsBytesSync();
        final dataUint8List = await imgco.FlutterImageCompress.compressWithFile(
          filePath,
          quality: 100,
        );
        if (dataUint8List != null) {
          imageDatas.add(dataUint8List);
        }
      }
    } else if (paths is List<String>) {
      for (var path in paths) {
        // final rotatedImage = await FlutterExifRotation.rotateImage(path: path);
        // final dataUint8List = File(rotatedImage.path).readAsBytesSync();
        final dataUint8List = await imgco.FlutterImageCompress.compressWithFile(
          path,
          quality: 100,
        );
        if (dataUint8List != null) {
          imageDatas.add(dataUint8List);
        }
      }
    } else if (paths is List<Uint8List>) {
      return paths;
    }
    return imageDatas;
  }

  static Future<Size> calculateImageDimension() {
    var completer = Completer<Size>();
    var image = const Image(
      image: CachedNetworkImageProvider('https://i.stack.imgur.com/lkd0a.png'),
    ); // I modified this line
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          var size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }

  static Future<void> imageStorageSave(List<Uint8List> bytes) async {
    final r = (Platform.isIOS)
        ? true
        : await LFPermission.isGrantedPermission(
            permissionType: LFPermissionType.storage,
          );
    if (r) {
      for (var byte in bytes) {
        Uint8List? imageBytes;
        if (Platform.isAndroid) {
          // https://stackoverflow.com/a/62807277
          final capturedImage = img.decodeImage(byte);
          if (capturedImage != null) {
            final orientedImage = img.bakeOrientation(capturedImage);
            imageBytes = Uint8List.fromList(img.encodeJpg(orientedImage));
          }
        } else {
          imageBytes = Uint8List.fromList(byte);
        }
        if (imageBytes != null) {
          // ignore: no_leading_underscores_for_local_identifiers
          final _ = await ImageGallerySaver.saveImage(
            imageBytes,
            quality: 90,
          );
        }
      }
    }
  }

// ref., https://roszkowski.dev/2020/rotate-image-from-camera-in-flutter/
// static Future<Uint8List> fixExifRotation(Uint8List byte) async {
//   final originalImage = img.decodeImage(byte);
//   final height = originalImage.height;
//   final width = originalImage.width;
//   // Let's check for the image size
//   if (height >= width) {
//     // I'm interested in portrait photos so
//     // I'll just return here
//     return byte;
//   }
//   // We'll use the exif package to read exif data
//   // This is map of several exif properties
//   // Let's check 'Image Orientation'
//   final exifData = await readExifFromBytes(byte);
//   img.Image fixedImage;
//   if (height < width) {
//     final orientation = exifData['Image Orientation'];
//     // rotate
//     if (orientation.printable.contains('Horizontal')) {
//       fixedImage = img.copyRotate(originalImage, 90);
//     } else if (orientation.printable.contains('180')) {
//       fixedImage = img.copyRotate(originalImage, -90);
//     } else {
//       fixedImage = img.copyRotate(originalImage, 0);
//     }
//   }
//   // Here you can select whether you'd like to save it as png
//   // or jpg with some compression
//   // I choose jpg with 100% quality
//   return img.encodeJpg(fixedImage);
// }
}
