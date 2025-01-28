import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LFIcons extends StatelessWidget {
  final Object asset;
  final Color? color;
  final double? width; // Icon size or Svg width
  final double? height; // Svg height

  const LFIcons(
    this.asset, {
    super.key,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final asset = this.asset;
    final color = this.color;
    final width = this.width;
    final height = this.height;

    final widget = LFIcons.buildSwitcher(
        asset: asset, color: color, width: width, height: height);

    if (widget != null) {
      return widget;
    }

    return SizedBox(
      width: width,
      height: height,
    );
  }

  static Widget? buildSwitcher({
    required Object asset,
    Color? color,
    double? width,
    double? height,
  }) {
    if (asset is IconData) {
      return Icon(asset, color: color, size: width);
    }

    if (asset is Icon) {
      return Icon(asset.icon, color: color, size: width);
    }

    if (asset is SvgPicture) {
      return SvgPicture(
        asset.bytesLoader,
        colorFilter:
            color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
        width: width,
        height: height,
      );
    }

    return null;
  }

  static Widget buildUpdateColor(
    LFIcons icon, {
    required Color? color,
  }) {
    final asset = icon.asset;
    final width = icon.width;
    final height = icon.height;

    final widget = LFIcons.buildSwitcher(
        asset: asset, color: color, width: width, height: height);

    if (widget != null) {
      return widget;
    }

    return icon;
  }
}
