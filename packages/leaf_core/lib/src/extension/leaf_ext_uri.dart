import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

extension UriExt on Uri {
  Uri appendPath(String path) {
    try {
      final pathUri = Uri.parse(path);
      final pathScheme = pathUri.scheme.toLowerCase();
      if (pathScheme == 'https' || pathScheme == 'http') {
        return pathUri;
      }
      return Uri.parse(toString() + path);
    } catch (e) {
      debugPrint('e: $e');
      return this;
    }
  }
}

extension UriPath on Uri {
  String extension() {
    return p.extension(path);
  }

  String fileName() {
    return p.basename(path);
  }
}
