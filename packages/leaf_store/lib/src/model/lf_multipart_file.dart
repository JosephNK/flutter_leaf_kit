part of '../../leaf_store.dart';

class LFMultipartFile extends UIModel {
  final Uri? uri;
  final XFile? xFile;

  const LFMultipartFile({
    required super.payload,
    required this.uri,
    required this.xFile,
  });

  @override
  List<Object?> get props => [
        payload,
        uri,
        xFile,
      ];

  @override
  T? getPayload<T>() {
    return payload as T?;
  }

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
    List<String> allowExt = const ['.jpg', '.jpeg', '.png'],
  ]) {
    final ext = getExtension();
    if (!allowExt.contains(ext)) {
      return false;
    }
    return true;
  }

  LFMultipartFile? pipeCheckAllowExt([
    List<String> allowExt = const ['.jpg', '.jpeg', '.png'],
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

  factory LFMultipartFile.fromUri(Uri uri, {Object? payload}) {
    return LFMultipartFile(
      payload: payload ?? const Uuid().v5(Uuid.NAMESPACE_URL, uri.path),
      uri: uri,
      xFile: null,
    );
  }

  factory LFMultipartFile.fromXFile(XFile xFile, {Object? payload}) {
    return LFMultipartFile(
      payload: payload ?? const Uuid().v5(Uuid.NAMESPACE_URL, xFile.path),
      uri: null,
      xFile: xFile,
    );
  }
}
