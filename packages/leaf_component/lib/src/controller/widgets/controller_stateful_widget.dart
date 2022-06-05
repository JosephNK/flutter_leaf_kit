part of leaf_controller;

class ControllerVariable {
  bool get useSafeArea => false;
  bool get resizeToAvoidBottomInset => false;
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;
  Color? get backgroundColor => null;
}

abstract class ControllerBuild {
  Widget? buildScreen(BuildContext context);
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state);
  Widget buildBody(BuildContext context, Object? state);
  Widget? buildFloatingActionButton(BuildContext context, Object? state);
  Widget? buildBottomNavigationBar(BuildContext context, Object? state);
}

abstract class ControllerStatefulWidget extends StatefulWidget {
  const ControllerStatefulWidget({Key? key}) : super(key: key);
}

abstract class ControllerState<T extends StatefulWidget> extends State<T>
    with ControllerVariable
    implements ControllerBuild {
  String? className;
  // Object? objectState;

  @override
  bool get useSafeArea => false;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  @override
  Color? get backgroundColor => null;

  @override
  void initState() {
    super.initState();
    className = context.widget.toString();
    Logging.d('Controller initState: $className');
  }

  @override
  void dispose() {
    Logging.d('Controller dispose: $className');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidget = buildScreen(context);
    if (screenWidget != null) {
      return screenWidget;
    }
    return buildScaffold(context, null);
  }

  Widget buildScaffold(BuildContext context, Object? state, {Key? key}) {
    final body = useSafeArea
        ? SafeArea(
            child: buildBody(context, state),
          )
        : buildBody(context, state);

    return Scaffold(
      key: key,
      appBar: buildAppbar(context, state),
      body: Container(
        color: Colors.transparent,
        child: body,
      ),
      backgroundColor: backgroundColor ?? Colors.transparent,
      bottomNavigationBar: buildBottomNavigationBar(context, state),
      floatingActionButton: buildFloatingActionButton(context, state),
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
