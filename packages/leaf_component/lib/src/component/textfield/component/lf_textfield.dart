part of '../lf_textfield.dart';

enum LFTextFieldStatus { none, clear, reset }

class LFTextFieldController extends ChangeNotifier {
  final controller = TextEditingController();

  LFTextFieldStatus status = LFTextFieldStatus.none;

  String get text => controller.text;
  set text(String value) {
    controller.text = value;
  }

  void reset() {
    status = LFTextFieldStatus.reset;
    notifyListeners();
    status = LFTextFieldStatus.none;
  }

  void clear() {
    status = LFTextFieldStatus.clear;
    notifyListeners();
    status = LFTextFieldStatus.none;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class LFTextField extends StatefulWidget {
  final LFTextFieldController controller;
  final String initialValue;
  final String text;
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
    this.initialValue = '',
    this.text = '',
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
    if (suffixIcon == null && enableClearButton) {
      if (maxLines == 1) {
        _showClearButton = isNotEmpty(newText);
      }
    }
    _textController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: isEmpty(newText) ? -1 : newText.length,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final controller = widget.controller;
    final focusNode = widget.focusNode;
    final initialValue = widget.initialValue;
    final text = widget.text;

    controller.addListener(() {
      if (controller.status == LFTextFieldStatus.reset) {
        reset();
      } else if (controller.status == LFTextFieldStatus.clear) {
        clear();
      }
    });

    _textController = controller.controller;
    _textController.addListener(onControllerInputListener);

    _textFieldFocusNode = (focusNode == null) ? FocusNode() : focusNode;
    _textFieldFocusNode.addListener(onFocusNodeChangeListener);

    this.text = isEmpty(text) ? initialValue : text;
  }

  @override
  void dispose() {
    _textController.removeListener(onControllerInputListener);
    _textFieldFocusNode.removeListener(onFocusNodeChangeListener);

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFTextField oldWidget) {
    if (oldWidget.text != widget.text) {
      text = widget.text;
    }
    super.didUpdateWidget(oldWidget);
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

    /// Colors
    var inputBackgroundColor = disabled
        ? disabledBackgroundColor ?? Colors.grey.withOpacity(0.5)
        : readOnly
            ? Colors.grey.withOpacity(0.5)
            : backgroundColor;
    if (_hasFocus) {
      inputBackgroundColor = backgroundColor;
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

    /// Handler
    Widget clearButtonWithHandler() {
      return GestureDetector(
        onTap: () {
          clear();
        },
        child: clearIcon ??
            Icon(
              Icons.clear_rounded,
              color: buttonClearIconColor,
            ),
      );
    }

    void textFieldOnChanged(String value) {
      final text = value.trim();

      if (maxLines == 1) {
        setState(() => _showClearButton = text.isNotEmpty);
      }

      final maxLength = widget.maxLength;
      if (maxLength != null) {
        final textLength = text.length;
        if (textLength <= maxLength) {
          _prevText = text;
        } else {
          _textController.value = TextEditingValue(
            text: _prevText,
            selection: TextSelection.collapsed(
              offset: isEmpty(_prevText) ? -1 : _prevText.length,
            ),
          );
          _textController.text = _prevText;
        }
        if (textLength > maxLength) return;
      }

      onChanged?.call(text);
    }

    void textFieldOnSubmitted(String value) {
      final text = value.trim();
      onSubmitted?.call(text);
    }

    final prefixIconWidget = prefixIcon;

    var suffixIconWidget = suffixIcon ??
        (enableClearButton
            ? !_showClearButton
                ? null
                : clearButtonWithHandler()
            : null);

    if (maxLength != null && suffixIconWidget != null) {
      suffixIconWidget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          suffixIconWidget,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '${text.length}/$maxLength',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      );
    }

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
      onChanged: textFieldOnChanged,
      onSubmitted: textFieldOnSubmitted,
      onEditingComplete: (onEditingComplete != null)
          ? () => onEditingComplete
          : null, // Done Button not working!
    );
  }

  /// Methods

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
