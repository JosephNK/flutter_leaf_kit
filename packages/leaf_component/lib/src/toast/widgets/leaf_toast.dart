part of leaf_toast_component;

class LeafToastConfigure {
  final Color? toastBackgroundColor;
  final Color? containerBackgroundColor;
  final TextStyle? containerTextStyle;

  LeafToastConfigure({
    required this.toastBackgroundColor,
    required this.containerBackgroundColor,
    required this.containerTextStyle,
  });
}

class LeafToast {
  FToast? fToast;

  late BuildContext context;

  static final LeafToast _instance = LeafToast._internal();

  static LeafToast get shared => _instance;

  LeafToastConfigure? _toastConfig;

  LeafToast._internal() {
    Logging.d('LeafToast init');
  }

  void setup(BuildContext context, {LeafToastConfigure? configure}) {
    Logging.d('LeafToast Setup');
    this.context = context;
    fToast = FToast();
    fToast?.init(this.context);
    _toastConfig = configure;
  }

  Future<void> showNotification(
    BuildContext context,
    bool mounted, {
    required String message,
    Color? backgroundColor,
    bool willPopAfterRefresh = false,
    Duration duration = const Duration(milliseconds: 1500),
  }) async {
    fToast?.removeQueuedCustomToasts();
    fToast?.showToast(
      child: _buildContainer(
        message: message,
        backgroundColor: backgroundColor ?? _toastConfig?.toastBackgroundColor,
      ),
      toastDuration: duration,
      gravity: ToastGravity.BOTTOM,
    );
    if (willPopAfterRefresh) {
      final waitingDuration =
          Duration(milliseconds: duration.inMilliseconds + 250);
      await Future.delayed(waitingDuration);
      if (!mounted) return;
      Navigation.maybePop(
        context,
        param: NavigatorData(NavigatorViewState.refresh),
      );
    }
  }

  Future<void> showPositionedToast(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    int duration = 1500,
    double top = 200.0,
  }) async {
    fToast?.removeQueuedCustomToasts();
    fToast?.showToast(
      child: _buildContainer(
        message: message,
        backgroundColor: backgroundColor ?? _toastConfig?.toastBackgroundColor,
      ),
      toastDuration: Duration(milliseconds: duration),
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: top,
          left: 0,
          right: 0,
          child: child,
        );
      },
    );
  }

  // 공통 Container
  Widget _buildContainer({
    required String message,
    Color? backgroundColor,
  }) {
    return Container(
      //margin: const EdgeInsets.only(left: 0, right: 0),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: backgroundColor ?? _toastConfig?.containerBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: _toastConfig?.containerTextStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
