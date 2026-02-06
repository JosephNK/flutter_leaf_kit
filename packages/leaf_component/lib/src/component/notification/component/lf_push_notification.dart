part of '../notification.dart';

@Deprecated('Use LFPushNotificationV2 instead')
class LFStackPushNotification {
  static final LFStackPushNotification _instance =
      LFStackPushNotification._internal();
  static LFStackPushNotification get shared => _instance;
  LFStackPushNotification._internal();

  final List<LFPushNotification> _items = [];

  LFStackPushNotification enqueue(LFPushNotification notification) {
    _items.add(notification);
    return this;
  }

  void show(BuildContext context) {
    final notification = peek();
    if (notification == null) {
      return;
    }
    List<LFPushNotification> deleteItems = [];
    for (final item in _items) {
      if (item != notification) {
        item.closeOverlay();
        deleteItems.add(item);
      }
    }
    _items.removeWhere((element) => deleteItems.contains(element));
    notification.show(context);
  }

  LFPushNotification? pop() {
    if (_items.isEmpty) {
      return null;
    }
    return _items.removeLast();
  }

  LFPushNotification? peek() {
    if (_items.isEmpty) {
      return null;
    }
    return _items.last;
  }

  bool get isEmpty => _items.isEmpty;

  int get length => _items.length;

  void clear() {
    _items.clear();
  }
}

@Deprecated('Use LFPushNotificationV2 instead')
class LFPushNotification extends Object {
  final String title;
  final String? body;
  final Map<String, dynamic>? data;
  final ValueChanged<Map<String, dynamic>?>? onTap;
  final Widget? icon;
  final Decoration? boxDecoration;
  final Duration animationDuration;
  final TextStyle? titleTextStyle;
  final TextStyle? bodyTextStyle;

  LFPushNotification({
    required this.title,
    required this.body,
    required this.data,
    this.onTap,
    this.icon,
    this.boxDecoration,
    this.animationDuration = const Duration(milliseconds: 450),
    this.titleTextStyle,
    this.bodyTextStyle,
  });

  OverlayEntry? _overlayEntry;
  Timer? _timer;
  ValueChanged<LFPushNotification>? _onFinish;

  void show(
    BuildContext context, {
    ValueChanged<LFPushNotification>? onFinish,
  }) async {
    if (_overlayEntry != null) return;

    _onFinish = onFinish;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return _LFPushNotificationAnimatedWidget(
          title: title,
          body: body,
          data: data,
          icon: icon,
          boxDecoration: boxDecoration,
          animationDuration: animationDuration,
          titleTextStyle: titleTextStyle,
          bodyTextStyle: bodyTextStyle,
          onTap: (data) {
            closeOverlay();
            onTap?.call(data);
          },
        );
      },
    );

    // Overlay.of(context).insert(_overlayEntry!);
    Navigator.of(context).overlay?.insert(_overlayEntry!);

    _timer = Timer(const Duration(seconds: 5), () {
      closeOverlay();
    });
  }

  void closeOverlay() {
    _timer?.cancel();
    _timer = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _onFinish?.call(this);
  }
}

class _LFPushNotificationAnimatedWidget extends StatefulWidget {
  final String title;
  final String? body;
  final Map<String, dynamic>? data;
  final ValueChanged<Map<String, dynamic>?>? onTap;
  final Widget? icon;
  final Decoration? boxDecoration;
  final Duration animationDuration;
  final TextStyle? titleTextStyle;
  final TextStyle? bodyTextStyle;

  const _LFPushNotificationAnimatedWidget({
    required this.title,
    this.body,
    this.data,
    this.onTap,
    this.icon,
    this.boxDecoration,
    this.animationDuration = const Duration(milliseconds: 450),
    this.titleTextStyle,
    this.bodyTextStyle,
  });

  @override
  _LFPushNotificationAnimatedWidgetState createState() =>
      _LFPushNotificationAnimatedWidgetState();
}

class _LFPushNotificationAnimatedWidgetState
    extends State<_LFPushNotificationAnimatedWidget>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isVisible = true;
      });
    });

    _timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  void dispose() {
    _close();
    super.dispose();
  }

  void _close() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    final body = widget.body;
    final data = widget.data;
    final onTap = widget.onTap;
    final icon = widget.icon;
    final boxDecoration = widget.boxDecoration;
    final animationDuration = widget.animationDuration;
    final titleTextStyle = widget.titleTextStyle;
    final bodyTextStyle = widget.bodyTextStyle;

    return AnimatedPositioned(
      top: _isVisible ? 50.0 : 0.0,
      left: 16.0,
      right: 16.0,
      duration: animationDuration,
      child: AnimatedOpacity(
        duration: animationDuration,
        opacity: _isVisible ? 1.0 : 0.0,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return Material(
              child: GestureDetector(
                onTap: () {
                  _close();
                  onTap?.call(data);
                },
                child: Container(
                  width: width,
                  decoration:
                      boxDecoration ??
                      const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    children: [
                      icon ??
                          const Icon(
                            Icons.notifications,
                            color: Colors.black,
                            size: 40.0,
                          ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                ),
                                child: LFText(
                                  title,
                                  style:
                                      titleTextStyle ??
                                      const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  maxLines: 1,
                                ),
                              ),
                              if (body != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2.0,
                                  ),
                                  child: LFText(
                                    body,
                                    style:
                                        bodyTextStyle ??
                                        const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
