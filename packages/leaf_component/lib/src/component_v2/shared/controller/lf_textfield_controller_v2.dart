import 'package:flutter/widgets.dart';

/// Status values for programmatic control of [LFTextFieldControllerV2].
enum LFTextFieldStatusV2 { none, clear, reset, setText }

/// A controller for programmatic manipulation of V2 text fields.
///
/// Standalone V2 version — no dependency on V1.
/// API-compatible with the V1 `LFTextFieldController`.
class LFTextFieldControllerV2 extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();

  LFTextFieldStatusV2 status = LFTextFieldStatusV2.none;

  String? value;
  String get text => controller.text;

  set text(String value) {
    this.value = value;
    status = LFTextFieldStatusV2.setText;
    notifyListeners();
  }

  void reset() {
    status = LFTextFieldStatusV2.reset;
    notifyListeners();
    none();
  }

  void clear() {
    status = LFTextFieldStatusV2.clear;
    notifyListeners();
    none();
  }

  void none() {
    status = LFTextFieldStatusV2.none;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
