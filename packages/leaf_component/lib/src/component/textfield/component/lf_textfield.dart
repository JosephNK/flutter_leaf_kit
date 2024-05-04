part of '../lf_textfield.dart';

enum LFTextFieldStatus { none, clear, reset, setText }

class LFTextFieldController extends ChangeNotifier {
  final controller = TextEditingController();

  LFTextFieldStatus status = LFTextFieldStatus.none;

  String? value;
  String get text => controller.text;

  set text(String value) {
    this.value = value;
    status = LFTextFieldStatus.setText;
    notifyListeners();
  }

  void reset() {
    status = LFTextFieldStatus.reset;
    notifyListeners();
    none();
  }

  void clear() {
    status = LFTextFieldStatus.clear;
    notifyListeners();
    none();
  }

  void none() {
    status = LFTextFieldStatus.none;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class LFTextField extends StatefulWidget {
  final LFTextFieldController controller;
  final TextStyle? textStyle;
  final bool autofocus;
  final bool disabled;
  final bool readOnly;
  final bool? showCursor;
  final bool enableClearButton;
  final bool onlyUnderline;
  final bool obscureText;
  final String? errorText;
  final FocusNode? focusNode;
  final String? placeHolder;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final int? maxLength;
  final int minLines;
  final int maxLines;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsets contentPadding;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? placeHolderColor;
  final Color? clearIconColor;
  final Color? disabledClearIconColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? clearIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFocusChanged;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;

  const LFTextField({
    super.key,
    required this.controller,
    this.textStyle,
    this.autofocus = false,
    this.disabled = false,
    this.readOnly = false,
    this.showCursor,
    this.enableClearButton = true,
    this.onlyUnderline = true,
    this.obscureText = false,
    this.errorText,
    this.placeHolder = 'PlaceHolder',
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.textAlign = TextAlign.left,
    this.focusNode,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.borderRadius = 0.0,
    this.contentPadding = const EdgeInsets.all(16.0),
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.focusBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.disabledTextColor,
    this.placeHolderColor,
    this.clearIconColor,
    this.disabledClearIconColor,
    this.prefixIcon,
    this.suffixIcon,
    this.clearIcon,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.inputFormatters,
    this.onTap,
    this.onFocusChanged,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
  });

  @override
  State<LFTextField> createState() => _LFTextFieldState();
}

class _LFTextFieldState extends State<LFTextField> {
  late TextEditingController _textController;
  late FocusNode _textFieldFocusNode;

  bool _showClearButton = false;
  bool _hasFocus = false;

  String _prevText = '';

  String get text => _textController.text;

  set text(String newText) {
    final suffixIcon = widget.suffixIcon;
    final enableClearButton = widget.enableClearButton;
    final maxLines = widget.maxLines;
    final maxLength = widget.maxLength ?? 0;
    if (suffixIcon == null && enableClearButton) {
      if (maxLines == 1) {
        _showClearButton = isNotEmpty(newText);
      }
    }
    if (newText.length > maxLength) {
      newText = newText.substring(0, maxLength);
    }
    _setTextEditingValue(newText);
  }

  @override
  void initState() {
    super.initState();

    final controller = widget.controller;
    final focusNode = widget.focusNode;

    controller.addListener(() {
      if (controller.status == LFTextFieldStatus.reset) {
        reset();
      } else if (controller.status == LFTextFieldStatus.clear) {
        clear();
      } else if (controller.status == LFTextFieldStatus.setText) {
        text = controller.value ?? '';
      } else if (controller.status == LFTextFieldStatus.none) {
        controller.value = null;
      }
    });

    _textController = controller.controller;
    _textController.addListener(onControllerInputListener);

    _textFieldFocusNode = (focusNode == null) ? FocusNode() : focusNode;
    _textFieldFocusNode.addListener(onFocusNodeChangeListener);

    final value = controller.value ?? '';
    if (isNotEmpty(value)) {
      _textFieldOnChanged(value);
    }

    text = value;
    controller.none();
  }

  @override
  void dispose() {
    _textController.removeListener(onControllerInputListener);
    _textFieldFocusNode.removeListener(onFocusNodeChangeListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: _buildTextField(context),
    );
  }

  Widget _buildTextField(BuildContext context) {
    final autofocus = widget.autofocus;
    final disabled = widget.disabled;
    final readOnly = widget.readOnly;
    final showCursor = widget.showCursor;
    final enableClearButton = widget.enableClearButton;
    final obscureText = widget.obscureText;
    final textStyle = widget.textStyle;
    final errorText = widget.errorText;
    final placeHolder = widget.placeHolder;
    final keyboardType = widget.keyboardType;
    final textInputAction = widget.textInputAction;
    final textAlign = widget.textAlign;
    final maxLength = widget.maxLength;
    final minLines = widget.minLines;
    final maxLines = widget.maxLines;
    final onlyUnderline = widget.onlyUnderline;
    final borderRadius = widget.borderRadius;
    final borderWidth = widget.borderWidth;
    final contentPadding = widget.contentPadding;
    final backgroundColor = widget.backgroundColor;
    final disabledBackgroundColor = widget.disabledBackgroundColor;
    final borderColor = widget.borderColor;
    final focusBorderColor = widget.focusBorderColor;
    final errorBorderColor = widget.errorBorderColor;
    final textColor = widget.textColor;
    final disabledTextColor = widget.disabledTextColor;
    final placeHolderColor = widget.placeHolderColor;
    final clearIconColor = widget.clearIconColor;
    final disabledClearIconColor = widget.disabledClearIconColor;
    final prefixIcon = widget.prefixIcon;
    final suffixIcon = widget.suffixIcon;
    final clearIcon = widget.clearIcon;
    final prefixIconConstraints = widget.prefixIconConstraints;
    final suffixIconConstraints = widget.suffixIconConstraints;
    final inputFormatters = widget.inputFormatters;
    final onTap = widget.onTap;
    final onChanged = widget.onChanged;
    final onSubmitted = widget.onSubmitted;
    final onEditingComplete = widget.onEditingComplete;

    final disabledBackground1Color =
        disabledBackgroundColor ?? Colors.grey.withOpacity(0.5);

    /// Colors
    var inputBackgroundColor =
        (disabled || readOnly) ? disabledBackground1Color : backgroundColor;
    if (_hasFocus) {
      //
    }
    var inputPlaceHolderColor = placeHolderColor ?? Colors.grey;
    var inputTextColor =
        disabled ? disabledTextColor ?? Colors.grey : textColor ?? Colors.black;
    var inputBorderColor = borderColor ?? Colors.grey.withOpacity(0.2);
    var inputFocusBorderColor = focusBorderColor ?? inputBorderColor;
    var inputErrorBorderColor = errorBorderColor ?? Colors.red;
    var buttonClearIconColor = disabled
        ? disabledClearIconColor ?? Colors.grey
        : clearIconColor ?? Colors.black.withOpacity(0.6);

    /// TextStyle
    final textFieldTextStyle = textStyle ??
        const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
        );

    /// Widgets
    Widget clearButtonWithHandler() {
      final child =
          clearIcon ?? Icon(Icons.clear_rounded, color: buttonClearIconColor);
      return GestureDetector(
        onTap: () {
          clear();
        },
        child: child,
      );
    }

    final prefixIconWidget = prefixIcon;

    final suffixIconWidget = Container(
      margin: EdgeInsets.only(right: contentPadding.right),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          suffixIcon ?? Container(),
          enableClearButton
              ? !_showClearButton
                  ? Container()
                  : clearButtonWithHandler()
              : Container(),
        ],
      ),
    );

    return TextField(
      controller: _textController,
      focusNode: _textFieldFocusNode,
      autofocus: autofocus,
      enabled: !disabled,
      readOnly: readOnly,
      showCursor: showCursor,
      scrollPadding: const EdgeInsets.all(0.0),
      style: textFieldTextStyle.copyWith(
        decoration: TextDecoration.none,
        color: inputTextColor,
      ),
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIcon: prefixIconWidget,
        suffixIcon: suffixIconWidget,
        prefixIconConstraints: prefixIconConstraints,
        suffixIconConstraints: suffixIconConstraints,
        isDense: true,
        isCollapsed: true,
        fillColor: inputBackgroundColor,
        filled: true,
        contentPadding: contentPadding,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        counterText: '',
        errorText: errorText,
        errorStyle: (errorText == null) ? null : const TextStyle(height: 0.0),
        hintText: isNotEmpty(placeHolder) ? placeHolder : null,
        hintStyle: isNotEmpty(placeHolder)
            ? textFieldTextStyle.copyWith(
                decoration: TextDecoration.none,
                color: inputPlaceHolderColor,
              )
            : null,
        border: onlyUnderline
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        enabledBorder: onlyUnderline
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color: (borderWidth == 0.0)
                        ? Colors.transparent
                        : inputBorderColor,
                    width: borderWidth),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : OutlineInputBorder(
                borderSide: BorderSide(
                    color: (borderWidth == 0.0)
                        ? Colors.transparent
                        : inputBorderColor,
                    width: borderWidth),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        focusedBorder: onlyUnderline
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color: (borderWidth == 0.0)
                        ? Colors.transparent
                        : inputFocusBorderColor,
                    width: borderWidth),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : OutlineInputBorder(
                borderSide: BorderSide(
                    color: (borderWidth == 0.0)
                        ? Colors.transparent
                        : inputFocusBorderColor,
                    width: borderWidth),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        errorBorder: onlyUnderline
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color: (borderWidth == 0.0)
                        ? Colors.transparent
                        : inputErrorBorderColor,
                    width: borderWidth),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : OutlineInputBorder(
                borderSide: BorderSide(
                    color: (borderWidth == 0.0)
                        ? Colors.transparent
                        : inputErrorBorderColor,
                    width: borderWidth),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        focusedErrorBorder: onlyUnderline
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color: (borderWidth == 0.0)
                        ? Colors.transparent
                        : inputErrorBorderColor,
                    width: borderWidth),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : OutlineInputBorder(
                borderSide: BorderSide(
                    color: (borderWidth == 0.0)
                        ? Colors.transparent
                        : inputErrorBorderColor,
                    width: borderWidth),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
      ),
      onTap: onTap,
      onChanged: _textFieldOnChanged,
      onSubmitted: _textFieldOnSubmitted,
      onEditingComplete: (onEditingComplete != null)
          ? () => onEditingComplete
          : null, // Done Button not working!
    );
  }

  /// Methods

  void _setTextEditingValue(String text) {
    _textController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: isEmpty(text) ? -1 : text.length,
      ),
    );
  }

  void _textFieldOnChanged(String value) {
    final maxLength = widget.maxLength;
    final maxLines = widget.maxLines;
    final onChanged = widget.onChanged;

    final text = value.trim();

    if (maxLines == 1) {
      setState(() => _showClearButton = text.isNotEmpty);
    }

    if (maxLength != null) {
      final textLength = text.length;
      if (textLength <= maxLength) {
        _prevText = text;
      } else {
        if (isEmpty(_prevText)) {
          _prevText = text.substring(0, maxLength);
        }
        _setTextEditingValue(_prevText);
        // _textController.text = _prevText;
      }
      onChanged?.call(_prevText);
      return;
    }

    onChanged?.call(text);
  }

  void _textFieldOnSubmitted(String value) {
    final onSubmitted = widget.onSubmitted;
    final text = value.trim();
    onSubmitted?.call(text);
  }

  void clear() {
    final onChanged = widget.onChanged;
    final onSubmitted = widget.onSubmitted;

    _textController.clear();
    final text = _textController.text.trim();
    onChanged?.call(text);
    if (text.isNotEmpty) {
      onSubmitted?.call(text);
    }
    if (!mounted) return;
    setState(() => _showClearButton = false);
  }

  void reset() {
    clear();
    _textFieldFocusNode.hasFocus;
  }

  /// Listener

  void onControllerInputListener() {}

  void onFocusNodeChangeListener() {
    final onFocusChanged = widget.onFocusChanged;

    final hasFocus = _textFieldFocusNode.hasFocus;

    setState(() {
      _hasFocus = hasFocus;
    });

    onFocusChanged?.call(hasFocus);
  }
}

class LFNoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value contains any spaces
    if (newValue.text.contains(' ')) {
      // If it does, return the old value
      return oldValue;
    }
    // Otherwise, return the new value
    return newValue;
  }
}
