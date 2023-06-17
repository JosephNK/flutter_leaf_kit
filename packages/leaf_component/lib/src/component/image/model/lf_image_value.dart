part of lf_image;

class LFImageValue extends Equatable {
  final String? file;
  final Uint8List? bytes;
  final String? thumbFile;

  const LFImageValue({this.file, this.bytes, this.thumbFile});

  @override
  List<Object?> get props => [
        file,
        bytes,
        thumbFile,
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
  }) =>
      LFImageValue(
        file: file != null ? file() : this.file,
        bytes: bytes != null ? bytes() : this.bytes,
        thumbFile: thumbFile != null ? thumbFile() : this.thumbFile,
      );
}
