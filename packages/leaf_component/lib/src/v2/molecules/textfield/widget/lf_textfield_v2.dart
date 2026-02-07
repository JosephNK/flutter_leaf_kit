import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/theme/theme.dart';
import '../controller/lf_textfield_controller_v2.dart';

/// A themed text field widget that resolves all colors from the LF design
/// token system instead of hardcoded values.
///
/// Uses [LFTextFieldControllerV2] for programmatic control.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LFTextFieldThemeData] from the nearest [LFTheme]
///   3. Global tokens ([LFColors])
@immutable
class LFTextFieldV2 extends StatefulWidget {
  final LFTextFieldControllerV2 controller;
  final TextStyle? textStyle;
  final bool autofocus;
  final bool disabled;
  final bool readOnly;
  final bool? showCursor;
  final bool enableClearButton;
  final bool onlyUnderline;
  final bool obscureText;
  final String? placeHolder;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final int? maxLength;
  final int minLines;
  final int maxLines;
  final double? borderRadius;
  final double? borderWidth;
  final EdgeInsets? contentPadding;
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
  final bool enableSuggestions;
  final bool autocorrect;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? clearIcon;
  final Widget? counterWidget;
  final String? counterText;
  final TextStyle? countTextStyle;
  final Widget? errorWidget;
  final String? errorText;
  final TextStyle? errorTextStyle;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFocusChanged;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onClearPressed;

  const LFTextFieldV2({
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
    this.placeHolder,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.textAlign = TextAlign.left,
    this.focusNode,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.borderRadius,
    this.borderWidth,
    this.contentPadding,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.disabledTextColor,
    this.placeHolderColor,
    this.clearIconColor,
    this.disabledClearIconColor,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.prefixIcon,
    this.suffixIcon,
    this.clearIcon,
    this.counterWidget,
    this.counterText,
    this.countTextStyle,
    this.errorText,
    this.errorWidget,
    this.errorTextStyle,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.inputFormatters,
    this.onTap,
    this.onFocusChanged,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.onClearPressed,
  });

  @override
  State<LFTextFieldV2> createState() => _LFTextFieldV2State();
}

class _LFTextFieldV2State extends State<LFTextFieldV2> {
  late TextEditingController _textController;
  late FocusNode _textFieldFocusNode;

  bool _showClearButton = false;

  String _prevText = '';

  String get text => _textController.text;

  set text(String newText) {
    if (widget.suffixIcon == null && widget.enableClearButton) {
      if (widget.maxLines == 1) {
        _showClearButton = newText.isNotEmpty;
      }
    }
    newText = _textCutString(newText);
    _setTextEditingValue(newText);
  }

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onControllerNotify);

    _textController = widget.controller.controller;
    _textController.addListener(_onControllerInput);

    _textFieldFocusNode = widget.focusNode ?? FocusNode();
    _textFieldFocusNode.addListener(_onFocusChanged);

    text = widget.controller.value ?? '';
    widget.controller.none();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerNotify);
    _textController.removeListener(_onControllerInput);
    _textFieldFocusNode.removeListener(_onFocusChanged);
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
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final tfTheme = theme.textFieldTheme;

    // Resolve colors via 3-level cascade
    final resolvedBorderRadius =
        widget.borderRadius ?? tfTheme?.borderRadius ?? 0.0;
    final resolvedBorderWidth =
        widget.borderWidth ?? tfTheme?.borderWidth ?? 1.0;
    final resolvedContentPadding = widget.contentPadding ??
        tfTheme?.contentPadding ??
        const EdgeInsets.all(16.0);

    final resolvedDisabledBg = widget.disabledBackgroundColor ??
        tfTheme?.disabledBackgroundColor ??
        colors.disabled;
    final resolvedBg = (widget.disabled || widget.readOnly)
        ? resolvedDisabledBg
        : widget.backgroundColor ?? tfTheme?.backgroundColor;
    final resolvedPlaceholderColor = widget.placeHolderColor ??
        tfTheme?.placeholderColor ??
        colors.inactive;
    final resolvedTextColor = widget.disabled
        ? widget.disabledTextColor ??
            tfTheme?.disabledTextColor ??
            colors.inactive
        : widget.textColor ?? tfTheme?.textColor ?? colors.onSurface;
    final resolvedBorderColor =
        widget.borderColor ?? tfTheme?.borderColor ?? colors.divider;
    final resolvedFocusBorderColor = widget.focusBorderColor ??
        tfTheme?.focusBorderColor ??
        resolvedBorderColor;
    final resolvedErrorBorderColor =
        widget.errorBorderColor ?? tfTheme?.errorBorderColor ?? colors.error;
    final resolvedClearIconColor = widget.disabled
        ? widget.disabledClearIconColor ??
            tfTheme?.disabledClearIconColor ??
            colors.inactive
        : widget.clearIconColor ??
            tfTheme?.clearIconColor ??
            colors.onSurface.withValues(alpha: 0.6);

    final resolvedTextStyle = widget.textStyle ??
        tfTheme?.textStyle ??
        theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.normal);

    // Build suffix icon area
    final suffixIconWidget = Container(
      margin: EdgeInsets.only(right: resolvedContentPadding.right),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.suffixIcon != null) widget.suffixIcon!,
          if (widget.enableClearButton && _showClearButton)
            GestureDetector(
              onTap: () {
                _clear();
                widget.onClearPressed?.call();
              },
              child: widget.clearIcon ??
                  Icon(Icons.clear_rounded, color: resolvedClearIconColor),
            ),
        ],
      ),
    );

    return TextField(
      controller: _textController,
      focusNode: _textFieldFocusNode,
      autofocus: widget.autofocus,
      enabled: !widget.disabled,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      scrollPadding: EdgeInsets.zero,
      style: resolvedTextStyle.copyWith(
        decoration: TextDecoration.none,
        color: resolvedTextColor,
        decorationThickness: 0,
      ),
      textAlign: widget.textAlign,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      obscureText: widget.obscureText,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: suffixIconWidget,
        prefixIconConstraints: widget.prefixIconConstraints,
        suffixIconConstraints: widget.suffixIconConstraints,
        isDense: true,
        isCollapsed: true,
        fillColor: resolvedBg,
        filled: true,
        contentPadding: resolvedContentPadding,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        counter: widget.counterWidget,
        counterText: widget.counterText,
        counterStyle:
            widget.counterText != null && widget.counterText!.isNotEmpty
                ? widget.countTextStyle
                : null,
        error: widget.errorWidget,
        errorText: widget.errorText,
        errorStyle: widget.errorText != null && widget.errorText!.isNotEmpty
            ? widget.errorTextStyle
            : null,
        hintText: widget.placeHolder,
        hintStyle:
            widget.placeHolder != null && widget.placeHolder!.isNotEmpty
                ? resolvedTextStyle.copyWith(
                    decoration: TextDecoration.none,
                    color: resolvedPlaceholderColor,
                  )
                : null,
        border: _buildBorder(
          widget.onlyUnderline,
          resolvedBorderRadius,
          resolvedBorderColor,
          resolvedBorderWidth,
        ),
        enabledBorder: _buildBorder(
          widget.onlyUnderline,
          resolvedBorderRadius,
          resolvedBorderColor,
          resolvedBorderWidth,
        ),
        focusedBorder: _buildBorder(
          widget.onlyUnderline,
          resolvedBorderRadius,
          resolvedFocusBorderColor,
          resolvedBorderWidth,
        ),
        errorBorder: _buildBorder(
          widget.onlyUnderline,
          resolvedBorderRadius,
          resolvedErrorBorderColor,
          resolvedBorderWidth,
        ),
        focusedErrorBorder: _buildBorder(
          widget.onlyUnderline,
          resolvedBorderRadius,
          resolvedErrorBorderColor,
          resolvedBorderWidth,
        ),
      ),
      onTap: widget.onTap,
      onChanged: _textFieldOnChanged,
      onSubmitted: _textFieldOnSubmitted,
      onEditingComplete: widget.onEditingComplete,
    );
  }

  // --- Border builder helper ---

  InputBorder _buildBorder(
    bool onlyUnderline,
    double radius,
    Color color,
    double width,
  ) {
    final borderSide = BorderSide(
      color: width == 0.0 ? Colors.transparent : color,
      width: width,
    );
    final borderRadius = BorderRadius.circular(radius);

    if (onlyUnderline) {
      return UnderlineInputBorder(
        borderSide: borderSide,
        borderRadius: borderRadius,
      );
    }
    return OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: borderRadius,
    );
  }

  // --- Text manipulation ---

  void _setTextEditingValue(String text) {
    if (context.mounted) {
      _textController.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(
          offset: text.isEmpty ? -1 : text.length,
        ),
      );
    }
  }

  String _textCutString(String text) {
    final maxLength = widget.maxLength ?? 0;
    if (text.length > maxLength && maxLength != 0) {
      return text.substring(0, maxLength);
    }
    return text;
  }

  // --- Callbacks ---

  void _textFieldOnChanged(String value) {
    if (context.mounted && widget.maxLines == 1) {
      setState(() => _showClearButton = value.isNotEmpty);
    }

    if (widget.maxLength != null) {
      if (value.length <= widget.maxLength!) {
        _prevText = value;
      } else {
        if (_prevText.isEmpty) {
          _prevText = _textCutString(value);
        }
        _setTextEditingValue(_prevText);
      }
      widget.onChanged?.call(_prevText);
      return;
    }

    widget.onChanged?.call(value);
  }

  void _textFieldOnSubmitted(String value) {
    widget.onSubmitted?.call(value.trim());
  }

  void _clear() {
    _textController.clear();
    final clearedText = _textController.text.trim();
    widget.onChanged?.call(clearedText);
    if (clearedText.isNotEmpty) {
      widget.onSubmitted?.call(clearedText);
    }
    if (context.mounted) {
      setState(() => _showClearButton = false);
    }
  }

  void _reset() {
    _clear();
    _textFieldFocusNode.hasFocus;
  }

  // --- Listeners ---

  void _onControllerNotify() {
    final controller = widget.controller;
    switch (controller.status) {
      case LFTextFieldStatusV2.reset:
        _reset();
      case LFTextFieldStatusV2.clear:
        _clear();
      case LFTextFieldStatusV2.setText:
        text = controller.value ?? '';
      case LFTextFieldStatusV2.none:
        controller.value = null;
    }
  }

  void _onControllerInput() {}

  void _onFocusChanged() {
    widget.onFocusChanged?.call(_textFieldFocusNode.hasFocus);
  }
}
