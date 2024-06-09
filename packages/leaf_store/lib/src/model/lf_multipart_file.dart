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
    throw UnimplementedError();
  }

  Uri? getHttpUri() {
    final uri = this.uri;
    if (uri == null) return null;
    String scheme = uri.scheme;
    if (scheme == 'http' || scheme == 'https') {
      return uri;
    }
    return null;
  }

  File? getFile() {
    final uri = this.uri;
    if (uri == null) return null;
    final file = File(uri.path);
    return file;
  }

  Uint8List? getFileBytes() {
    final file = getFile();
    if (file == null) return null;
    return file.readAsBytesSync();
  }

  factory LFMultipartFile.fromUri(Uri uri) {
    return LFMultipartFile(
      payload: const Uuid().v5(Uuid.NAMESPACE_URL, uri.path),
      uri: uri,
    );
  }

  factory LFMultipartFile.fromFile(File file) {
    return LFMultipartFile(
      payload: const Uuid().v5(Uuid.NAMESPACE_URL, file.path),
      uri: Uri.file(file.path),
    );
  }
}
