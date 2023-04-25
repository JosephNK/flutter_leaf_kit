part of lf_app;

class LFLayoutApp extends StatefulWidget {
  final LFAppComponentConfigure? configure;
  final String buildName;
  final Color? backgroundColor;
  final bool isDeviceManagerSetup;
  final VoidCallback? onBuilder;
  final Widget child;

  const LFLayoutApp({
    Key? key,
    required this.child,
    this.buildName = '',
    this.backgroundColor,
    this.configure,
    this.isDeviceManagerSetup = true,
    this.onBuilder,
  }) : super(key: key);

  @override
  State<LFLayoutApp> createState() => _LFLayoutAppState();
}

class _LFLayoutAppState extends State<LFLayoutApp> {
  @override
  void initState() {
    super.initState();

    final configure = widget.configure;
    LFComponentConfigure.shared.setup(configure);

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    final buildName = widget.buildName;
    final isDeviceManagerSetup = widget.isDeviceManagerSetup;
    final onBuilder = widget.onBuilder;

    final child = LayoutBuilder(
      builder: (_, constraints) {
        return OrientationBuilder(builder: (_, orientation) {
          if (constraints.maxWidth != 0) {
            if (isDeviceManagerSetup) {
              LFDeviceManager.shared.setup(context);
            }
            onBuilder?.call();
            return Container(
              color: widget.backgroundColor,
              child: widget.child,
            );
          }
          return const Center(child: LFIndicator());
        });
      },
    );

    if (isNotEmpty(buildName)) {
      return Banner(
        message: buildName,
        location: BannerLocation.topStart,
        child: child,
      );
    }

    return child;
  }
}
