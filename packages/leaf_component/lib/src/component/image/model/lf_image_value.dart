part of lf_image;

class LFImageValue extends Equatable {
  final String? file;
  final Uint8List? bytes;

  const LFImageValue({this.file, this.bytes});

  @override
  List<Object?> get props => [
        file,
        bytes,
      ];
}
