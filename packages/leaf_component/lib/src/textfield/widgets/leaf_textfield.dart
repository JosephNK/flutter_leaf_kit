part of leaf_textfield_component;

typedef LeafTextFieldClear = Function();

class LeafTextFieldController {
  TextEditingController textEditingController;
  LeafTextFieldClear? clear;

  LeafTextFieldController({required this.textEditingController});

  void dispose() {
    clear = null;

    textEditingController.dispose();
  }
}

class LeafTextFiled extends StatefulWidget {
  final String text;
  final String initialText;
  final String placeHolder;
  final bool autofocus;
  final bool enabled;
  final TextStyle? textStyle;
  final TextStyle? placeHolderTextStyle;
  final TextInputType keyboardType;
  final LeafTextFieldController? controller;
  final TextInputAction textInputAction;
  final FocusNode? textFieldFocus;
  final EdgeInsets contentPadding;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final ImageProvider? clearImage;
  final Widget? tailing;
  final Color? backgroundColor;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  // final VoidCallback? onEditingComplete;

  const LeafTextFiled({
    Key? key,
    required this.text,
    this.initialText = '',
    this.placeHolder = '',
    this.autofocus = false,
    this.enabled = true,
    this.textStyle,
    this.placeHolderTextStyle,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.textFieldFocus,
    this.contentPadding = const EdgeInsets.all(0.0),
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.clearImage,
    this.tailing,
    this.backgroundColor,
    this.onChanged,
    this.onSubmitted,
    // this.onEditingComplete,
  }) : super(key: key);

  @override
  State<LeafTextFiled> createState() => _LeafTextFiledState();
}

class _LeafTextFiledState extends State<LeafTextFiled> {
  late TextEditingController _textController;

  late FocusNode _textFieldFocus;
  bool _showClearButton = false;
  String _prevValue = '';

  set value(String newText) {
    _textController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  @override
  void initState() {
    super.initState();

    final controller = widget.controller;
    final textFieldFocus = widget.textFieldFocus;
    final initialText = widget.initialText;
    final text = widget.text;

    controller?.clear = clear;

    _textController = (controller == null)
        ? TextEditingController()
        : controller.textEditingController;
    // _textController.addListener(inputListeners);
    _textFieldFocus = (textFieldFocus == null) ? FocusNode() : textFieldFocus;
    // _textFieldFocus.addListener(onFocusChange);
    value = (isNotEmpty(initialText)) ? initialText : text;
  }

  @override
  void dispose() {
    // _textController.removeListener(inputListeners);
    // _textFieldFocus.removeListener(onFocusChange);

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LeafTextFiled oldWidget) {
    // TODO: 한글 처리가 되지 않아서 주석 처리!
    // if (oldWidget.text != widget.text) {
    //   value = widget.text;
    // }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final tailing = widget.tailing;

    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: widget.backgroundColor ?? Colors.white,
        child: Row(
          children: [
            Expanded(
              child: _buildTextField(context),
            ),
            _buildClearButton(context),
            (tailing != null) ? tailing : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    final inputFormatters = <TextInputFormatter>[];

    final inputDecoration = InputDecoration(
      hintText: isNotEmpty(widget.placeHolder) ? widget.placeHolder : null,
      hintStyle: isNotEmpty(widget.placeHolder)
          ? widget.placeHolderTextStyle?.copyWith(
              decoration: TextDecoration.none,
            )
          : null,
      contentPadding: widget.contentPadding,
      counterText: '',
      isDense: true,
      // isCollapsed: true,
      fillColor: Colors.transparent,
      filled: true,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );

    void onChange(String text) {
      final value = text.trim();

      setState(() => _showClearButton = value.isNotEmpty);

      final maxLength = widget.maxLength;
      if (maxLength != null) {
        final textLength = value.length;
        if (textLength > maxLength) {
          return;
        }
        if (textLength <= maxLength) {
          _prevValue = value;
        } else {
          _textController.value = TextEditingValue(
            text: _prevValue,
            selection: TextSelection.collapsed(offset: _prevValue.length),
          );
          _textController.text = _prevValue;
        }
      }

      widget.onChanged?.call(text);
    }

    void onSubmitted(text) {
      final value = text.trim();
      widget.onSubmitted?.call(value);
    }

    // void onEditingComplete() {
    //   widget.onEditingComplete?.call();
    // }

    return TextField(
      controller: _textController,
      focusNode: _textFieldFocus,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      scrollPadding: const EdgeInsets.all(0.0),
      style: widget.textStyle?.copyWith(
        decoration: TextDecoration.none,
      ),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      enableSuggestions: false,
      autocorrect: false,
      inputFormatters: inputFormatters,
      decoration: inputDecoration,
      onChanged: onChange,
      onSubmitted: onSubmitted,
      // onEditingComplete: onEditingComplete, // Done Button not working!
    );
  }

  Widget _buildClearButton(BuildContext context) {
    final clearImage = widget.clearImage;

    if (!_showClearButton || clearImage == null) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.only(right: 14),
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          clear();
        },
        child: Image(image: clearImage),
      ),
    );
  }

  void clear() {
    _textController.clear();
    final text = _textController.text.trim();
    widget.onChanged?.call(text);
    widget.onSubmitted?.call(text);
    setState(() => _showClearButton = false);
  }

  // void inputListeners() {}
  // void onFocusChange() {}
}
