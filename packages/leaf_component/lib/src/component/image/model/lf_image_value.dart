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
}
