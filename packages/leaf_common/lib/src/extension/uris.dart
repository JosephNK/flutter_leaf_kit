part of '../lf_common.dart';

extension UriPath on Uri {
  String extension() {
    return p.extension(path);
  }

  String fileName() {
    return p.basename(path);
  }
}
