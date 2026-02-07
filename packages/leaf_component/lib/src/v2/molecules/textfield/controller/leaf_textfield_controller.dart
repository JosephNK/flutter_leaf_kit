import 'package:flutter/widgets.dart';

/// Status values for programmatic control of [LeafTextFieldController].
enum LeafTextFieldStatus { none, clear, reset, setText }

/// A controller for programmatic manipulation of V2 text fields.
///
/// Standalone V2 version — no dependency on V1.
/// API-compatible with the V1 `LFTextFieldController`.
class LeafTextFieldController extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();

  LeafTextFieldStatus status = LeafTextFieldStatus.none;

  String? value;
  String get text => controller.text;

  set text(String value) {
    this.value = value;
    status = LeafTextFieldStatus.setText;
    notifyListeners();
  }

  void reset() {
    status = LeafTextFieldStatus.reset;
    notifyListeners();
    none();
  }

  void clear() {
    status = LeafTextFieldStatus.clear;
    notifyListeners();
    none();
  }

  void none() {
    status = LeafTextFieldStatus.none;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
