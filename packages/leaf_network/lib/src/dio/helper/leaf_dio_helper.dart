import 'package:dio/dio.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:http_parser/http_parser.dart';

enum LeafDioMediaMimeType { image }

extension LeafDioMediaMimeTypeExt on LeafDioMediaMimeType {
  String get value {
    switch (this) {
      case LeafDioMediaMimeType.image:
        return 'image';
    }
  }
}

class LeafDioHelper {
  MultipartFile convertFromFile(
    LeafMultipartFile file, {
    LeafDioMediaMimeType mediaMimeType = LeafDioMediaMimeType.image,
  }) {
    final path = file.getPath();
    final ext = file.getExtension();
    if (path == null || ext == null) {
      throw LeafMessageException('File Path or Ext is null');
    }
    final extension = ((ext == '.jpg') ? '.jpeg' : ext).replaceAll('.', '');
    final fileName = file.getPayload();
    return MultipartFile.fromFileSync(
      path,
      filename: '$fileName.$extension',
      contentType: MediaType(mediaMimeType.value, extension),
    );
  }
}
