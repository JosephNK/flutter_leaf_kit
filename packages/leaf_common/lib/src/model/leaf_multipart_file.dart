import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:uuid/uuid.dart';

import '../../leaf_common.dart';

const kAllowFiles = ['.jpg', '.jpeg', '.png'];

class LeafMultipartFile extends UIModelV2<String> {
  final Uri? uri;
  final XFile? xFile;

  const LeafMultipartFile({
    required super.payload,
    required this.uri,
    required this.xFile,
  });

  @override
  List<Object?> get props => [
        super.props,
        uri,
        xFile,
      ];

  Uri? getHttpUri() {
    return _isHttp() ? uri : null;
  }

  Uint8List? getFileBytes() {
    final xFile = this.xFile;
    if (xFile == null) return null;
    try {
      final file = File(xFile.path);
      return file.readAsBytesSync();
    } catch (e) {
      Logging.e('getFileBytes Error: $e');
      return null;
    }
  }

  String? getExtension() {
    final uri = this.uri;
    final xFile = this.xFile;
    if (uri != null) {
      return uri.extension();
    }
    if (xFile != null) {
      return xFile.path.extension();
    }
    return null;
  }

  String? getFileName() {
    final uri = this.uri;
    final xFile = this.xFile;
    if (uri != null) {
      return uri.fileName();
    }
    if (xFile != null) {
      return xFile.path.fileName();
    }
    return null;
  }

  String? getPath() {
    final uri = this.uri;
    final xFile = this.xFile;
    if (uri != null) {
      return uri.path;
    }
    if (xFile != null) {
      return xFile.path;
    }
    return null;
  }

  bool checkAllowExt([
    List<String> allowExt = kAllowFiles,
  ]) {
    final ext = getExtension();
    if (!allowExt.contains(ext)) {
      return false;
    }
    return true;
  }

  LeafMultipartFile? pipeCheckAllowExt([
    List<String> allowExt = kAllowFiles,
  ]) {
    if (!checkAllowExt(allowExt)) {
      return null;
    }
    return this;
  }

  /// Private

  bool _isHttp() {
    final uri = this.uri;
    if (uri == null) return false;
    final scheme = uri.scheme.toLowerCase();
    return scheme == 'http' || scheme == 'https';
  }

  /// Factory

  factory LeafMultipartFile.fromUri(Uri uri, {String? payload}) {
    return LeafMultipartFile(
      payload: payload ?? const Uuid().v5(Namespace.url.value, uri.path),
      uri: uri,
      xFile: null,
    );
  }

  factory LeafMultipartFile.fromXFile(XFile xFile, {String? payload}) {
    return LeafMultipartFile(
      payload: payload ?? const Uuid().v5(Namespace.url.value, xFile.path),
      uri: null,
      xFile: xFile,
    );
  }
}
