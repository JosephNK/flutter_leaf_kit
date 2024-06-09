part of '../../leaf_store.dart';

abstract class LFMultipartFile extends UIModel {
  final Uri? uri;
  final File? file;

  const LFMultipartFile({
    required super.payload,
    required this.uri,
    required this.file,
  });

  @override
  List<Object?> get props => [
        payload,
        uri,
        file,
      ];

  @override
  T? getPayload<T>() {
    throw UnimplementedError();
  }

  Uint8List? getBytes() {
    if (file != null) {
      return file!.readAsBytesSync();
    }
    return null;
  }
}
