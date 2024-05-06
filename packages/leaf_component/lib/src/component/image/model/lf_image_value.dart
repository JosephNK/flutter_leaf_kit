part of '../lf_image.dart';

class LFImageValue extends Equatable {
  // Url
  // https://picsum.photos/200
  // assets/images/sample400x300.jpg
  // file://xxx.xxx
  final Uri? origin;
  final Uri? thumbnail;

  // Bytes
  final Uint8List? bytes;

  // only use cache_image
  final Map<String, String>? header;

  const LFImageValue({
    this.origin,
    this.thumbnail,
    this.bytes,
    this.header,
  });

  @override
  List<Object?> get props => [
        origin,
        thumbnail,
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
    Uri? Function()? origin,
    Uri? Function()? thumbnail,
    Uint8List? Function()? bytes,
    Map<String, String>? Function()? header,
  }) =>
      LFImageValue(
        origin: origin != null ? origin() : this.origin,
        thumbnail: thumbnail != null ? thumbnail() : this.thumbnail,
        bytes: bytes != null ? bytes() : this.bytes,
        header: header != null ? header() : this.header,
      );

  /// Method

  static bool isNotEmptyUri(Uri? uri) {
    return uri != null && uri.toString() != '';
  }

  bool get isThumbnailOrOriginURL {
    Uri? uri;
    if (isURL(thumbnail.toString())) {
      uri = thumbnail;
    } else if (isURL(origin.toString())) {
      uri = origin;
    }
    return uri != null;
  }

  Uri? get getThumbnailOrOriginURL {
    Uri? uri;
    if (isURL(thumbnail.toString())) {
      uri = thumbnail;
    } else if (isURL(origin.toString())) {
      uri = origin;
    }
    return uri;
  }

  Uri? get getThumbnailOrOrigin {
    Uri? uri;
    if (LFImageValue.isNotEmptyUri(thumbnail)) {
      uri = thumbnail;
    } else if (LFImageValue.isNotEmptyUri(origin)) {
      uri = origin;
    }
    return uri;
  }
}
