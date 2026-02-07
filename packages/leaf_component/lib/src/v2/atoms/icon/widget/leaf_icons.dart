import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

/// A universal icon widget supporting [IconData], [Icon], [AssetBytesLoader],
/// and [SvgPicture] asset types.
class LeafIcons extends StatelessWidget {
  final Object asset;
  final Color? color;
  final double? width;
  final double? height;

  const LeafIcons(
    this.asset, {
    super.key,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final asset = this.asset;

    if (asset is IconData) {
      return Icon(asset, color: color, size: width);
    }

    if (asset is Icon) {
      return Icon(asset.icon, color: color, size: width);
    }

    if (asset is AssetBytesLoader) {
      return SvgPicture(
        asset,
        colorFilter:
            color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
        width: width,
        height: height,
      );
    }

    if (asset is SvgPicture) {
      return SvgPicture(
        asset.bytesLoader,
        colorFilter:
            color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
        width: width,
        height: height,
      );
    }

    return SizedBox(width: width, height: height);
  }

  /// Creates a copy of this icon with an updated [color].
  static Widget updateColor(LeafIcons icon, {required Color? color}) {
    return LeafIcons(
      icon.asset,
      color: color,
      width: icon.width,
      height: icon.height,
    );
  }
}
