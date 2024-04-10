part of '../lf_app.dart';

typedef LFLayoutAppOnSetupDevice = Function(VoidCallback onBuilder);

class LFLayoutApp extends StatefulWidget {
  final LFAppComponentConfigure? configure;
  final String buildName;
  final Color? backgroundColor;
  final LFLayoutAppOnSetupDevice? onSetupDevice;
  final VoidCallback onBuilder;
  final Widget child;

  const LFLayoutApp({
    super.key,
    required this.child,
    this.buildName = '',
    this.backgroundColor,
    this.configure,
    this.onSetupDevice,
    required this.onBuilder,
  });

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
    final buildName = widget.buildName;
    final onSetupDevice = widget.onSetupDevice;
    final onBuilder = widget.onBuilder;

    final child = LayoutBuilder(
      builder: (_, constraints) {
        return OrientationBuilder(builder: (_, orientation) {
          if (constraints.maxWidth != 0) {
            if (onSetupDevice != null) {
              onSetupDevice.call(onBuilder);
            } else {
              onBuilder.call();
            }
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
