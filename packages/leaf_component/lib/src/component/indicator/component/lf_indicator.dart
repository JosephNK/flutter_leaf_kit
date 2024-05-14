part of '../indicator.dart';

enum LFIndicatorSize { small, medium, large }

extension LFIndicatorSizeExt on LFIndicatorSize {
  double get sizeForMaterial {
    switch (this) {
      case LFIndicatorSize.small:
        return 20.0;
      case LFIndicatorSize.medium:
        return 30.0;
      case LFIndicatorSize.large:
        return 40.0;
    }
  }

  double get sizeForCupertino {
    switch (this) {
      case LFIndicatorSize.small:
        return 10.0;
      case LFIndicatorSize.medium:
        return 15.0;
      case LFIndicatorSize.large:
        return 25.0;
    }
  }
}

class LFIndicator extends StatelessWidget {
  final EdgeInsets padding;
  final LFIndicatorSize size;

  const LFIndicator({
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.size = LFIndicatorSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return _buildPlatform(context);
  }

  /// Platform
  Widget _buildPlatform(BuildContext context) {
    return Platform.isIOS
        ? LFCupertinoIndicator(
            padding: padding,
            size: size,
          )
        : LFMaterialIndicator(
            padding: padding,
            size: size,
          );
  }
}

class LFMaterialIndicator extends StatelessWidget {
  final EdgeInsets padding;
  final LFIndicatorSize size;

  const LFMaterialIndicator({
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.size = LFIndicatorSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final size = this.size.sizeForMaterial;

    return Container(
      padding: padding,
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}

class LFCupertinoIndicator extends StatelessWidget {
  final EdgeInsets padding;
  final LFIndicatorSize size;

  const LFCupertinoIndicator({
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.size = LFIndicatorSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final size = this.size.sizeForCupertino;

    return Container(
      padding: padding,
      child: CupertinoActivityIndicator(
        radius: size,
      ),
    );
  }
}
