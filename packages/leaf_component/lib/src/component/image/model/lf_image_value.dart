part of '../lf_image.dart';

class LFImageValue extends Equatable {
  final String? file; // Url, FilePath, AssetPath
  final String? thumbFile; // Url, FilePath, AssetPath
  final Uint8List? bytes;
  final Map<String, String>? header;

  const LFImageValue({
    this.file,
    this.thumbFile,
    this.bytes,
    this.header,
  });

  @override
  List<Object?> get props => [
        file,
        thumbFile,
        bytes,
        header,
      ];

  @override
  String toString() {
    return '$runtimeType(${props.map((prop) {
      if (prop is Uint8List) {
        return prop.length.toString();
      }
      return prop.toString();
    }).join(', ')})';
  }

  LFImageValue copyWith({
    String? Function()? file,
    Uint8List? Function()? bytes,
    String? Function()? thumbFile,
    Map<String, String>? Function()? header,
  }) =>
      LFImageValue(
        file: file != null ? file() : this.file,
        bytes: bytes != null ? bytes() : this.bytes,
        thumbFile: thumbFile != null ? thumbFile() : this.thumbFile,
        header: header != null ? header() : this.header,
      );
}
