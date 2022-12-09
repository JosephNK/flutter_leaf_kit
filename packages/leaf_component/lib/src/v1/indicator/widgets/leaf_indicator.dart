part of leaf_indicator_component;

enum LeafIndSize { small, normal, large }

class LeafIndicator extends StatelessWidget {
  final EdgeInsets padding;
  final LeafIndSize size;
  final bool useCenter;

  const LeafIndicator({
    Key? key,
    this.padding = const EdgeInsets.all(0),
    this.size = LeafIndSize.normal,
    this.useCenter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return useCenter
        ? Center(
            child: _buildPlatform(context),
          )
        : _buildPlatform(context);
  }

  /// Platform
  Widget _buildPlatform(BuildContext context) {
    return Platform.isAndroid
        ? _buildMaterial(context)
        : _buildCupertino(context);
  }

  /// Material
  Widget _buildMaterial(BuildContext context) {
    final size = (this.size == LeafIndSize.large)
        ? 84.0
        : (this.size == LeafIndSize.normal)
            ? 36.0
            : 10.0;

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

  /// Cupertino
  Widget _buildCupertino(BuildContext context) {
    final size = (this.size == LeafIndSize.large)
        ? 30.0
        : (this.size == LeafIndSize.normal)
            ? 20.0
            : 10.0;

    return Container(
      padding: padding,
      child: CupertinoActivityIndicator(
        radius: size,
      ),
    );
  }
}
