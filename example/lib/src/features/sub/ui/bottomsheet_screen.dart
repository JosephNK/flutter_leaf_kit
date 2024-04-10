import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';

class BottomSheetScreen extends ScreenStatefulWidget {
  final String title;

  const BottomSheetScreen({
    super.key,
    required this.title,
  });

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends ScreenState<BottomSheetScreen> {
  LFBottomSheetItem? _item;

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return LFAppBar(
      title: LFAppBarTitle(text: widget.title),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: LFFlatButton(
            text: 'Show',
            onPressed: () {
              LFBottomSheet.show(
                context,
                items: [
                  LFBottomSheetItem(key: '1', title: 'Hello'),
                  LFBottomSheetItem(key: '2', title: 'World'),
                ],
                selectItem: _item,
                onTap: (item) {
                  setState(() {
                    _item = item;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
