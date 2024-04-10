import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';

class TextFieldScreen extends ScreenStatefulWidget {
  final String title;

  const TextFieldScreen({
    super.key,
    required this.title,
  });

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends ScreenState<TextFieldScreen> {
  final _textController1 = LFTextFieldController();
  final _textController2 = LFTextFieldController();
  final _textController3 = LFTextFieldController();
  final _textController4 = LFTextFieldController();

  @override
  Color? get backgroundColor => Colors.white;

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _textController4.dispose();

    super.dispose();
  }

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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        LFTextField(
          controller: _textController1,
          initialValue: 'Normal',
          placeHolder: 'Typing..',
        ),
        const SizedBox(height: 10.0),
        LFTextField(
          controller: _textController2,
          initialValue: 'ReadOnly',
          placeHolder: 'Typing..',
          readOnly: true,
        ),
        const SizedBox(height: 10.0),
        LFTextField(
          controller: _textController3,
          initialValue: 'Disabled',
          placeHolder: 'Typing..',
          disabled: true,
        ),
        const SizedBox(height: 10.0),
        LFTextField(
          controller: _textController4,
          initialValue: 'Error',
          placeHolder: 'Typing..',
          errorText: 'error message',
        ),
      ],
    );
  }
}
