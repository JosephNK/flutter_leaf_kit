import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

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
  final _textController5 = LFTextFieldController();

  @override
  Color? get backgroundColor => Colors.white;

  @override
  void initState() {
    _textController1.text = '12345678901';

    super.initState();
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _textController4.dispose();
    _textController5.dispose();

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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          LFTextField(
            controller: _textController1,
            placeHolder: 'Normal Typing..',
            maxLength: 10,
            onChanged: (text) {
              print('onChanged: $text');
            },
          ),
          const SizedBox(height: 10.0),
          LFTextField(
            controller: _textController2,
            placeHolder: 'ReadOnly Typing..',
            suffixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.ac_unit),
            ),
            // contentPadding: const EdgeInsets.all(0.0),
            readOnly: true,
          ),
          const SizedBox(height: 10.0),
          LFTextField(
            controller: _textController3,
            placeHolder: 'Disabled Typing..',
            disabled: true,
          ),
          const SizedBox(height: 10.0),
          LFTextField(
            controller: _textController4,
            placeHolder: 'Error Typing..',
            errorText: 'error message',
          ),
          const SizedBox(height: 10.0),
          LFTextField(
            controller: _textController5,
            placeHolder: 'TextArea Typing..',
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: 5,
            maxLines: 5,
          ),
          Container(
            height: 300.0,
          ),
          // const SizedBox(height: 10.0),
          // TextField(),
        ],
      ),
    );
  }
}
