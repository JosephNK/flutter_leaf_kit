import 'package:dio/dio.dart';
import 'package:flutter_leaf_store/leaf_store.dart';
import 'package:http_parser/http_parser.dart';

enum HttpDioMediaMimeType {
  image,
}

extension HttpDioMediaMimeTypeExt on HttpDioMediaMimeType {
  String get value {
    switch (this) {
      case HttpDioMediaMimeType.image:
        return 'image';
    }
  }
}

class HttpDioHelper {
  MultipartFile? convertFromFile(
    LFMultipartFile file, {
    HttpDioMediaMimeType mediaMimeType = HttpDioMediaMimeType.image,
  }) {
    final path = file.getPath();
    final ext = file.getExtension();
    if (path == null || ext == null) return null;
    final extension = ((ext == '.jpg') ? '.jpeg' : ext).replaceAll('.', '');
    final fileName = file.getPayload<String>();
    return MultipartFile.fromFileSync(
      path,
      filename: '$fileName.$extension',
      contentType: MediaType(mediaMimeType.value, extension),
    );
  }
}
