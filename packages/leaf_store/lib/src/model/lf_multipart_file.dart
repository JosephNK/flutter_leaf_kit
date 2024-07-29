part of '../../leaf_store.dart';

class LFMultipartFile extends UIModel {
  final Uri? uri;

  const LFMultipartFile({
    required super.payload,
    required this.uri,
  });

  @override
  List<Object?> get props => [
        payload,
        uri,
      ];

  @override
  T? getPayload<T>() {
    return payload as T?;
  }

  Uri? getHttpUri() {
    return _isHttp() ? uri : null;
  }

  File? getFile({bool isRemoveScheme = true}) {
    final uri = this.uri;
    if (uri == null || _isHttp()) return null;
    try {
      String path = uri.path;
      if (isRemoveScheme) {
        final schemes = ['file://'];
        for (var scheme in schemes) {
          path = path.replaceAll(scheme, '');
        }
      }
      final file = File(path);
      return file;
    } catch (e) {
      Logging.e('getFile Error: $e');
      return null;
    }
  }

  Uint8List? getFileBytes({bool isRemoveScheme = true}) {
    final file = getFile(isRemoveScheme: isRemoveScheme);
    if (file == null) return null;
    try {
      return file.readAsBytesSync();
    } catch (e) {
      Logging.e('getFileBytes Error: $e');
      return null;
    }
  }

  String? getExtension() {
    final uri = this.uri;
    if (uri == null) return null;
    return uri.extension();
  }

  String? getFileName() {
    final uri = this.uri;
    if (uri == null) return null;
    return uri.fileName();
  }

  bool _isHttp() {
    final uri = this.uri;
    if (uri == null) return false;
    final scheme = uri.scheme;
    return scheme == 'http' || scheme == 'https';
  }

  factory LFMultipartFile.fromUri(Uri uri, {Object? payload}) {
    return LFMultipartFile(
      payload: payload ?? const Uuid().v5(Uuid.NAMESPACE_URL, uri.path),
      uri: uri,
    );
  }

  factory LFMultipartFile.fromFile(File file, {Object? payload}) {
    return LFMultipartFile(
      payload: payload ?? const Uuid().v5(Uuid.NAMESPACE_URL, file.path),
      uri: Uri.file(file.path),
    );
  }
}
