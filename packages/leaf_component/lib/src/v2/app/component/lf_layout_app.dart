part of lf_app;

class LFLayoutApp extends StatefulWidget {
  final LFAppComponentConfigure? configure;
  final Widget child;

  const LFLayoutApp({
    Key? key,
    required this.child,
    this.configure,
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
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return OrientationBuilder(builder: (_, orientation) {
          if (constraints.maxWidth != 0) {
            DeviceManager.shared.setup(context);
            return widget.child;
          }
          return const Center(child: LFIndicator());
        });
      },
    );
  }
}
