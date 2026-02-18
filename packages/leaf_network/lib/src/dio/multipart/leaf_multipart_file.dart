import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:uuid/uuid.dart';

const kDefaultLeafAllowFiles = ['.jpg', '.jpeg', '.png'];

class LeafMultipartFile extends UIModelV2<String> {
  final Uri? uri;
  final XFile? xFile;
  final Uint8List? bytes;
  final String? fileName;

  const LeafMultipartFile({
    required super.payload,
    this.uri,
    this.xFile,
    this.bytes,
    this.fileName,
  }) : assert(
         uri != null || xFile != null || bytes != null,
         'At least one of uri, xFile, or bytes must be provided',
       );

  @override
  List<Object?> get props => [...super.props, uri, xFile, bytes, fileName];

  /// Factory

  factory LeafMultipartFile.fromUri(Uri uri, {String? payload}) {
    return LeafMultipartFile(
      payload: payload ?? const Uuid().v5(Namespace.url.value, uri.path),
      uri: uri,
    );
  }

  factory LeafMultipartFile.fromXFile(XFile xFile, {String? payload}) {
    return LeafMultipartFile(
      payload: payload ?? const Uuid().v5(Namespace.url.value, xFile.path),
      xFile: xFile,
    );
  }

  factory LeafMultipartFile.fromBytes(
    Uint8List bytes, {
    String? payload,
    required String fileName,
  }) {
    return LeafMultipartFile(
      payload: payload ?? const Uuid().v4(),
      bytes: bytes,
      fileName: fileName,
    );
  }

  /// Public

  Future<MultipartFile> toMultipartFile() async {
    final bytes = this.bytes;
    final fileName = this.fileName ?? getPayload();
    final contentType = MultipartFile.lookupMediaType(fileName);

    if (bytes != null) {
      return MultipartFile.fromBytes(
        bytes,
        filename: fileName,
        contentType: contentType,
      );
    }

    final path = getPath();
    if (path == null) {
      throw LeafMessageException('File Path is null');
    }
    return MultipartFile.fromFile(
      path,
      filename: fileName,
      contentType: contentType,
    );
  }

  Uri? getHttpUri() {
    return _isHttp() ? uri : null;
  }

  Future<Uint8List?> getFileBytes() async {
    final bytes = this.bytes;
    if (bytes != null) return bytes;
    final xFile = this.xFile;
    if (xFile == null) return null;
    try {
      final file = File(xFile.path);
      return await file.readAsBytes();
    } catch (e) {
      LeafLogging.e('getFileBytes Error: $e');
      return null;
    }
  }

  String? getExtension() {
    final uri = this.uri;
    final xFile = this.xFile;
    final fileName = this.fileName;
    if (uri != null) {
      return uri.extension();
    }
    if (xFile != null) {
      return xFile.path.extension();
    }
    if (fileName != null) {
      return fileName.extension();
    }
    return null;
  }

  String? getFileName() {
    final uri = this.uri;
    final xFile = this.xFile;
    final fileName = this.fileName;
    if (uri != null) {
      return uri.fileName();
    }
    if (xFile != null) {
      return xFile.path.fileName();
    }
    if (fileName != null) {
      return fileName.fileName();
    }
    return null;
  }

  String? getPath() {
    final uri = this.uri;
    final xFile = this.xFile;
    if (uri != null && !_isHttp()) {
      return uri.path;
    }
    if (xFile != null) {
      return xFile.path;
    }
    return null;
  }

  bool checkAllowExt([List<String> allowExt = kDefaultLeafAllowFiles]) =>
      allowExt.contains(getExtension());

  LeafMultipartFile? pipeCheckAllowExt([
    List<String> allowExt = kDefaultLeafAllowFiles,
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
}
